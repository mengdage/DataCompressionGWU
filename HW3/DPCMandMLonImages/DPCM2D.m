function [cpX] = DPCM2D(X, abcset)
    a = abcset(1);
    b = abcset(2);
    c = abcset(3);
    sizeX = size(X);
    X = double(X);
    cpX = X;
    % deal with the first elemets
    cpX(1,1) = X(1,1);
    % deal with the first row except the first elements
    for j = 2:sizeX(2),
        cpX(1,j) = X(1,j)-X(1,j-1);
    end
    
    % deal with the first column except the first elements
    for i = 2:sizeX(1),
        cpX(i, 1) = X(i,1)-X(i-1, 1);
    end
    
    % deal with the rest elements
    for i = 2:sizeX(1),
        for j =2:sizeX(2),
            cpX(i, j) = floor(X(i,j)- (a*X(i, j-1)+b*X(i-1, j-1)+c*X(i-1, j)));
            %cpX(i, j) = floor(X(i,j)- (a*X(i, j-1)+b*X(i-1, j-1)+c*X(i-1, j)));
        end
    end
end