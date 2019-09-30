clear all;
clf;
clc;

%(a)
lambda = -5;
f = @(t,y) lambda*y + (1-lambda)*cos(t) - (1+lambda)*sin(t);
actual_y = @(t) sin(t)+cos(t);
a = 0;
b = 10;
h = 1e-2;
alpha = 1;
fprintf('lambda = -5, h = 0.01\n');
explicit_euler(a,b,f,h,alpha,actual_y,1);
implicit_euler(a,b,f,h,alpha,actual_y,3);
%lambda = -5 ,h = 0.001
h = 1e-3;
fprintf('lambda = -5, h= 0.001\n');
explicit_euler(a,b,f,h,alpha,actual_y,5);
implicit_euler(a,b,f,h,alpha,actual_y,7);

%lambda = -5 h = 0.005
h = 5*1e-3;
fprintf('lambda = -5, h= 0.005\n');
explicit_euler(a,b,f,h,alpha,actual_y,9);
implicit_euler(a,b,f,h,alpha,actual_y,11);
%lambda = -5 h = 0.0025
h = 0.0025;
fprintf('lambda = -5, h= 0.0025\n');
explicit_euler(a,b,f,h,alpha,actual_y,13);
implicit_euler(a,b,f,h,alpha,actual_y,15);

%(b)
%lambda = 5 ,h = 0.01
h = 0.01;
lambda = 5;
f = @(t,y) lambda*y + (1-lambda)*cos(t) - (1+lambda)*sin(t);
fprintf('lambda = 5, h= 0.01\n');
explicit_euler(a,b,f,h,alpha,actual_y,17);
implicit_euler(a,b,f,h,alpha,actual_y,19);

%lamda = 5 , h = 0.001
h = 0.001;
fprintf('lambda = -5, h= 0.001\n');
explicit_euler(a,b,f,h,alpha,actual_y,21);
implicit_euler(a,b,f,h,alpha,actual_y,23);

%%functions
function [y,error,t] = explicit_euler(a,b,f,h,alpha,actual_y,fig_no)
t = [a:h:b];
y(1) = alpha;
N = length(t);
error(1) = abs(y(1)-actual_y(t(1)));
%fprintf('%s\t\t%s\t%s\t\t%s\n','t(i)','y_appx(i)','y_actual(t(i))','error(i)');
%fprintf('%f\t%f\t%f\t%f\n',t(1),y(1),actual_y(t(1)),error(1));
for i=2:N
    y(i) = y(i-1) + h*f(t(i-1),y(i-1));
    error(i) = abs(y(i)-actual_y(t(i)));
    %fprintf('%f\t%f\t%f\t%f\n',t(i),y(i),actual_y(t(i)),error(i));
end
figure(fig_no);
plot(t,error);
xlabel('t(i)');
ylabel('error(i)');

figure(fig_no+1);
plot(t,y,'--','linewidth',2);
hold on;
t = a:h:b;
sol = actual_y(t);

plot(t,sol,'linewidth',2);

end

function implicit_euler(a,b,f,h,alpha,actual_y,fig_no)
t = [a:h:b];
y(1) = alpha;
N = length(t);
error(1) = abs(y(1)-actual_y(t(1)));
%fprintf('%s\t\t%s\t%s\t\t%s\n','t(i)','y_appx(i)','y_actual(t(i))','error(i)');
%fprintf('%f\t%f\t%f\t%f\n',t(1),y(1),actual_y(t(1)),error(1));
for i=2:N
    y_prev = y(i-1);
    y_new = y(i-1)+10;
    diff = abs(y_new-y_prev);
    
    while(diff > 1e-8)
        y_new = y_prev + h*f(t(i-1),y_prev);
        diff = abs(y_new - y_prev);
        y_prev =  y_new;
    end
    y(i) = y_new;
    error(i) = abs(y(i)-actual_y(t(i)));
    %fprintf('%f\t%f\t%f\t%f\n',t(i),y(i),actual_y(t(i)),error(i));
end
figure(fig_no);
plot(t,error);
xlabel('t(i)');
ylabel('error(i)');

figure(fig_no+1);
plot(t,y,'--','linewidth',2);
hold on;
t = a:h:b;
sol = actual_y(t);

plot(t,sol,'linewidth',2);
fprintf('\n');
end

