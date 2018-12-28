%------------------------------------------------------------
% Compute the derivative of the responce matrix.
% (Section 5.2)
%------------------------------------------------------------

function out = dF(n,e,g,I,IN,SP)

G = g_matrix(n,e,g);
G = G(2:end,2:end);

k = 4*(n-2);

I_dim = [eye(k-1); zeros(n^2-4-k,k-1)];

R_t = I_dim\inv(G);
R = G\I_dim;

c_hat = R*I;

%
G_ref = g_matrix(n,e,[1:2*(n-2)*(n-1)]);
G = G_ref(2:end,2:end);
C = [];

for i = 1:size(G,2)
    for j = 1:size(SP{i},2)
        C(i,SP{i}(j)) = c_hat(i) - c_hat(IN{i}(j));
    end
end

C(k,G_ref(1,1)) = c_hat(k);
%

out = R_t*C;

end