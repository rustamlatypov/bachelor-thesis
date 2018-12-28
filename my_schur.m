%------------------------------------------------------------
% Compute the Schur complement in the Kirchhoff matrix
% to obtain the responce matrix.
% (Sections 3.2, 3.3)
%------------------------------------------------------------

function S = my_schur(n,G)

k = 4*(n-2);
k = k - 1;
 
A = G(1:k, 1:k);
B = G(1:k, (k+1):end);
C = B';
D = G((k+1):end,(k+1):end);

S = A - B*(D\C);

end