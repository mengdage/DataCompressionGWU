%% initialization
clear; close all; clc;
%%

[I, map] = imread('river.gif');

G = ind2gray(I, map);

%%
dctG = blockDCT(G);

[qG4, DCds4, DCrs4, ACds4, ACrs4] = JPEGQuantization(dctG, 4, 8);
[qG3, DCds3, DCrs3, ACds3, ACrs3] = JPEGQuantization(dctG, 3, 8);
[qG2, DCds2, DCrs2, ACds2, ACrs2] = JPEGQuantization(dctG, 2, 8);
[qG1, DCds1, DCrs1, ACds1, ACrs1] = JPEGQuantization(dctG, 1, 8);

dG4 = JPEGDequantization(qG4, 4, DCrs4, ACrs4);
dG3 = JPEGDequantization(qG3, 3, DCrs3, ACrs3);
dG2 = JPEGDequantization(qG2, 2, DCrs2, ACrs2);
dG1 = JPEGDequantization(qG1, 1, DCrs1, ACrs1);

iG4 = blockInvDCT(dG4);
iG3 = blockInvDCT(dG3);
iG2 = blockInvDCT(dG2);
iG1 = blockInvDCT(dG1);

%%
%figure, imshow(uint8(iG4));
%figure, imshow(mat2gray(iG4));
figure, imshow(iG4, [min(iG4(:)), max(iG4(:))]);
snrG4 = snr(double(G), dG4-double(G));


%figure, imshow(uint8(iG3));
figure, imshow(iG3, [min(iG3(:)), max(iG3(:))]);
snrG3 = snr(double(G), dG3-double(G));


%figure, imshow(uint8(iG2));
figure, imshow(iG2, [min(iG2(:)), max(iG2(:))]);
snrG2 = snr(double(G), dG2-double(G));


%figure, imshow(uint8(iG1));
%figure, imshow(mat2gray(iG1));
figure, imshow(iG1, [min(iG1(:)), max(iG1(:))]);
snrG1 = snr(double(G), dG1-double(G));