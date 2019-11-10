function [U x t] = Duford(c,a_x,b_x,a_t,b_t,h,k,ic,bc_1,bc_2)
s = c*(k/(h^2));          %lambda = k/h^2;

x = [a_x:h:b_x];    %Discretize space
t = [a_t:k:b_t];    %Discretize time range
n = length(t);
m = length(x);
U = zeros(n,m);
U(1,:) = ic(x);
for i=2:n
    U(i,1) = bc_1(t(i));
    U(i,m) = bc_2(t(i));
    for j=2:m-1
        if i==2
        U(i,j) = s*U(i-1,j-1) + (1 - 2*s)*U(i-1,j) + s*U(i-1,j+1);
        else
        U(i,j) = (1-2*s)*U(i-2,j) + 2*s*U(i-1,j+1) + 2*s*U(i-1,j-1);
        U(i,j) = U(i,j)/(1+2*s);
        end
    end
end

end