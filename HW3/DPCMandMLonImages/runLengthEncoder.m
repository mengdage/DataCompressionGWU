function e = runLengthEncoder(X)

X = X';
X = X(:);

rmax = 100;
rStride = 100;
e = zeros(rmax, 2);
itre = 1;
lengthX = length(X);
prex = X(1);
lengthRun = 1;
for i = 2:lengthX,
    if X(i) == prex,
        lengthRun = lengthRun+1;
    else
        
        e(itre ,:) = [lengthRun, prex];
        itre = itre+1;
        if itre > rmax,
            rmax = rmax + rStride;
            e(rmax, 2) = 0;
        end
        prex = X(i);
        lengthRun = 1;
    end
    
    if i == lengthX,
        e(itre ,:) = [lengthRun, prex];
    end
    
end

e = e(1:itre,:);
end