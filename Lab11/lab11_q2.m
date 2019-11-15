clc;
clear all;

%Elliptic PDEs
%Uxx + Uyy = 0;

%(a)
F = @(x,y) 0;
bc = @(x,y) BC_a(x,y);
a_x = 0;
b_x = 1;
a_y = 0;
b_y = 1;
h = 0.02;
k = 0.02;
exact_sol = @(x,y) x.*y;

fprintf('Q2(a)\n');
fprintf('\n\nGAUSS SEIDEL\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'a','Gauss Seidel');
Error_surface_plot(exact_sol,num_sol,x,y);
fprintf('\n\nJACOBI ELIMINATION\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'a','Jacobi');
Error_surface_plot(exact_sol,num_sol,x,y);

%(b)
F = @(x,y) x.^2 + y.^2;
bc = @(x,y) BC_b(x,y);
a_x = 0;
b_x = 1;
a_y = 0;
b_y = 1;
h = 0.02;
k = 0.02;
exact_sol = @(x,y) exp(pi.*x).*sin(pi.*y) +((x.*y).^2)/2;

fprintf('\n\nQ2(b)\n\n');
fprintf('\n\nGAUSS SEIDEL\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'b','Gauss Seidel');
Error_surface_plot(exact_sol,num_sol,x,y);
fprintf('\n\nJACOBI ELIMINATION\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'b','Jacobi');
Error_surface_plot(exact_sol,num_sol,x,y);


%(c)
F = @(x,y) 2.*x - y;
bc = @(x,y) BC_c(x,y);
a_x = 0;
b_x = 1;
a_y = 0;
b_y = 1;
h = 0.02;
k = 0.02;
exact_sol = @(x,y) 2.*x - y;
fprintf('\n\nQ2(c)\n\n');
fprintf('GAUSS SEIDEL\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'c','Gauss Seidel');
Error_surface_plot(exact_sol,num_sol,x,y);
fprintf('\n\nJACOBI ELIMINATION\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'c','Jacobi');
Error_surface_plot(exact_sol,num_sol,x,y);


%(d)

F = @(x,y) exp(x).*(2*cos(y) - sin(y));
bc = @(x,y) BC_d(x,y);
a_x = 0;
b_x = 1;
a_y = 0;
b_y = 1;
h = 0.02;
k = 0.02;
exact_sol = @(x,y) exp(x).*cos(y);
fprintf('\n\nQ2(d)\n\n');
fprintf('GAUSS SEIDEL\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'d','Gauss Seidel');
Error_surface_plot(exact_sol,num_sol,x,y);
fprintf('\n\nJACOBI ELIMINATION\n\n');
[num_sol x y] = five_point_scheme(a_x,b_x,a_y,b_y,h,k,bc,F,'d','Jacobi');
Error_surface_plot(exact_sol,num_sol,x,y);



function Error_plot(exact_sol,num_sol,x,y,a_x,a_y,h,k)
figure;
n = length(x);
plot(y,num_sol(:,n-1),'g+');
hold on;
plot(y,exact_sol(a_x+(n-1)*h,y));
xlabel('x')
s = sprintf('U(%0.2f,y)',a_x+(n-1)*h);
ylabel(s);
title('Comparison b/w Numerical and exact sol');
legend('Numerical Solution','Exact Solution');
end
function Error_surface_plot(exact_sol,num_sol,x,y)
figure;
[X Y] = meshgrid(x,y);
Error = abs(exact_sol(X,Y) - num_sol');
surf(X,Y,Error);
zlabel('Error');
xlabel('x');
ylabel('y');
figure;
surf(X,Y,exact_sol(X,Y));
title('Exact Solution');
figure;
surf(X,Y,num_sol');
title('Numerical Solution');


end
function f = BC_a(x,y)

if x==0 || y==0
    f = 0;
elseif x==1
    f = y;
elseif y==1
    f = x;
end

end
function f = BC_b(x,y)
if y==0
    f = 0;
elseif x==0
    f = sin(pi.*y);
elseif y==1
    f = (x.^2)/2;
else
    f = exp(pi).*sin(pi.*y) + (y.^2)./2;
end

end
function f = BC_c(x,y)
f = 0;
if y==0
    f = 2.*x;
elseif y==1
    f = 2.*x - 1;
elseif x==1
    f = 2 - y;    
end
end
function f = BC_d(x,y)
if y==0
    f = exp(x);
elseif x==0
    f = cos(y);
elseif y==1
    f = exp(x).*cos(1);
elseif x==1
    f = exp(1).*cos(y);
end
end

