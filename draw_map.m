%------------------------------------------------------------
% Compute the continuous heat map representation of the
% descrete results obtained by the Gauss-Newton algorithm.
% (Chapter 7)
%------------------------------------------------------------

function out = draw_map(n,g)

m = 2*(n-1)-1;
A = zeros(m,m);

k = 1;
for i = 1+1:2:m
    for j = 1:2:m
        A(i,j) = g(k);
        A(j,i) = g(k+(n-2)*(n-1));
        k = k+1;
    end
end

for i = 2:m-1
    for j = 2:m-1
        if A(i,j) == 0
            n = [A(i+1,j) A(i-1,j) A(i,j+1) A(i,j-1)];
            A(i,j) = mean(n);
        end
    end
end

for i = 2:m-1
    if A(i,1) == 0
        n = [A(i-1,1) A(i+1,1)];
        A(i,1) = mean(n);
    end
    if A(1,i) == 0
        n = [A(1,i-1) A(1,i+1)];
        A(1,i) = mean(n);
    end
    if A(i,end) == 0
        n = [A(i-1,1) A(i+1,1)];
        A(i,end) = mean(n);
    end
    if A(end,i) == 0
        n = [A(1,i-1) A(1,i+1)];
        A(end,i) = mean(n);
    end
end
A(1,1) = mean([A(1,2) A(2,1)]);
A(1,end) = mean([A(1,end-1) A(2,end)]);
A(end,1) = mean([A(end-1,1) A(end,2)]);
A(end,end) = mean([A(end,end-1) A(end-1,end)]);

[X,Y] = meshgrid(1:m,1:m);
out = surf(X,Y,A);

end
