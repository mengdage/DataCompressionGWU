function [qX, DCds, DCrs, ACds, ACrs] = JPEGQuantization(X, counterlv, qlv)
sizeX = size(X);
X= double(X);

% compute the num of row blocks and column blocks
numRowBlock = sizeX(1)/8;
numColumnBlock = sizeX(2)/8;

% DC quantization

lv = 64;
[qX, DCds, DCrs] = DCQuan(X, numRowBlock, numColumnBlock, lv);


% AC quantization
 
[qX, ACds, ACrs]= ACQuan(qX,numRowBlock, numColumnBlock, counterlv, qlv);

end