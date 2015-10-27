clc;close all;clear;
load earth;
% display the image
image(earth);colormap(map);

[ca, ch, cv, cd] = dwt2(earth, 'haar');

a = upcoef2('a', ca, 'haar', 1);
h = upcoef2('a', ch, 'haar', 1);
v = upcoef2('a', cv, 'haar', 1);
d = upcoef2('a', cd, 'haar', 1);