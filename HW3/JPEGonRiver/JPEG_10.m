clear;
clc;

%% read in gray scale image
[I, map] = imread('River.gif');
G = ind2gray(I, map);
G = double(G);

%% divide G into 8*8 matrices and put them into C; DCT C to D; get DC, AC terms

% grid coordinates
delta_x = 632/8 + 1;
delta_y = 848/8 + 1;

x = ones(1, delta_x);
y = ones(1, delta_y);

for i = 2: delta_x
    x(i) = 1 + 8 * (i-1);
end

for j = 2: delta_y
    y(j) = 1 + 8 * (j-1);
end

% init.
count = 1;
DC = zeros(1, 8374);
AC = zeros(1, 8374*9);

for i = 1: delta_x-1
    for j = 1: delta_y-1
        % split G into 8x8 blocks
        C(:, :, count) = G([x(i): x(i+1)-1], [y(j): y(j+1)-1]);
        % dct
        D(:, :, count) = dct2(C(:, :, count));   
        temp = D(:, :, count);
        
        % DC terms
        DC(count) = temp(1, 1);
        % AC terms
        AC(9*(count-1)+1: 9*(count-1)+9) = [temp(2, 1) temp(1, 2) temp(1, 3) temp(2, 2) temp(3, 1) temp(4, 1) temp(3, 2) temp(2, 3) temp(1, 4)];
        
        count = count + 1;
    end
end

%% Uniform Quantization

% calculate DC arrays
d_dc = zeros(1, 65);
r_dc = zeros(1, 64);

d_dc(1) = min(DC);
d_dc(65) = max(DC) + 0.001;

delta_dc = (d_dc(65) - d_dc(1))/64;

d_dc(2: 64) = (1: 63) * delta_dc + d_dc(1);
r_dc(1: 64) = (d_dc(1: 64) + d_dc(2: 65))/2;

% calculate AC arrays
d_ac = zeros(1, 9);
r_ac = zeros(1, 8);

d_ac(1) = min(AC);
d_ac(9) = max(AC) + 0.001;

delta_ac = (d_ac(9) - d_ac(1))/8;

d_ac(2: 8) = (1: 7) * delta_ac + d_ac(1);
r_ac(1: 8) = (d_ac(1: 8) + d_ac(2: 9))/2; 

% Quantize DC
DC_prime = DC;
for i = 1: length(DC)
    for j = 1: 64
        if ((d_dc(j) <= DC(i)) && (DC(i) < d_dc(j+1)))
            DC_prime(i) = j;
            break;
        end
    end
end

% Quantize AC
AC_prime = AC;
for i = 1: length(AC)
    for j = 1: 8
        if ((d_ac(j) <= AC(i)) && (AC(i) < d_ac(j+1)))
            AC_prime(i) = j;
            break;
        end
    end
end

%% zero-out all terms
ZO = zeros(size(D));

%% Dequantization & Inverse DCT
% DC terms
DC_prime = r_dc(DC_prime);
DC_prime = idct2(DC_prime);

% AC terms
AC_prime = r_ac(AC_prime);
AC_prime = idct2(AC_prime);

%% Reconstruction
% block substitution
count = 1;
for i = 1: delta_x-1
    for j = 1: delta_y-1
        temp = zeros(8, 8);

        % 1 DC term
        temp(1,1) = DC_prime(count);
        % 9 AC terms
        temp(2, 1) = AC_prime(9*(count-1)+1);
        temp(1, 2) = AC_prime(9*(count-1)+2);
        temp(1, 3) = AC_prime(9*(count-1)+3);
        temp(2, 2) = AC_prime(9*(count-1)+4);
        temp(3, 1) = AC_prime(9*(count-1)+5);
        temp(4, 1) = AC_prime(9*(count-1)+6);
        temp(3, 2) = AC_prime(9*(count-1)+7);
        temp(2, 3) = AC_prime(9*(count-1)+8);
        temp(1, 4) = AC_prime(9*(count-1)+9);
        
        ZO(:, :, count) = temp;
        
        count = count + 1;
    end
end

% Reconstruction
G_10_hat = size(G);

count = 1;
for i = 1: delta_x-1
    for j = 1: delta_y-1
        G_10_hat(x(i): x(i+1)-1, y(j): y(j+1)-1) = ZO(:, :, count);
        count = count + 1;
    end 
end
%%
imshow(G_10_hat, [min(G_10_hat(:)), max(G_10_hat(:))])
%% SNR
RMSE = (sum((G(:)-G_10_hat(:)).^2))/(sum(G(:).^2));

SNR = -10*log10(RMSE);
