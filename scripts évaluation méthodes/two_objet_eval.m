
clear all
close all
%initilisation des param?tr?s des m?thodes de segmentation
%param11=a;
%param21=b;..

%intialisation du vecteur contenant le taux d'exactitude comme m?trique d'?valuation pour toutes les
%images et pour les deux approches de segmentation
accuracy_rate = zeros(10,2);     %tableau 2D contenant les taux d'exactitude de chaque methode

addpath('Datasets\images\2objets'); %rajouter le chemin du dossier contenant les images
imagesnames = struct('name', {'11.png' , '12.png','13.png','14.png','15.png','16.png','17.png','18.png','19.png',...
    '20.png'});
save('imagesnames.mat');
addpath('Datasets\verite_terrain\2objets'); %rajouter le chemin du dossier contenant les v?rit?s terrain
imagesv = struct('name', {'11v.png' , '12v.png','13v.png','14v.png','15v.png','16v.png','17v.png','18v.png','19v.png',...
    '20v.png'});
save('imagesnamesv.mat');

load('imagesnames.mat');         %structure 1x10 des images
load ('imagesnamesv.mat');

                     
addpath('C:...\Approches'); %Rajouter le chemin contenant les codes des 2 m?thodes ? tester


for i = 1:10                   %compteur i pour les images 
 image = imread(imagesnames(i).name);
 
 %%%%%%%%appel des methodes de segmentation%%%%%%%%

[seg1]=kmoyenne(image, 4);
[seg2]=otsu(image); 
 
 %%%%%%%calcul du taux d'exactitude%%%%%

 image2 = imread(imagesv(i).name); %lecture de la v?rit? terrain
 image2 = imresize(image2, size(image)); %rendre les photos de meme tailles
[segv]=image2; %transformer la photo en un segment

[accuracy_rate(i, 1),prec_rate(i,1)] = metrique(seg1,segv);
[accuracy_rate(i, 2),prec_rate(i,2)] = metrique(seg2,segv);


%%%%%%%%%%%%%%%%%%%%affichage des images segmentees%%%%%%%%%%%%%%
figure, 

subplot(221),imshow(image),title(sprintf('\t\t Image originale'));
subplot(222),imshow(segv),title(sprintf('\t\t Verite Terrain'));
subplot(223),imshow(seg1),title(sprintf('\t\t Image segmentee avec k-means',accuracy_rate(i, 1)));
subplot(224),imshow(seg2),title(sprintf('\t\t Image segmentee avec otsu',accuracy_rate(i, 2)));


end 
%%%%%%%%%%%%%%%%%%%%%%%%courbes%%%%%%%%%%%%%%%%%
figure,
t=1:10;
 plot(t,accuracy_rate(:, 1),'r');hold on; plot(t,accuracy_rate(:, 2),'b');
title('Etude comparative du taux d"exactitude');
xlabel('Images') % x-axis label
ylabel('Taux d"exactitude') % y-axis label
legend('k-means','otsu')

figure,
plot(t,prec_rate(:, 1),'r');hold on; plot(t,prec_rate(:, 2),'b');
title('Etude comparative de la precision');
xlabel('Images') % x-axis label
ylabel('precision') % y-axis label
legend('k-means','otsu')


