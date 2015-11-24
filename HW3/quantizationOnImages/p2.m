%% initialization
clear; close all; clc;
%%
[I, map] = imread('river.gif');

G = ind2gray(I, map);

lv8 = 8;
H = computeEntropy(G);
%% uniform quantization
[uniqG, unids, unirs] = uniformQuantizer(G, lv8);
uniH = computeEntropy(uniqG);
[unidG] = uniformDequantizer(uniqG, unirs);

uniMSE = mean((unidG(:)-double(G(:))).^2);

uniSNR = 10*log10( sum(double(G(:)).^2) / sum((unidG(:)-double(G(:))).^2) );
%% semi-uniform quantization
[smqG, smds, smrs] = smquantizer2D(G, lv8);
smH = computeEntropy(smqG);
[smdG] = smdequantizer2D(smqG, smrs);

smMSE = mean((smdG(:)-double(G(:))).^2);

smSNR = 10*log10(sum(double(G(:)).^2) / sum((smdG(:)-double(G(:))).^2));

%% Max-Lloyd quantization

[MLqG, MLds, MLrs] = MLQuantizer(G, lv8);
MLH = computeEntropy(MLqG);
[MLdG] = MLDequantizer(MLqG, MLrs);

MLMSE = mean((MLdG(:)-double(G(:))).^2);
MLSNR = 10*log10(sum(double(G(:)).^2) / sum((MLdG(:)-double(G(:))).^2));

%%
% show G and dequantized G's
figure,imshow(G); title('original');
figure,imshow(uint8(unidG));title('Uniform quantization');
figure, imshow(uint8(smdG));title('Semi-uniform quantization');
figure, imshow(uint8(MLdG));title('Max-Lloyd quantization');
