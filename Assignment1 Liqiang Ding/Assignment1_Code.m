
%%  Question 1
I = imread('lena_r92-053-04.jpg');
I_T2 = imread('lena_r92-053-04.jpg');
[row,col]=size(I);
%imshow(I)

% The following block of the code is from the Internet
% level is the threshold after normalizing 
[level_T1, level_T2]=otsu_modified(I); 
BW_T1 = im2bw(I,level_T1);
imshow(BW_T1)

redChannel = I(:, :, 1);
greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);


% Show the resulting binary-segmented image by coloring the foreground red and the background green.

for i=1:row
    for j=1:(col/3)
        if BW_T1(i,j)==0;
            I(i,j,1)=255;
            I(i,j,2)=0;
            I(i,j,3)=0;
        else
            I(i,j,1)=0;
            I(i,j,2)=255;
            I(i,j,3)=0;          
        end 
    end
end

%% Question 2


% Step 1: Calculate the threshold T1 using Otsu’s method in the whole image.
% Note the Threshold was normalized
%T1 = level_T2; 


% Step 2: Calculate the threshold T2 using Otsu’s method in the range of 
% pixels with gray levels in [T1, 255].
%T2 = level_T2;

% Step 3: Then the pixels whose gray levels are smaller than T2 are 
% classified as object and the others as background.

BW_T2 = im2bw(I_T2,level_T2);

% Show the resulting binary-segmented image
% by coloring the foreground red and the background green


for i=1:row
    for j=1:(col/3)
        if BW_T2(i,j)==0;
            I_T2(i,j,1)=255;
            I_T2(i,j,2)=0;
            I_T2(i,j,3)=0;
        else
            I_T2(i,j,1)=0;
            I_T2(i,j,2)=255;
            I_T2(i,j,3)=0;          
        end 
    end
end

subplot(2,2,1),imshow(BW_T1),title('Binary Image using Otsu Method');
subplot(2,2,2),imshow(I),title('Foreground Red and Background Green');
subplot(2,2,3),imshow(BW_T2),title('Binary Image using modified Otsu Method');
subplot(2,2,4),imshow(I_T2),title('Foreground Red and Background Green');

%% Question 3

% Compute and plot the three individual 1D histograms for each of R, G, and B 
% in the whole RGB color image Lena stasjon. Comment on what information can 
% be discerned from the images by an examination of the three histograms
I_color = imread('Lena_stasjon.jpg');

redChannel = I_color(:, :, 1);
greenChannel = I_color(:, :, 2);
blueChannel = I_color(:, :, 3);

% Uncomment the following to see the histogram plots
%subplot(1,3,1),imhist(redChannel,256),title('Red Channel');
%subplot(1,3,2),imhist(greenChannel,256),title('Green Channel');
%subplot(1,3,3),imhist(blueChannel,256),title('Blue Channel');

