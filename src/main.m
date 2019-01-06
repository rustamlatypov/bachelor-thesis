clear
close all

%------------------------------------------------------------
% SET GRAPH PARAMETERS AND INITIALIZE POINT SOURCE(S)
%------------------------------------------------------------

load('my_random.mat')
n = 24;
g_size = 2*(n-2)*(n-1);
[v,e] = my_graph(n);

% second parameter: 1 for one heat source, 3 for three sources
g_o = heat_source(g_size, 3);

%------------------------------------------------------------
% COMPUTE BOUNDARY POTENTIAL 
%------------------------------------------------------------

b_nodes = 4*(n-2)-1;
I = 100*eye(b_nodes);
G = g_matrix(n,e,g_o);
G = G(2:end,2:end);
S = my_schur(n,G);

U = [];
for i = 1:b_nodes
    U = vertcat(U, S\I(:,i));
end

%------------------------------------------------------------
% SET PARAMETERS FOR MAIN LOOP AND INITIALIZE UNIFORM GUESS
%------------------------------------------------------------

g = 1*ones(1,g_size)';
h = 1;
L = my_laplacian(n,g) * 1/h^2;

U = U + my_random;
alpha = 1;
itr = 3;

%------------------------------------------------------------
% MAIN LOOP OF EXECUTION, GAUSS-NEWTON OPTIMIZATION
%------------------------------------------------------------

for i = 1:itr
    U_i = []; DF = [];
    for k = 1:b_nodes
        U_i = vertcat(U_i, F(n,e,g,I(:,k)));
        DF = vertcat(DF, -dF(n,e,g,I(:,k)));
    end
    DF = [DF; sqrt(alpha)*L];
    dg = DF \ [U - U_i; -sqrt(alpha)*L*g];
    g = g + dg;
end

%------------------------------------------------------------
% DRAW SURFACE AND COMPUTE ERROR TERMS
%------------------------------------------------------------

draw_map(n,g)
gamma = norm(g_o - g)/norm(g_o)
gee = norm(U - U_i)/norm(U)
