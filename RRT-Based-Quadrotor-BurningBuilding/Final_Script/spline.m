function spline()

% function spline(n,order)
%
% Plots the B-slpine-curve of n control-points.
% The control points can be chosen by clicking
% with the mouse on the figure.
%
% COMMAND:  spline(n,order)
% INPUT:    n     Number of Control-Points
%           order Order ob B-Splines
%                 Argnument is arbitrary
%                 default: order = 4
%
% Date:     2007-11-28
% Author:   Stefan H�eber

close all;

figure(1);
hold on; box on;
set(gca,'Fontsize',16);

order =4;

%p = [  -40.00516429154979, 50.321339635103634 ;  -22.942510770559274, 39.96677430322078; -15.53517505990456, 33.2487851941451; -13.468895425803925, 23.464589341970996 ; -4.358802605707208, 19.340730856374982]; 


fileID = fopen('plan.txt','r');

data = fscanf(fileID,'%f');
fclose(fileID);
xCoordinates = 1 : 2 : length(data);
yCoordinates = 2 : 2 : length(data);

for i = 1:length(xCoordinates)
    p(i,1) = data(xCoordinates(i))

end

for i = 1:length(yCoordinates)
    p(i,2) = data(yCoordinates(i))

end
n = size(p,1);

    
	hold off;
	plot(p(:,1),p(:,2),'k-','LineWidth',1);
	axis([-6 6 -6 6]);
	hold on; box on;
	
	plot(p(:,1),p(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');

T = linspace(0,1,n-order+2);
y = linspace(0,1,20*n);
p_spl = DEBOOR(T,p,y,order);
plot(p_spl(:,1),p_spl(:,2),'b-','LineWidth',1);
plot(p_spl(:,1),p_spl(:,2),'ro','MarkerSize',2,'MarkerFaceColor','b');
p_spl
save('smoothedPlan.txt','p_spl','-ascii');
% fileID = fopen('smoothedPlan.txt','w');
% fprintf(fileID,'%12.8f %12.8f\n',p_spl);
% fclose(fileID);

title(['B-Spline-curve with ',num2str(n),' control points of order ',num2str(order)]);

clear all;
close all;

step = 0.01;

[x,y] = textread('smoothedPlan.txt','%f %f');

Y_r1 = gradient(y)/step;
Y_r2 = gradient(Y_r1)/step;

X_r1 = gradient(x)/step;
X_r2 = gradient(X_r1)/step;

% figure(1);hold on;plot(x);plot(X_r1);plot(X_r2);legend('fil','r1','r2');
% 
for i = 1 : length(x)
    theta(i) = -atan2(X_r2(i),9.8)*57.3;
    fi(i) = atan2(Y_r2(i)*cos(theta(i)),9.8)*57.3;
    F(i)=9.8/(cos(fi(i))*cos(theta(i)));
end
theta = theta';
fi = fi';

data = [x, y, theta, fi]
save('pose_attitude.txt','data','-ascii');
% filewrite = fopen('pose_attitude.txt','w');
% fprintf(filewrite,data);
% fclose(filewrite);

figure(2);hold on;plot(theta);plot(fi);%plot(F);legend('theta','fi','F')
