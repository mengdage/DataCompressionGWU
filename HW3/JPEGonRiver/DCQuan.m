function [DCX, DCds, DCrs] = DCQuan(X,numRowBlock, numColumnBlock, lv)
%DCQUAN do quantization on the DC term of X
% Input X is divided into numRowBlock x numColumnBlock blocks
% The quantization level is given by lv
% The kind of quantization is uniform quantization

DCX = X;
DCs = zeros(numRowBlock, numColumnBlock);
for bi = 1: numRowBlock,
    for bj = 1:numColumnBlock,
        DCs(bi, bj) = X( (bi-1)*8+1, (bj-1)*8+1 );
    end
end

[DCs, DCds, DCrs] = uniformQuantizer(DCs, lv);
for bi = 1: numRowBlock,
    for bj = 1:numColumnBlock,
        DCX( (bi-1)*8+1, (bj-1)*8+1 ) = DCs(bi, bj);
    end
end
end