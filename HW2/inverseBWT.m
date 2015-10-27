function result = inverseBWT(s)
    %convert s to column vector
    if size(s,2) ~= 1,
        s = s';
    end
    n = length(s);
    result = sortrows(s)
    
    for i = 1:n-1,
        [s, result]
        result = sortrows([s, result]);
    end
end