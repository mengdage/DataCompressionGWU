function [qx msex] = MLQuantizer(x, d, r)
    lv = length(d);
    numx = length(x);
    qx = x;
    
    % quantizer every element in x
    for i = 1:numx,
        % find:
        %   false: the interval has not been found
        %   true: the interval has been found
        find = false;
        % j: the index for d's
        j = 2;
        
        % while: loop until the interval is found
        while ~find,
            if d(j) > x(i),
                find = true;
            end
            
            % d(j) is the upper bound of the last interval
            % x(i) is equal to the upper bound of the last interval
            if (j == lv) && (d(j) == x(i)),
                find = true;
            end
            
            if ~find,
                j = j + 1;
            end
        end
        
        qx(i) = r(j-1);
    end
    
    msex = mean((qx-x).^2);
end