function dX = DCDequan(X, numRowBlock, numColumnBlock, rs)
%DCQUAN do dequantization on the DC term of X
% Input X is divided into numRowBlock x numColumnBlock blocks
% The kind of quantization is uniform quantization
dX = X;
DCs = zeros(numRowBlock, numColumnBlock);
for bi = 1: numRowBlock,
    for bj = 1:numColumnBlock,
        DCs(bi, bj) = X( (bi-1)*8+1, (bj-1)*8+1 );
    end
end

DCs = uniformDequantizer(DCs, rs);
for bi = 1: numRowBlock,
    for bj = 1:numColumnBlock,
        dX( (bi-1)*8+1, (bj-1)*8+1 ) = DCs(bi, bj);
    end
end

end