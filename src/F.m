%------------------------------------------------------------
% Compute the trivial forward problem.
% (Section 5.1)
%------------------------------------------------------------

function out = F(n,e,g,I)

G = g_matrix(n,e,g);
G = G(2:end,2:end);
S = my_schur(n,G);

out = S\I;

end