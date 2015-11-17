function [qX, DCds, DCrs, ACds, ACrs] = JPEGQuantization(X, counterlv, qlv)
sizeX = size(X);
X= double(X);
qX = X;

% compute the num of row blocks and column blocks
numRowBlock = sizeX(1)/8;
numColumnBlock = sizeX(2)/8;

% DC quantization
DCX = zeros(numRowBlock, numColumnBlock);
for bi = 1: numRowBlock,
    for bj = 1:numColumnBlock,
        DCX(bi, bj) = X( (bi-1)*8+1, (bj-1)*8+1 );
    end
end
lv = 64;
[DCX, DCds, DCrs] = uniformQuantizer(DCX, lv);


% AC quantization
ACds = zeros(sizeX(1), sizeX(2), qlv+1);
ACrs = zeros(sizeX(1), sizeX(2), qlv);
if counterlv == 1,
    for bi = 1: numRowBlock,
        for bj = 1:numColumnBlock,
            
            qX(  ((bi-1)*8+1):(bi*8) , ((bj-1)*8+1):(bj*8) ) = qX(  ((bi-1)*8+1):(bi*8) , ((bj-1)*8+1):(bj*8) )*0;
            qX((bi-1)*8+1, (bj-1)*8+1) = DCX(bi, bj);
        end
    end
else
    for bi = 1: numRowBlock,
        for bj = 1:numColumnBlock,
            [qX(  ((bi-1)*8+1):(bi*8) , ((bj-1)*8+1):(bj*8) ), ACds(bi, bj, :), ACrs(bi, bj, :)] = ACQuan(...
                X( ((bi-1)*8+1):(bi*8),((bj-1)*8+1):(bj*8) ), counterlv, qlv);
            qX((bi-1)*8+1, (bj-1)*8+1) = DCX(bi, bj);
        end
    end
end
end