function re = BWT(s)
    re = s;
    for i = 1: length(s)-1,
        s = stringRotation(s);
        re(i+1,:) = s;
    end
    re = sortrows(re);
end