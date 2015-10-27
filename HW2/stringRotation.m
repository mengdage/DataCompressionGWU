function sr = stringRotation(s)
    n = length(s);
    sr = s;
    for i =1:n,
        m = i+1;
        if m >n,
            m = m-n;
        end
        sr(i) = s(m);
    end
end