%% initialization
clear;close all; clc;
%%
[I, map] = imread('river.gif');
G = ind2gray(I, map);

%%
% sets of values of a, b and c
abcSet1 = [1, 0, 0];
abcSet2 = [0, 0, 1];
abcSet3 = [0.5, 0, 0.5];
abcSet4 = [1, -1, 1];
abcSet5 = [0.75, -0.5, 0.75];

% residual images E's
E1 = DPCM2D(G, abcSet1);
E2 = DPCM2D(G, abcSet2);
E3 = DPCM2D(G, abcSet3);
E4 = DPCM2D(G, abcSet4);
E5 = DPCM2D(G, abcSet5);
%%
min(E1(:)),max(E1(:))
figure, imagesc(E1),colorbar
figure, imagesc(uint8(E1)), colorbar
figure, imshow(E1, [min(E1(:)), max(E1(:))]), colorbar

%%
H1 = computeEntropy(E1);
H2 = computeEntropy(E2);
H3 = computeEntropy(E3);
H4 = computeEntropy(E4);
H5 = computeEntropy(E5);

H = [H1, H2, H3, H4, H5];
find(H==min(H))

figure, imshow(E1,[min(E1(:)), max(E1(:))])

%% Quantization and RLE
% Max-Lloyd Quantization
lv = 8;
[qE1, ds, rs] = MLQuantizer(E1, lv);

% RLE
e = runLengthEncoder(qE1);
te = e';
te = te(:);
He = computeEntropy(te);

%% Dequantization

[dE1] = MLDequantizer(qE1, rs);

%% 
iG = invDPCM2D(dE1, abcSet1);

iSNR = 10*log10( sum(double(G(:)).^2) / sum((iG(:)-double(G(:))).^2) );
figure, imshow(mat2gray(iG));