close all;

caminho = geraCaminho(14.5,0.5);

im = imread('piso.png');

figure; 

imshow(im);

hold on;

plot(caminho(1,:)*(631-597)/1.5+587, caminho(2,:)*(631-597)/1.5+(986-280));
