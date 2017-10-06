#!/usr/bin/env python
'''
Package providing helper classes and functions for performing graph search operations for planning.
'''
import numpy as np
import matplotlib.pyplot as plotter
from math import pi
from collisions2 import PolygonEnvironment
import time

_DEBUG = False

_TRAPPED = 'trapped'
_ADVANCED = 'advanced'
_REACHED = 'reached'

class TreeNode:
    def __init__(self, state, direction=0, iter_t=0.01, parent=None, cost=1):
        self.state = state
        self.children = []
        self.parent = parent
        # if state[0]<50 and state[1]<100 and state[0]>15 and state[1]>40:
        #     cost=10
        self.cost = cost
        self.iter_t = iter_t
        self.acc = direction/np.linalg.norm(direction)*100
        self.vel = 0
        #print cost
        
    def add_child(self, child):
        self.children.append(child)

class RRTSearchTree:
    def __init__(self, init):
        self.root = TreeNode(init, cost=1)
        self.root.vel = 0
        self.nodes = [self.root]
        self.edges = []

    def find_nearest(self, s_query):
        min_cost = 1000000
        nn = self.root
        for n_i in self.nodes:
            cost = np.linalg.norm(s_query - n_i.state)*n_i.cost
            if cost < min_cost:
                nn = n_i
                min_cost = cost
                dis=np.linalg.norm(s_query - n_i.state)
        return (nn, dis)

    def add_node(self, node, parent):
        self.nodes.append(node)
        self.edges.append((parent.state, node.state))
        node.parent = parent
        parent.add_child(node)

    def get_states_and_edges(self):
        states = np.array([n.state for n in self.nodes])
        return (states, self.edges)

    def get_back_path(self, n):
        path = []
        while n.parent is not None:
            path.append(n.state)
            n = n.parent
        path.reverse()
        return path

class RRT:

    def __init__(self, num_samples, num_dimensions, step_length, bias, collision_func, cost_check_func, lims = None):
        '''
        Initialize an RRT planning instance
        '''
        self.K = num_samples
        self.n = num_dimensions
        self.epsilon = step_length
        self.bias=bias

        self.in_collision = collision_func
        self.cost_check = cost_check_func
        if collision_func is None:
            self.in_collision = self.fake_in_collision
            
        # Setup range limits
        self.limits = lims
        if self.limits is None:
            self.limits = []
            for n in xrange(num_dimensions):
                self.limits.append([0,100])
            self.limits = np.array(self.limits)
        self.ranges = self.limits[:,1] - self.limits[:,0]
        self.found_path = False
        
    def build_rrt(self, init, goal):
        '''
        Build the rrt from init to goal
        Returns path to goal or None
        '''
        self.goal = np.array(goal)
        self.init = np.array(init)
        self.found_path = False
        path = []
        
        # Build tree and search
        self.T = RRTSearchTree(init)
        vel_limit=self.epsilon/0.01
        acc_limit=self.epsilon/0.01
        for x in range(0, self.K):
            self.new_sample=self.sample()
            (self.parent_node, dis)=self.T.find_nearest(self.new_sample)
            new_state = self.parent_node.state+(self.new_sample-self.parent_node.state)/dis*self.epsilon
            new_cost = self.cost_check(new_state)
            direction = self.new_sample-self.parent_node.state
            new_node=TreeNode(new_state, direction, cost=new_cost)
            new_node.vel = vel_limit*direction/np.linalg.norm(direction)
            if np.linalg.norm(new_node.vel-self.parent_node.vel)>acc_limit:
                continue
            new_node.state = self.parent_node.state + new_node.vel*new_node.iter_t
            line_collosion_check = False
            for seperate in range(5):
                seperate += 1
                temp_state = self.parent_node.state+(new_node.state-self.parent_node.state)*seperate/5
                if self.in_collision(temp_state) is True:
                    line_collosion_check = True
            if line_collosion_check is False:
                self.T.add_node(new_node, self.parent_node)
            if np.linalg.norm(new_node.state-self.goal)<self.epsilon:
                print 'found'
                goal_node=TreeNode(self.goal,cost=1)
                self.T.add_node(goal_node,new_node)
                path=self.T.get_back_path(goal_node)
                return path
        return None

    def constriant(self, new_node, parent_node):
        aaa = np.linalg.norm(new_node.vel*new_node.iter_t)
        if self.epsilon <= aaa:
            return True
        else:
            return False

    def sample(self):
        '''
        Sample a new configuration and return
        '''
        # Return goal with connect_prob probability
        self.rand=np.random.uniform(0,1)
        if self.rand<self.bias:
            self.new_sample=self.goal
        else:
            if self.n==2:
                self.new_sample=[np.random.uniform(0,1),np.random.uniform(0,1)]
                self.new_sample=[self.new_sample[0]*self.ranges[0]+self.limits[0,0],self.new_sample[1]*self.ranges[1]+self.limits[1,0]]
            else:
                self.new_sample=[np.random.uniform(0,1),np.random.uniform(0,1),np.random.uniform(0,1)]
                self.new_sample=[self.new_sample[0]*self.ranges[0]+self.limits[0,0],self.new_sample[1]*self.ranges[1]+self.limits[1,0],self.new_sample[2]*self.ranges[2]+self.limits[2,0]]
        return (self.new_sample)

    def fake_in_collision(self, q):
        '''
        We never collide with this function!
        '''        
        return None

def test_rrt_env(start, goal, num_samples, step_length, bias, env, connect, bidirectional):
    '''
    create an instance of PolygonEnvironment from a description file and plan a path from start to goal on it using an RRT

    num_samples - number of samples to generate in RRT
    step_length - step size for growing in rrt (epsilon)
    env - path to the environment file to read
    connect - If True run rrt_connect

    returns plan, planner - plan is the set of configurations from start to goal, planner is the rrt used for building the plan
    '''
    pe = PolygonEnvironment ()
    if pe.read_env(env) == False:
        print 'Goal Point or Start Point not set. Failed to start RRT.'
        return False
    dims = len(pe.start)
    start_time = time.time()
    # pe.start=start
    # pe.goal=goal

    rrt = RRT(num_samples,
              dims,
              step_length,
              bias,
              collision_func=pe.test_collisions,
              cost_check_func=pe.check_cost,
              lims = pe.lims)
    if connect:
        plan = rrt.build_rrt_connect(pe.start, pe.goal)
    else:
        if bidirectional:
            plan = rrt.build_rrt_bidirectional(pe.start, pe.goal)
        else:
            plan = rrt.build_rrt(pe.start, pe.goal)
    run_time = time.time() - start_time
    print 'run_time =', run_time
    if plan is not None:
        planFile = open('plan.txt','w')
        for element in plan:
            aaa = element.tolist()
            planFile.write(str(aaa[0])+" "+str(aaa[1])+"\n")
            # planFile.write(str(aaa[1]))
            # planFile.write("\n")
        planFile.close()
    pe.draw_plan(plan,rrt)
    return plan, rrt
start=np.array([-50,50])
goal=np.array([75,80])
#start=np.array([0,0,0])
#goal=np.array([-0.4, -0.15, -0.3])
test_rrt_env(start, goal, num_samples=50000, step_length=0.1,bias=0.6, env='./Map_Highresolution.dat', connect=False, bidirectional=False)