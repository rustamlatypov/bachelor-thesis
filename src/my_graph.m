%------------------------------------------------------------
% Construct matrices V and E, correspoding to the nodes
% and edges of the resistor graph.
% (Section 2.1)
%------------------------------------------------------------

function [V,E] = my_graph(n)

V = zeros(n);
E = zeros(2*(n-2)*(n-1),2);
k = 1;

for i = 2:n-1
    V(1,i) = k;
    V(i,n) = k+(n-2);
    k = k + 1;
end

k = k + (n-2);

for i = fliplr(2:n-1)
    V(n,i) = k;
    V(i,1) = k+(n-2);
    k = k + 1;
end

k = k + (n-2);

for i = 2:n-1
    for j = 2:n-1
        V(i,j) = k;
        k = k + 1;
    end
end

k = 1;
for i = 2:(n-1)
    for j = 1:(n-1)
        E(k,:) = [V(i,j),V(i,j+1)];
        E(k+(n-1)*(n-2),:) = [V(j,i),V(j+1,i)];
        k = k + 1;
    end
end

end
