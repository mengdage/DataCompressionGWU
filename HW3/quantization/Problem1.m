x=[0,0.65, 0.7, 0.7, 0.7, 0.9, 0.9, 1, 1, 1, 1, 1.2, 1.6, 1.8, 1.8, 1.74, 1.75, 1.9, 1.93, 1.94, 2.2, 2.2, 2.3, 2.35, 2.37, 2.5, 2.9];
lv4 = 4;

[qx4lv, d4lv, r4lv] = MLQuantizer(x, lv4);
[dx4lv] = MLDequantizer(qx4lv, r4lv);
msex4lv = mean((dx4lv-x).^2)

lv3 = 3;

[qx3lv, d3lv, r3lv] = uniformQuantizer(x, lv3);
[dx3lv] = uniformDequantizer(qx3lv, r3lv);
msex3lv = mean((dx3lv-x).^2)

[smqx, smds,smrs]=smquantizer(x, lv4);
[smdx] = smdequantizer(smqx, smrs);
msexsm = mean((smdx - x).^2);
