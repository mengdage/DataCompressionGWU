function x = runLengthDecoder(e, numRow, numColumn)
if size(e,1)==1 || size(e,2) == 1,
    r = length(e)/2;
    e = reshape(e, 2, r);
    e = e';
end


s = sum(e);
l = s(1);

x = ones(l,1);
itre = 1;
for i = 1:size(e,1),
    x(itre : itre+ e(i,1)-1) = x(itre:itre+e(i,1)-1)*e(i,2);
    itre = itre + e(i,1);
end
x = reshape(x, numColumn, numRow);
x = x';
end