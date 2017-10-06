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
% Author:   Stefan Hüeber

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
y = linspace(0,1,2*n);
p_spl = DEBOOR(T,p,y,order);
plot(p_spl(:,1),p_spl(:,2),'b-','LineWidth',1);
plot(p_spl(:,1),p_spl(:,2),'ro','MarkerSize',2,'MarkerFaceColor','b');

fileID = fopen('smoothedPlan.txt','w');
fprintf(fileID,'%12.8f %12.8f\n',p_spl);
fclose(fileID);

title(['B-Spline-curve with ',num2str(n),' control points of order ',num2str(order)]);