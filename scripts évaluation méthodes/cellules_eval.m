
clear all
close all
%initilisation des param�tr�s des m�thodes de segmentation
%param11=a;
%param21=b;..

%intialisation du vecteur contenant le taux d'exactitude comme m�trique d'�valuation pour toutes les
%images et pour les deux approches de segmentation
accuracy_rate = zeros(10,2);     %tableau 2D contenant les taux d'exactitude de chaque methode

addpath('Datasets\images\cellules'); %rajouter le chemin du dossier contenant les images
imagesnames = struct('name', {'dna-0.png' , 'dna-1.png','dna-2.png','dna-3.png','dna-4.png','dna-5.png','dna-6.png','dna-7.png','dna-8.png',...
    'dna-9.png'});
save('imagesnames.mat');
addpath('Datasets\verite_terrain\cellules'); %rajouter le chemin du dossier contenant les v�rit�s terrain
imagesv = struct('name', {'dna-0.png' , 'dna-1.png','dna-2.png','dna-3.png','dna-4.png','dna-5.png','dna-6.png','dna-7.png','dna-8.png',...
    'dna-9.png'});
save('imagesnamesv.mat');

load('imagesnames.mat');         %structure 1x10 des images
load ('imagesnamesv.mat');

                     
addpath('C:...\Approches'); %Rajouter le chemin contenant les codes des 2 m�thodes � tester


for i = 1:10                   %compteur i pour les images 
 image = imread(imagesnames(i).name);
 
 %%%%%%%%appel des methodes de segmentation%%%%%%%%

[seg1]=kmoyenne(image, 3);
[seg2]=otsu(image); 
 
 %%%%%%%calcul du taux d'exactitude%%%%%

 [segv] = imread(imagesv(i).name); %lecture de la v�rit� terrain


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

m1=mean(accuracy_rate(:,1));
disp(m1);


