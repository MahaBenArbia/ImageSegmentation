
clear all
close all
%initilisation des paramètrès des méthodes de segmentation
%param11=a;
%param21=b;..

%intialisation du vecteur contenant le taux d'exactitude comme métrique d'évaluation pour toutes les
%images et pour les deux approches de segmentation
accuracy_rate = zeros(10,2);     %tableau 2D contenant les taux d'exactitude de chaque methode

addpath('Datasets\images\Breast-Cancer'); %rajouter le chemin du dossier contenant les images
imagesnames = struct('name', {'Beningn1.jpg' , 'Beningn2.jpg','Beningn3.jpg','Beningn4.jpg','Beningn5.jpg','Beningn6.jpg','Beningn7.jpg','Beningn8.jpg','Beningn9.jpg',...
    'Beningn10.jpg'});
save('imagesnames.mat');
addpath('Datasets\verite_terrain\Breast-Cancer'); %rajouter le chemin du dossier contenant les vérités terrain
imagesv = struct('name', {'sBeningn1.jpg' , 'sBeningn2.jpg','sBeningn3.jpg','sBeningn4.jpg','sBeningn5.jpg','sBeningn6.jpg','sBeningn7.jpg','sBeningn8.jpg','sBeningn9.jpg',...
    'sBeningn10.jpg'});
save('imagesnamesv.mat');

load('imagesnames.mat');         %structure 1x10 des images
load ('imagesnamesv.mat');

                     
addpath('C:...\Approches'); %Rajouter le chemin contenant les codes des 2 méthodes à tester


for i = 1:10                   %compteur i pour les images 
 image = imread(imagesnames(i).name);
 image = imresize(image, [255 255]);
 
 %%%%%%%%appel des methodes de segmentation%%%%%%%%

[seg1]=regiongrowing(image);
[seg2]=kmoyenne(image,3); 
 
 %%%%%%%calcul du taux d'exactitude%%%%%

 [segv] = imread(imagesv(i).name); %lecture de la vérité terrain

[accuracy_rate(i, 1),prec_rate(i,1)] = metrique(seg1,segv);
[accuracy_rate(i, 2),prec_rate(i,2)] = metrique(seg2,segv);


%%%%%%%%%%%%%%%%%%%%affichage des images segmentees%%%%%%%%%%%%%%
figure, 

subplot(221),imshow(image),title(sprintf('\t\t Image originale'));
subplot(222),imshow(segv),title(sprintf('\t\t Verite Terrain'));
subplot(223),imshow(seg1+image),title(sprintf('\t\t Image segmentee avec k-means',accuracy_rate(i, 1)));
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


