function [ds,rs] = MaxLloyd(x, lv)
% x=[0,0.65, 0.7, 0.7, 0.7, 0.9, 0.9, 1, 1, 1, 1, 1.2, 1.6, 1.8, 1.8, 1.74, 1.75, 1.9, 1.93, 1.94, 2.2, 2.2, 2.3, 2.35, 2.37, 2.5, 2.9]

% x = [0 0.01 2.8 3.4 1.99 3.6 5 3.2 4.5 7.1 7.9];
x = sort(x);
% lv = 4;
ds = zeros(lv+1,1);
rs = zeros(lv,1);
% deta = range(x)/lv;
deta = (ceil(max(x))-floor(min(x)))/lv;

% the initialization of d's
for i = 1:(lv+1),
    ds(i) = x(1)+(i-1)*deta;
end

% the iterations
n = 40;
while n>0,
    % compute the new r's based on old d's
    sum = 0;
    num = 0;
    ir = 1;
    for i = 1:length(x),
        if (x(i) < ds(ir+1))||(x(i) == ds(lv+1)),
            sum = sum+x(i);
            num = num+1;
        end

        if i == length(x) || x(i+1) > ds(ir+1),
            if sum == 0,
                rs(ir) = (ds(ir) +ds(ir+1))/2;
            else
                rs(ir) = sum/num;
            end
            ir= ir + 1;
            sum = 0;
            num = 0;
        end
    end
    % compute the new d's based on old r's
    for i = 2:lv,
        ds(i) = (rs(i-1)+rs(i))/2;
    end
    
    n = n -1;
end
end