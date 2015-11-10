%% initialization
clear; close all; clc;
%%
[I, map] = imread('river.gif');

H = computeEntropy(I, size(map,1));
%%
G = ind2gray(I, map);
lv8 = 8;
%% uniform quantization
[uniqG, unids, unirs] = uniformQuantizer(G, lv8);
uniH = computeEntropy(uniqG, length(unirs));
[unidG] = uniformDequantizer(uniqG, unirs);

uniMSE = mean((unidG(:)-double(G(:))).^2);

uniSNR = 10*log10(sum(double(G(:)).^2) / sum((unidG(:)-double(G(:))).^2));
%% semi-uniform quantization
[smqG, smds, smrs] = smquantizer2D(G, lv8);
smH = computeEntropy(smqG, lv8);
[smdG] = smdequantizer2D(smqG, smrs);

smMSE = mean((smdG(:)-double(G(:))).^2);

smSNR = 10*log10(sum(double(G(:)).^2) / sum((smdG(:)-double(G(:))).^2));

%% Max-Lloyd quantization

[MLqG, MLds, MLrs] = MLQuantizer(G, lv8);
MLH = computeEntropy(MLqG, lv8);
[MLdG] = MLDequantizer(MLqG, MLrs);

MLMSE = mean((MLdG(:)-double(G(:))).^2);
MLSNR = 10*log10(sum(double(G(:)).^2) / sum((MLdG(:)-double(G(:))).^2));

%%
% show G and dequantized G
figure,imshow(G);
figure,imshow(uint8(unidG));
figure, imshow(uint8(smdG));
%%
GL = imread('girl.jpg');
imshow(GL);

figure, imshow(I, map), figure, imshow(G);
figure, image(G);figure, imagesc(G);

image(G)
image(I)

load trees
I = ind2gray(X,map);
figure, imshow(X,map), figure, imshow(I);

