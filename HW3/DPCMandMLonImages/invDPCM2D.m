function [iX] = invDPCM2D(X, abcset)
    a = abcset(1);
    b = abcset(2);
    c = abcset(3);
    sizeX = size(X);
    X = double(X);
    iX = X;
    % deal with the first elemets
    iX(1,1) = X(1,1);
    % deal with the first row except the first elements
    for j = 2:sizeX(2),
        iX(1,j) = X(1,j)+iX(1,j-1);
    end
    
    % deal with the first column except the first elements
    for i = 2:sizeX(1),
        iX(i, 1) = X(i,1)+iX(i-1, 1);
    end
    
    % deal with the rest elements
    for i = 2:sizeX(1),
        for j =2:sizeX(2),
            iX(i, j) = X(i,j) + (a*iX(i, j-1)+b*iX(i-1, j-1)+c*iX(i-1, j));
        end
    end
end