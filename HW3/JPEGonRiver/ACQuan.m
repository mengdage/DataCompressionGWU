function [qX, qds, qrs]= ACQuan(X, counterlv, qlv)
qX = zeros(size(X));

Z = zeros((2+counterlv)*(counterlv-1)/2, 1);
indexZ = 1;
for i = 2: counterlv,
    m = 1; n = (i+1)-m;
    p = 1;
    q = -1;
    if mod(i, 2) == 1,
        t = m; m = n; n = t;
        
        p = -1;q = 1;
    end
    
    for j = 1:i,
        Z(indexZ) = X(m,n);
        m = m+ p;
        n = n+q;
        indexZ = indexZ+1;
    end
end

[Z, qds, qrs]= uniformQuantizer(Z, qlv);

indexZ = 1;
for i = 2: counterlv,
    m = 1; n = (i+1)-m;
    p = 1;
    q = -1;
    if mod(i, 2) == 1,
        t = m; m = n; n = t;
        
        p = -1;q = 1;
    end
    
    for j = 1:i,
        qX(m,n) = Z(indexZ);
        m = m+ p;
        n = n+q;
        indexZ = indexZ+1;
    end
end

end