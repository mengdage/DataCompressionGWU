function A = HaarMatrix(N)
    n = 0;
    while N/2 >= 1,
        n = n+1;
        N = N/2;
    end
    N = 2^n;
    
    A = ones(N);
    k = 0;
    p = 0;
    q = 0;
    
    for k = 0:N-1,
        if(2^(p+1) <= k),
            p = p + 1;
        end
        
        q = k-2^p;
        
       l1 = q * 2^(n-p);
       u1 = (q+0.5)*2^(n-p);
       l2 = u1;
       u2 = (q+1)*2^(n-p);
       val1 = 2^((p-n)/2);
       val2 = -2^((p-n)/2);
       for l = 0:N-1,
           if k == 0,
               A(k+1, l+1) = 1 / sqrt(N);
           else
               if l1<=l && l < u1,
                    A(k+1, l+1) = val1;
               elseif l2<=l && l < u2,
                    A(k+1, l+1) = val2;
               else
                    A(k+1, l+1) = 0;
               end
           end
           
       end
    end
end