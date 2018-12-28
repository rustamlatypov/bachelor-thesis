%------------------------------------------------------------
% Compute the custom laplacian operator matrix for the graph.  
% (Sections 5.4)
%------------------------------------------------------------

function L = my_laplacian(n, g)

s = size(g,1);
L = zeros(s);
columns = n - 1;
rows = n - 2;

for i = 1:s
    if mod(i,columns) ~= 0 && mod(i,columns) ~= 1
        column = mod(i,columns) - 2;
        elem = floor(i/columns) + 1;
        if i <= columns*rows
            u1 = columns*rows + column*columns + elem;
        else
            u1 = column*columns + elem - rows;
        end
        u2 = u1 + 1;
        u3 = u1 + columns;
        u4 = u3 + 1;
        insert = [u1 u2 u3 u4];
    else
        if i <= columns*rows
            elem = floor(i/columns) + 1;
            if mod(i,columns) == 1
                u1 = columns*rows + elem;
                u2 = u1 + 1;
            else
                u1 = (columns*rows*2 - columns) + elem - 1;
                u2 = u1 + 1;
            end
        else
            elem = floor(i/columns) - rows;
            if mod(i,columns) == 1
                u1 = elem + 1;
                u2 = elem + 2;
            else
                u1 = (columns*rows - columns) + elem;
                u2 = u1 + 1;
            end
        end
        insert = [u1 u1 u2 u2];
    end
    for j = insert
        L(i,j) = L(i,j) - 1;
    end
        L(i,i) = 4;
end 
end

    