%% initialization
clc; close all;clear;

%% base data
k = 0:31;
x = (k.^2+1)/2;
y = sin((5*k+1)*pi/32);

%% ===== fourier transformation =====
% fourier transformation
Xfft = fft(x);
Yfft = fft(y);
% b: absolute value of X and Y
absXfft = abs(Xfft);
absYfft = abs(Yfft);
%c.1
[sortXfft, indexXfft] = sort(absXfft, 'ascend');
indexXfft(1:17)
sortXfft(1:17)
%c.2
[sortYfft, indexYfft] = sort(absYfft, 'ascend');
indexYfft(1:17)
sortYfft(1:17)

Xhatfft = Xfft;
Xhatfft(indexXfft(1:17)) = 0;
Yhatfft = Yfft;
Yhatfft(indexYfft(1:17)) = 0;

xhatfft = ifft(Xhatfft);
yhatfft = ifft(Yhatfft);

figure(1);
plot(k,x);
hold on;
plot(k, xhatfft);
title('Fourier: x vs. xhat');
legend('x', 'xhatfft');
xlabel('k');
hold off;

figure(2);
plot(k, y);
hold on;
title('Fourier: y vs. yhat');
plot(k, yhatfft);
legend('y', 'yhatfft');
xlabel('k');
hold off;

%% ===== DCT =====
%clc; close all;clear;
close all;

% do dct transformation
Xdct= dct(x);
Ydct = dct(y);

Xhatdct = Xdct;
Xhatdct(16:32) = 0;
Yhatdct = Ydct;
Yhatdct(16:32) = 0;

% inverse dct
xhatdct = idct(Xhatdct);
yhatdct = idct(Yhatdct);

% plot 
figure(1);
plot(k,x);
hold on;
plot(k, xhatdct);
legend('x', 'xhatdct');
title('DCT: x vs. xhat');
xlabel('k');
hold off;
figure(2);
plot(k, y);
hold on;
plot(k, yhatdct);
legend('y', 'yhatdct');
title('DCT: y vs. yhat');
xlabel('k');
hold off;
%% Haar






% do Haar transformation
% [xca, xcd] = dwt(x, 'haar');
% [yca, ycd] = dwt(y, 'haar');
% Xhaar = [xca xcd];
% Yhaar = [yca ycd];
Ax = HaarMatrix(length(x));
Ay = HaarMatrix(length(y));
Xhaar = Ax*x';
Yhaar = Ay*y';
% zeroing out the 17 smallest-magnitude element
[sortXhaar, indexXhaar] = sort(abs(Xhaar), 'ascend');
[sortYhaar, indexYhaar] = sort(abs(Yhaar), 'ascend');
Xhathaar=Xhaar;
Xhathaar(indexXhaar(1:17)) = 0;
% xca = Xhathaar(1:16);
% xcd = Xhathaar(17:32);

Yhathaar=Yhaar;
Yhathaar(indexYhaar(1:17)) = 0;
%yca = Yhathaar(1:16);
%ycd = Yhathaar(17:32);

% do inverse haar transformation
% xca = Xhathaar(1:16);
% xcd = Xhathaar(17:32);
% xhathaar = idwt(xca, xcd, 'haar');
xhathaar = inv(Ax)*Xhathaar;
yhathaar = inv(Ay)*Yhathaar;
xhathaar = xhathaar';
yhathaar = yhathaar';
figure(1);
plot(k, x);
hold on;
plot(k, xhathaar);
legend('x', 'xhat');
title('Haar: x vs. xhat');
hold off;

figure(2);
plot(k, y);
hold on;
plot(k, yhathaar);
legend('y', 'yhat');
title('Haar: y vs. yhat');
hold off;

%% Hadamard
%clc; close all;clear;
close all;

%do Hadamrd transformation
Xhadm= 1/sqrt(length(x))*hadamard(length(x)) * x';
%Xhadm= hadamard(length(x)) * x';
Yhadm = 1/sqrt(length(y))*hadamard(length(y)) * y';
%Yhadm = hadamard(length(y)) * y';
[sortXhadm, indexXhdam]=sort(abs(Xhadm), 'ascend');
Xhathadm = Xhadm;
Xhathadm(indexXhdam(1:17)) = 0;
[sortYhadm, indexYhdam]=sort(abs(Yhadm), 'ascend');
Yhathadm = Yhadm;
Yhathadm(indexYhdam(1:17)) = 0;

%do inverse Hadamard transformation
xhathadm = 1/sqrt(length(x))*hadamard(length(x))*Xhathadm;
% xhathadm = hadamard(length(x))*Xhathadm;
yhathadm = 1/sqrt(length(y))*hadamard(length(y))*Yhathadm;
%yhathadm = hadamard(length(y))*Yhathadm;
xhathadm = xhathadm';
yhathadm = yhathadm';
figure(1);
plot(k, x, 'LineWidth', 2);
hold on;
plot(k, xhathadm);
title('Hadamard: x vs. xhat');
legend('x', 'xhat');
hold off;

figure(2);
plot(k, y);
hold on;
plot(k, yhathadm);
title('Hadamard: y vs. yhat');
legend('y', 'yhat');
hold off;


%% plot x vs. xhat from fft, dct, hadamard
close all;
figure(1);
plot(k, x,'r','LineWidth', 2)
hold on;
plot(k, xhatfft, 'b');
plot(k, xhatdct, 'g');
plot(k, xhathaar, 'y');
plot(k, xhathadm, 'k');
title('x vs. xhat''s')
xlabel('k')
legend('x','fft', 'dct', 'haar','hadamard');

%MSEs for xhats relative to x
msexfft = mean((xhatfft-x).^2);
msexdct = mean((xhatdct-x).^2);
msexhaar = mean((xhathaar-x).^2);
msexhadm = mean((xhathadm-x).^2);
hold off;

% plot x vs. xhat from fft, dct, hadamard
figure(2);
plot(k, y,'r')
hold on;
plot(k, yhatfft, 'b');
plot(k, yhatdct, 'g');
plot(k, yhathaar, 'y');
plot(k, yhathadm, 'k');
title('y vs. yhat''s')
xlabel('k')
legend('y','fft', 'dct', 'haar', 'hadamart');

mseyfft = mean((yhatfft-y).^2);
mseydct = mean((yhatdct-y).^2);
mseyhaar = mean((yhathaar-y).^2);
mseyhadm = mean((yhathadm-y).^2);
hold off;