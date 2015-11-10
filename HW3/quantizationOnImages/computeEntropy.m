function [H] = computeEntropy(X, c)
    X = double(X);
    if min(X(:)) == 0,
        X = X+1;
    end
    sizeX = size(X);

    f = zeros(c,1);
    for i = 1:sizeX(1),
        for j = 1:sizeX(2),
            f(X(i,j)) = f(X(i,j))+1;
        end
    end

    % probability distribution
    p = f./sum(f);
    % the self information for each color
    SelfX = -log2(p);
    % the entropy of this picture
    H = sum(p.*SelfX);
end