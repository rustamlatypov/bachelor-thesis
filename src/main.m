clear
close all

%------------------------------------------------------------
% SET GRAPH PARAMETERS AND INITIALIZE POINT SOURCE(S)
%------------------------------------------------------------

load('my_random.mat')
n = 24;
g_size = 2*(n-2)*(n-1);
[v,e] = my_graph(n);
g_o = ones(1,g_size)';

% % indices for n = 24, g_size ~1000, point source
% hot = [747 242 748 241];
% mild = [723 746 769 220 243 266 772 749 726 263 240 217 218 219 770 771 265 264 725 724];
% chill = [699 722 745 768 791 198 221 244 267 290 796 773 750 727 704 285 262 239 216 193 
% 194 195 196 197 792 793 794 795 289 288 287 286 703 702 701 700];

% indices for n = 24, g_size ~1000, multiple (3) sources
hot = [310 311 774 775 357 356 729 728 751 334 752 333 98 627 121 604 110 111 134 133 903];
mild = [727 750 773 312 335 358 776 753 730 355 332 309 603 626 99 122 628 605 120 97 879 ...
    902 925 926 927 904 881 880];
chill = [286 287 288 289 796 797 798 799 381 380 379 378 707 706 705 704 74 75 76 649 650 ...
    651 145 144 143 582 581 580 86 87 88 89 112 135 158 157 156 155 132 109];

for i = hot
    g_o(i) = 0.7;
end
for i = mild
    g_o(i) = 0.8;
end
for i = chill
    g_o(i) = 0.9;
end

%------------------------------------------------------------
% COMPUTE BOUNDARY POTENTIAL AND CURE SINGULARITY
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

G_r = g_matrix(n,e,1:g_size);
G_r = G_r(2:end,2:end);
for i = 1:size(G_r,2)
    [~,m,v] = find(G_r(i,:));
    IN{i} = m(G_r(i,m)<0);
    SP{i} = -v(v<0);
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
        DF = vertcat(DF, -dF(n,e,g,I(:,k),IN,SP));
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
