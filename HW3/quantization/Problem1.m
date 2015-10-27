x=[0,0.65, 0.7, 0.7, 0.7, 0.9, 0.9, 1, 1, 1, 1, 1.2, 1.6, 1.8, 1.8, 1.74, 1.75, 1.9, 1.93, 1.94, 2.2, 2.2, 2.3, 2.35, 2.37, 2.5, 2.9];
lv = 4;

[d4lv r4lv] = MaxLloyd(x, lv);
[qx4lv msex4lv] = MLQuantizer(x, d4lv, r4lv);

[d3lv r3lv] = MaxLloyd(x, 3);
[qx3lv msex3lv] = MLQuantizer(x, d3lv, r3lv);

[dsm4lv rsm4lv] = smquantizer(x, lv);