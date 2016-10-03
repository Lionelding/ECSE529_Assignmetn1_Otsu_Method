I = imread('Lena_stasjon.jpg');
redChannel = I(:, :, 1);
greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);



I=cat(3, redChannel, greenChannel, blueChannel*255);
imshow(I);

subplot(1,4,1),imhist(redChannel,256),title('Red Channel');
subplot(1,4,2),imhist(greenChannel,256),title('Green Channel');
subplot(1,4,3),imhist(blueChannel,256),title('Blue Channel');
subplot(1,4,4),imshow(I);

    %{
    sigma_b_squared_secondThreshold = sigma_b_squared(idx+1:256,1:1);
    maxval_secondThreshold = max(sigma_b_squared_secondThreshold);
    isfinite_maxval_secondThreshold = isfinite(maxval_secondThreshold);
     
    if isfinite_maxval_secondThreshold
       idx_secondThreshold = mean(find(sigma_b_squared == maxval_secondThreshold));
       
       % Normalize the threshold to the range [0, 1].
       level_T2 = (idx_secondThreshold - 1) / (num_bins - 1);
    else 
       level_T2=0.0;
    end
    %}