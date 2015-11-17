function dX = JPEGDequantization(X, counterlv, DCrs, ACrs)
sizeX = size(X);
X= double(X);
dX = X;

% compute the num of row blocks and column blocks
numRowBlock = sizeX(1)/8;
numColumnBlock = sizeX(2)/8;

% DC dequantization
DCX = zeros(numRowBlock, numColumnBlock);
for bi = 1: numRowBlock,
    for bj = 1:numColumnBlock,
        DCX(bi, bj) = X( (bi-1)*8+1, (bj-1)*8+1 );
    end
end

DCX = dequantize2D(DCX, DCrs);

% AC dequantization
if counterlv == 1,
	for bi = 1: numRowBlock,
        for bj = 1:numColumnBlock,
            dX(  ((bi-1)*8+1):(bi*8) , ((bj-1)*8+1):(bj*8) ) = dX(  ((bi-1)*8+1):(bi*8) , ((bj-1)*8+1):(bj*8) )*0;
            dX((bi-1)*8+1, (bj-1)*8+1) = DCX(bi, bj);
        end
    end
else
    for bi = 1: numRowBlock,
        for bj = 1:numColumnBlock,
            [dX(  ((bi-1)*8+1):(bi*8) , ((bj-1)*8+1):(bj*8) )] = ACDequan(...
                X( ((bi-1)*8+1):(bi*8),((bj-1)*8+1):(bj*8) ), counterlv, ACrs(bi, bj,:));
            dX((bi-1)*8+1, (bj-1)*8+1) = DCX(bi, bj);
        end
    end
end
end