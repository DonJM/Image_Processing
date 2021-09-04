%ITIM 85
%Special Topics in Information Management
%Laboratory Activity #1
%NAME: Jay Mark Nicolas

pkg load image;

root = "images/";
files = dir("images");
image_path = {};

i = 1;
for j = 1:length(files)
  if(!files(j).isdir)
    image_path{i} = cstrcat(root, files(j).name)
    i += 1
   end
 end
 
  

 function item1 = item1(image_path)
   
   %initiate variables that holds converted color spaces of images
    original_image = imread(image_path);
    grayscale_image = rgb2gray(original_image);
    hsv_image = rgb2hsv(original_image);
    ycbcr_image = rgb2ycbcr(original_image);
    yiq_image = rgb2ntsc(original_image);

    %initiate lists of keys and images
    label = {"original", "grayscale", "hsv", "ycbcr_image", "yiq"};
    images = {original_image, grayscale_image, hsv_image, ycbcr_image, yiq_image};
    
    figure
    for i = 1:length(label)
      plot(3, 3, i, images{i}, label{i}, 0);
    end
    
 endfunction
 
 function item2 = item2(image_path)
   original_image = imread(image_path);
   gray_image = rgb2gray(original_image);
   eq_img = histeq(gray_image);
   
   images = {gray_image, eq_img};
   label = {"original", "equalized"};
   
   figure
   
   i = 1
   for j = 1: length(label)
    plot(2, 2, i, images{j}, label{j}, 0);
    i += 1
    plot(2, 2, i, images{j}, "image histogram", 1);
    i += 1
   end
 endfunction
 
 function item3 = item3(image_path1, image_path2, image_path3)
   image1 = imread(image_path1);
   image2 = imread(image_path2);
   image3 = imread(image_path3);
   
   %applying mean filter to image 1
   mean_filter = ones(5,5)./25;
   mean_filter_image = imfilter(image1, mean_filter);
   
   %applying median filter
   median_filter_image = imfilter(image2, [1, 1]);
   
   %applying gaussian filter
   gaussian_filter_image = imsmooth(image3, 2);
   
   original_images = {image1, image2, image3};
   filter_images = {mean_filter_image, median_filter_image, gaussian_filter_image};
   label = {"mean filter", "median filter", "gaussian filter"};
   figure
   
   i = 1
   for j = 1:length(label)
     plot(3, 2, i, original_images{j}, "original image", 0);
     i += 1
     plot(3, 2, i, filter_images{j}, label{j}, 0);
     i += 1
   endfor
   
 endfunction
 
 function item4 = item4(image_path1,image_path2)
   image1 = imread(image_path1);
   image2 = imread(image_path2);
   
   images = {image1, image2};
   augmentTech = {"Flipping", "Rotation", "Padding and Shearing", "Cropping", "Translation"};
   i = 1;
   row = 2;
   col = 6;
   
   figure
   for j = 1:length(images)
      original_image = images{j};
      plot(row, col, i, original_image, "Original Image", 0);
      i += 1;
      
      %image flipping
      flippedImage = flip(original_image, 1);
      plot(row, col, i, flippedImage, augmentTech{1}, 0);
      i += 1;
      
      %image rotation
      rotatedImage = imrotate(original_image, 35);
      plot(row, col, i, rotatedImage, augmentTech{2}, 0);
      i += 1;
      
      %padding and shearing image
      a = 0.45;
      T = maketform('affine', [1 0 0; a 1 0; 0 0 1] );
      padAndSheardImage = imtransform(original_image,T,'XData',[-49 500],'YData', [-49 400]);
      plot(row, col, i, padAndSheardImage, augmentTech{3}, 0);
      i += 1;
      
      %image cropping
      croppedImage = imcrop(original_image, [75 68 120 118]);
      plot(row, col, i, croppedImage, augmentTech{4}, 0);
      i += 1;
      
      %image translation
      xform = [ 1  0  0
          0  1  0
         40 40  1 ];
      tform_translate = maketform('affine',xform);
      [cb_trans xdata ydata]= imtransform(original_image, tform_translate);
      translatedImg = imtransform(original_image,tform_translate,'XData',[1 size(original_image, 2)+xform(3,1)],'YData', [1 size(original_image,1)+xform(3,2)]);
      plot(row, col, i, translatedImg, augmentTech{5}, 0);
      i += 1;
      
   endfor
 endfunction
 
 function plot = plot(row, column, i, images, label, isHist)
    %create loop to plot images and 
      if(isHist)
        subplot(row, column, i)
        imhist(images)
        title(label)
      else
        subplot(row, column, i)
        imshow(images)
        title(label)
      end
      
 endfunction
 
 item1(image_path{1});
 item2(image_path{2});
 item3(image_path{3}, image_path{4}, image_path{5});
 item4(image_path{6}, image_path{7});
