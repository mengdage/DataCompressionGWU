function [qX, qds, qrs]= ACQuan(X,numRowBlock, numColumnBlock, counterlv, qlv)
qX = zeros(size(X));

numElemInEachBlock = (2+counterlv)*(counterlv-1)/2;
Z = zeros(numRowBlock, numColumnBlock * numElemInEachBlock);
sizeRowBlock = size(X,1)/numRowBlock;
sizeColumnBlock = size(X,2)/numColumnBlock;

if counterlv <2,
for i = 1: numRowBlock,
    for j = 1: numColumnBlock,
        qX((i-1)*sizeRowBlock+1, (j-1)*sizeRowBlock+1) = X((i-1)*sizeRowBlock+1, (j-1)*sizeRowBlock+1);
    end
end
qds = 0;
qrs = 0;

else

for i = 1: numRowBlock,
    for j = 1: numColumnBlock,
        qX((i-1)*sizeRowBlock+1, (j-1)*sizeRowBlock+1) = X((i-1)*sizeRowBlock+1, (j-1)*sizeRowBlock+1);
        indexZ = 1;

        for iz = 2: counterlv,
        % for each block, find the 2nd to qlv-th levels counterdiagonal
        % elements
            m = 1; n = (iz+1)-m;
            p = 1;
            q = -1;
            if mod(iz, 2) == 1,
                t = m; m = n; n = t;

                p = -1;q = 1;
            end

            for jz = 1:iz,
                Z(i, (j-1)*numElemInEachBlock+indexZ) = X((i-1)*sizeRowBlock+m,(j-1)*sizeColumnBlock+n);
                m = m+ p;
                n = n+q;
                indexZ = indexZ+1;
            end
        end
    end
end

[Z, qds, qrs]= uniformQuantizer(Z, qlv);

% put the quantized values back into the qX
for i = 1: numRowBlock,
    for j = 1: numColumnBlock,
        indexZ = 1;

        for iz = 2: counterlv,
        % for each block, find the 2nd to qlv-th levels counterdiagonal
        % elements
            m = 1; n = (iz+1)-m;
            p = 1;
            q = -1;
            if mod(iz, 2) == 1,
                t = m; m = n; n = t;

                p = -1;q = 1;
            end

            for jz = 1:iz,
                qX((i-1)*sizeRowBlock+m,(j-1)*sizeColumnBlock+n) = Z(i, (j-1)*numElemInEachBlock+indexZ);
                m = m+ p;
                n = n+q;
                indexZ = indexZ+1;
            end
        end
    end
end

end

end