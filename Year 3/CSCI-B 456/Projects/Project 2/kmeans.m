function kmeans(input_video)
    v = input_video;
    
%     Reading video for specified frames
    frame1 = read(v, 1);
    frame20 = read(v, 20);
    frame40 = read(v, 40);
    frame60 = read(v, 60);
    frame80 = read(v, 80);
    frame100 = read(v, 100);
    frame120 = read(v, 120);
    frame140 = read(v, 140);
    frame160 = read(v, 160);
    frame180 = read(v, 180);
    
    subplot(2, 5, 1);
    imshow(frame1);
    title('Frame 1');
    
    subplot(2, 5, 2);
    imshow(frame20);
    title('Frame 20');
    
    subplot(2, 5, 3);
    imshow(frame40);
    title('Frame 40');
    
    subplot(2, 5, 4);
    imshow(frame60);
    title('Frame 60');
    
    subplot(2, 5, 5);
    imshow(frame80);
    title('Frame 80');
    
    subplot(2, 5, 6);
    imshow(frame100);
    title('Frame 100');
    
    subplot(2, 5, 7);
    imshow(frame120);
    title('Frame 120');
    
    subplot(2, 5, 8);
    imshow(frame140);
    title('Frame 140');
    
    subplot(2, 5, 9);
    imshow(frame160);
    title('Frame 160');
    
    subplot(2, 5, 10);
    imshow(frame180);
    title('Frame 180');
    
    lab_1 = rgb2lab(frame1);
    lab_20 = rgb2lab(frame20);
    lab_40 = rgb2lab(frame40);
    lab_60 = rgb2lab(frame60);
    lab_80 = rgb2lab(frame80);
    lab_100 = rgb2lab(frame100);
    lab_120 = rgb2lab(frame120);
    lab_140 = rgb2lab(frame140);
    lab_160 = rgb2lab(frame160);
    lab_180 = rgb2lab(frame180);
    
    ab_1 = im2single(lab_1(:, :, 2:3));
    ab_20 = im2single(lab_20(:, :, 2:3));
    ab_40 = im2single(lab_40(:, :, 2:3));
    ab_60 = im2single(lab_60(:, :, 2:3));
    ab_80 = im2single(lab_80(:, :, 2:3));
    ab_100 = im2single(lab_100(:, :, 2:3));
    ab_120 = im2single(lab_120(:, :, 2:3));
    ab_140 = im2single(lab_140(:, :, 2:3));
    ab_160 = im2single(lab_160(:, :, 2:3));
    ab_180 = im2single(lab_180(:, :, 2:3));
    
    nColors = 3;
    
    pixel_labels_1 = imsegkmeans(ab_1, nColors, 'NumAttempts', 3);
    pixel_labels_20 = imsegkmeans(ab_20, nColors, 'NumAttempts', 3);
    pixel_labels_40 = imsegkmeans(ab_40, nColors, 'NumAttempts', 3);
    pixel_labels_60 = imsegkmeans(ab_60, nColors, 'NumAttempts', 3);
    pixel_labels_80 = imsegkmeans(ab_80, nColors, 'NumAttempts', 3);
    pixel_labels_100 = imsegkmeans(ab_100, nColors, 'NumAttempts', 3);
    pixel_labels_120 = imsegkmeans(ab_120, nColors, 'NumAttempts', 3);
    pixel_labels_140 = imsegkmeans(ab_140, nColors, 'NumAttempts', 3);
    pixel_labels_160 = imsegkmeans(ab_160, nColors, 'NumAttempts', 3);
    pixel_labels_180 = imsegkmeans(ab_180, nColors, 'NumAttempts', 3);
    
    mask1_1 = pixel_labels_1==1;
    mask1_20 = pixel_labels_20==1;
    mask1_40 = pixel_labels_40==1;
    mask1_60 = pixel_labels_60==1;
    mask1_80 = pixel_labels_80==1;
    mask1_100 = pixel_labels_100==1;
    mask1_120 = pixel_labels_120==1;
    mask1_140 = pixel_labels_140==1;
    mask1_160 = pixel_labels_160==1;
    mask1_180 = pixel_labels_180==1;
    
    cluster1_1 = frame1 .* uint8(mask1_1);
    cluster1_20 = frame1 .* uint8(mask1_20);
    cluster1_40 = frame1 .* uint8(mask1_40);
    cluster1_60 = frame1 .* uint8(mask1_60);
    cluster1_80 = frame1 .* uint8(mask1_80);
    cluster1_100 = frame1 .* uint8(mask1_100);
    cluster1_120 = frame1 .* uint8(mask1_120);
    cluster1_140 = frame1 .* uint8(mask1_140);
    cluster1_160 = frame1 .* uint8(mask1_160);
    cluster1_180 = frame1 .* uint8(mask1_180);
    
    mask2_1 = pixel_labels_1==2;
    mask2_20 = pixel_labels_20==2;
    mask2_40 = pixel_labels_40==2;
    mask2_60 = pixel_labels_60==2;
    mask2_80 = pixel_labels_80==2;
    mask2_100 = pixel_labels_100==2;
    mask2_120 = pixel_labels_120==2;
    mask2_140 = pixel_labels_140==2;
    mask2_160 = pixel_labels_160==2;
    mask2_180 = pixel_labels_180==2;
    
    cluster2_1 = frame1 .* uint8(mask2_1);
    cluster2_20 = frame1 .* uint8(mask2_20);
    cluster2_40 = frame1 .* uint8(mask2_40);
    cluster2_60 = frame1 .* uint8(mask2_60);
    cluster2_80 = frame1 .* uint8(mask2_80);
    cluster2_100 = frame1 .* uint8(mask2_100);
    cluster2_120 = frame1 .* uint8(mask2_120);
    cluster2_140 = frame1 .* uint8(mask2_140);
    cluster2_160 = frame1 .* uint8(mask2_160);
    cluster2_180 = frame1 .* uint8(mask2_180);
    
    mask3_1 = pixel_labels_1==3;
    mask3_20 = pixel_labels_20==3;
    mask3_40 = pixel_labels_40==3;
    mask3_60 = pixel_labels_60==3;
    mask3_80 = pixel_labels_80==3;
    mask3_100 = pixel_labels_100==3;
    mask3_120 = pixel_labels_120==3;
    mask3_140 = pixel_labels_140==3;
    mask3_160 = pixel_labels_160==3;
    mask3_180 = pixel_labels_180==3;
    
    cluster3_1 = frame1 .* uint8(mask3_1);
    cluster3_20 = frame1 .* uint8(mask3_20);
    cluster3_40 = frame1 .* uint8(mask3_40);
    cluster3_60 = frame1 .* uint8(mask3_60);
    cluster3_80 = frame1 .* uint8(mask3_80);
    cluster3_100 = frame1 .* uint8(mask3_100);
    cluster3_120 = frame1 .* uint8(mask3_120);
    cluster3_140 = frame1 .* uint8(mask3_140);
    cluster3_160 = frame1 .* uint8(mask3_160);
    cluster3_180 = frame1 .* uint8(mask3_180);
    
    figure(2);
    
    subplot(2, 5, 1);
    imshow(cluster1_1);
    title('Frame 1 Cluster 1');
    
    subplot(2, 5, 2);
    imshow(cluster1_20);
    title('Frame 20 Cluster 1');
    
    subplot(2, 5, 3);
    imshow(cluster1_40);
    title('Frame 40 Cluster 1');
    
    subplot(2, 5, 4);
    imshow(cluster1_60);
    title('Frame 60 Cluster 1');
    
    subplot(2, 5, 5);
    imshow(cluster1_80);
    title('Frame 80 Cluster 1');
    
    subplot(2, 5, 6);
    imshow(cluster1_100);
    title('Frame 100 Cluster 1');
    
    subplot(2, 5, 7);
    imshow(cluster1_120);
    title('Frame 120 Cluster 1');
    
    subplot(2, 5, 8);
    imshow(cluster1_140);
    title('Frame 140 Cluster 1');
    
    subplot(2, 5, 9);
    imshow(cluster1_160);
    title('Frame 160 Cluster 1');
    
    subplot(2, 5, 10);
    imshow(cluster1_180);
    title('Frame 180 Cluster 1');
    
    
    figure(3);
    
    subplot(2, 5, 1);
    imshow(cluster2_1);
    title('Frame 1 Cluster 2');
    
    subplot(2, 5, 2);
    imshow(cluster2_20);
    title('Frame 20 Cluster 2');
    
    subplot(2, 5, 3);
    imshow(cluster2_40);
    title('Frame 40 Cluster 2');
    
    subplot(2, 5, 4);
    imshow(cluster2_60);
    title('Frame 60 Cluster 2');
    
    subplot(2, 5, 5);
    imshow(cluster2_80);
    title('Frame 80 Cluster 2');
    
    subplot(2, 5, 6);
    imshow(cluster2_100);
    title('Frame 100 Cluster 2');
    
    subplot(2, 5, 7);
    imshow(cluster2_120);
    title('Frame 120 Cluster 2');
    
    subplot(2, 5, 8);
    imshow(cluster2_140);
    title('Frame 140 Cluster 2');
    
    subplot(2, 5, 9);
    imshow(cluster2_160);
    title('Frame 160 Cluster 2');
    
    subplot(2, 5, 10);
    imshow(cluster2_180);
    title('Frame 180 Cluster 2');
    
    figure(4);
    
    subplot(2, 5, 1);
    imshow(cluster3_1);
    title('Frame 1 Cluster 3');
    
    subplot(2, 5, 2);
    imshow(cluster3_20);
    title('Frame 20 Cluster 3');
    
    subplot(2, 5, 3);
    imshow(cluster3_40);
    title('Frame 40 Cluster 3');
    
    subplot(2, 5, 4);
    imshow(cluster3_60);
    title('Frame 60 Cluster 3');
    
    subplot(2, 5, 5);
    imshow(cluster3_80);
    title('Frame 80 Cluster 3');
    
    subplot(2, 5, 6);
    imshow(cluster3_100);
    title('Frame 100 Cluster 3');
    
    subplot(2, 5, 7);
    imshow(cluster3_120);
    title('Frame 120 Cluster 3');
    
    subplot(2, 5, 8);
    imshow(cluster3_140);
    title('Frame 140 Cluster 3');
    
    subplot(2, 5, 9);
    imshow(cluster3_160);
    title('Frame 160 Cluster 3');
    
    subplot(2, 5, 10);
    imshow(cluster3_180);
    title('Frame 180 Cluster 3');
end