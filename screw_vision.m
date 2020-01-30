clear all; close all; clc;

%show image
I = imread('screws_images/screw7.jpg');
imshow(I);

%greyscale image
I1 = rgb2gray(I);
figure, imshow(I1);

%adjust image
I2 = imadjust(I1);
figure, imshow(I2);

%threshold binary
level = graythresh(I2);
bw = imbinarize(I2,level);
figure, imshow(bw);

%eliminate black points
bw1 = bwareaopen(bw, 50);
figure, imshow(bw1);

%erosionamos unas cuantas veces para delimitar entre tornillos
se1 = strel('disk',1);
for i = 1:2
    bw1 = imdilate(bw1,se1);
end
figure, imshow(bw1);

%invert binary image black to white
bw1_inv = not(bw1);
figure, imshow(bw1_inv);

%Feature extraction
tornillo_data = regionprops(bw1_inv, 'all');

%Identifying pattern, less than 0.1 Orientation and unknown objects
index_patron = find(abs(vertcat(tornillo_data.Orientation)) < 0.1);
index_objetoraro = find(vertcat(tornillo_data.EulerNumber) < 0.1);
index_mal = horzcat(index_patron',index_objetoraro');

figure, imshow(I);

%Area Patron
area_patron = tornillo_data(index_patron).Area;
mm_2_pixel = 121 / area_patron;

%Possible screws length
posible_lengths = [4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25];

%plot pattern text
text(tornillo_data(index_patron).Centroid(1),tornillo_data(index_patron).Centroid(2),'Pattern','color','red');

%plotting centroid and screws length
for i = setdiff(1:length(tornillo_data), index_mal) 
    L = (tornillo_data(i).Area * mm_2_pixel - 16.17)/3 ;
    [minValue,closestIndex] = min(abs(L-posible_lengths)); %minimum distance
    texto = strcat(num2str(posible_lengths(closestIndex)),' mm');
    text(tornillo_data(i).Centroid(1),tornillo_data(i).Centroid(2)+12,texto,'color','red');
    texto_coord = strcat('(',num2str(int64(tornillo_data(i).Centroid(1))),',',num2str(int64(tornillo_data(i).Centroid(2))),')');
    text(tornillo_data(i).Centroid(1),tornillo_data(i).Centroid(2),texto_coord,'color','red');
end

%plotting centroid de objetos raros
for i = 1 : length(index_objetoraro)
    texto = 'Unknown object';
    text(tornillo_data(index_objetoraro(i)).Centroid(1),tornillo_data(index_objetoraro(i)).Centroid(2)+12,texto,'color','red');
    texto_coord = strcat('(',num2str(int64(tornillo_data(index_objetoraro(i)).Centroid(1))),',',num2str(int64(tornillo_data(index_objetoraro(i)).Centroid(2))),')');
    text(tornillo_data(index_objetoraro(i)).Centroid(1),tornillo_data(index_objetoraro(i)).Centroid(2),texto_coord,'color','red');
end






