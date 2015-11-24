function dX = JPEGDequantization(X, counterlv, DCrs, ACrs)
sizeX = size(X);
X= double(X);
dX = X;

% compute the num of row blocks and column blocks
numRowBlock = sizeX(1)/8;
numColumnBlock = sizeX(2)/8;


% DC dequantization
dX = DCDequan(X, numRowBlock, numColumnBlock, DCrs);


% AC dequantization

dX = ACDequan(dX, numRowBlock, numColumnBlock, counterlv, ACrs);
end