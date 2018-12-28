%------------------------------------------------------------
% Construct the Kirchhoff matrix for further computations.
% (Section 3.1)
%------------------------------------------------------------

function G = g_matrix(n,e,g)

nodes = n^2-4;
G = zeros(nodes);
edges = 2*(n-2)*(n-1);

for i = 1:edges
    G(e(i,1),e(i,2)) = -g(i);
    G(e(i,2),e(i,1)) = -g(i);
end

for i = 1:nodes
    G(i,i) = -sum(G(i,:));
end

end

