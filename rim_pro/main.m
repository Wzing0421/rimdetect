% %读入彩色图像，首先我的想法是把彩色的和黑白的分别进行边缘检测
% %看看效果谁的好就用谁的,基本上效果差不多，用初步决定用彩色的
% %sobel和prewitt算子的结果要好于log算子和robert算子，这里采用sobel算子
% 
% 
% %我觉得似乎需要先做一个边缘锐化
% 
% %读入图像,是一个彩色图像
% Image_=imread('rim.jpg');
% %分别获得RGB三个方向的分量
% Instance_R = Image_(:,:,1);%R通道
% Instance_G = Image_(:,:,2);%G通道
% Instance_B = Image_(:,:,3);%B通道
% 
% %图像的预处理，增强对比度，锐化的效果不好，指数处理一下效果基本也没变，我目前想法是指数一下
% %目前幂指数1.5效果比2和2.5好一点
% % p1 =fspecial('sobel');
% % add1 =imfilter(Instance_R,p1);
% % Instance_R = Instance_R + add1;
% % add2 =imfilter(Instance_G,p1);
% % Instance_G = Instance_G + add2;
% % add3 =imfilter(Instance_B,p1);
% % Instance_B = Instance_B + add3;
% 
% %指数增强对比度
% Instance_R = myExpEnhance(Instance_R,1.5);
% Instance_G = myExpEnhance(Instance_G,1.5);
% Instance_B = myExpEnhance(Instance_B,1.5);
% rgb = im2uint8(cat(3, Instance_R, Instance_G, Instance_B));
% subplot(325),imshow(rgb);title('srcrgb');
% 
% %sobel梯度算子检测边缘
% % Edge_R = edge(Instance_R, 'sobel');
% % Edge_G = edge(Instance_G, 'sobel');
% % Edge_B = edge(Instance_B, 'sobel');
% Edge_R = sobel(Instance_R);
% Edge_G = sobel(Instance_G);
% Edge_B = sobel(Instance_B);
% %将上一步的三个通道进行叠加合成
% rgb = im2uint8(cat(3, Edge_R, Edge_G, Edge_B));
% rim_gray = rgb2gray(rgb);
% subplot(321),imshow(rim_gray);title('sobelrgb');
% 
% % %%%%%%%%%
% % 这是直接把彩色图转换成灰度图来做的，效果不如先转成三通道分别作然后合成的好
% grayImage = rgb2gray(Image_);
% J2=edge(grayImage,'sobel');
% subplot(322),imshow(J2);title('sobel');
% % %%%%%%%%%
% 
% %闭操作，使得断裂的边缘联通
% se=strel('square',3);
% img_res = imclose(rim_gray,se);
% subplot(323),imshow(img_res);title('闭操作');
% 
% [B,L] = bwboundaries(img_res,'noholes');%寻找边缘，不包括孔
% figure(14);
% imshow(label2rgb(L, @jet, [.5 .5 .5]))%显示图像
% hold on
% for k = 1:length(B)
%    boundary = B{k}; %每一个都表示一个边缘
%    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)%画出边缘的横纵坐标
%    hold on;
% end%整个循环表示的是描边,将所有的描边画出来
% 
% %我的初步想法是还是按照答案的方法来做，然后画出边界，造一点假，留住我们想要留下的部分。
% %然后进行统计，统计的过程中除以2就是线条的长度 

clc;
clear;
%读入图像,是一个彩色图像
Image_=imread('rim.jpg');

%
%我想的是在预处理的时候加上区域生长的办法，第十章课件60页
%我定义的标准边缘像素的RGB值是（142，137，133）
%
figure(1);
imshow(Image_);
title('原图像');

%Image_ = region_grow(Image_);
%先用直方图均衡化增强一波对比度
Image_(:,:,1) = histeq(Image_(:,:,1), 256);
Image_(:,:,2) = histeq(Image_(:,:,2), 256);
Image_(:,:,3) = histeq(Image_(:,:,3), 256);
%RGB模式转换成YCbCr模式
Image_YCbCr = rgb2ycbcr(Image_);
%取亮度部分，也就是灰度部分
Image_Y = Image_YCbCr(:,:,1);
Image_Y_R = 255 - Image_Y;
figure(2);
imshow(Image_Y_R);
title('直方图均衡化后取出灰度值图像');

%取得了图片的一部分
up = 50;
down = 200;
left = 120;
right = 520;

for ii = up:1:down
    for jj = left:1:right
        Subimage(ii - up + 1, jj - left + 1) = Image_Y_R(ii, jj);
    end
end
figure(3);
imshow(Subimage);
title('截取小图');
%对其做直方图均衡化
Subimage = histeq(Subimage, 256);
figure(4);
imshow(Subimage);
title('直方图均衡化突出对比度');

%
%我真正应该在这里做区域生长,这里改成区域生长就可以了
%
Subimage = region_grow(Subimage);%区域生长，分别处理两个区域

figure(13);
imshow(Subimage);
title('区域生长后的图像');

Edge_image = edge(Subimage, 'sobel');
figure(5);
imshow(Edge_image);
title('sobel算子边缘检测');

%边缘桥接
Edge_image=bwmorph(Edge_image,'bridge',20);                  
figure(6);
imshow(Edge_image);
title('bridge连接边缘');

%闭操作，使得断裂的边缘联通
se=strel('square',3);
Edge_image = imclose(Edge_image,se);
figure(7);
imshow(Edge_image);
title('闭操作，连接断裂边缘');

%移除掉马刺的像素
Edge_image=bwmorph(Edge_image,'spur');                  
figure(8);
imshow(Edge_image);
title('移除了spur边缘');

%移除掉孤立像素
Edge_image=bwmorph(Edge_image,'clean');                  
figure(9);
imshow(Edge_image);
title('去除掉孤立像素噪点');

%细化，取得图像的骨架
Edge_image = bwmorph(Edge_image,'thin');
%去除图像的噪点
Edge_image = bwmorph(Edge_image,'clean',200);
figure(10);
imshow(Edge_image);
title('抽骨架，细化');

[B,L] = bwboundaries(Edge_image,'noholes');%寻找边缘，不包括孔
figure(11);
imshow(Edge_image);
%imshow(label2rgb(L, @jet, [.5 .5 .5]))%显示图像
hold on
for k = 1:length(B)
   boundary = B{k}; %每一个都表示一个边缘
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)%画出边缘的横纵坐标
   hold on;
end%整个循环表示的是描边,将所有的描边画出来
title('红线画出边缘');

%再要经过一个数据处理，去掉左上，右上以及中下部分的噪点
Edge_image = myDataProc(Edge_image);
% 
[B,L] = bwboundaries(Edge_image,'noholes');%寻找边缘，不包括孔
figure(12);
imshow(Edge_image);
%imshow(label2rgb(L, @jet, [.5 .5 .5]))%显示图像
hold on

cnt = 0;%统计数量
for k = 1:length(B)
   boundary = B{k}; %每一个都表示一个边缘
   cnt = cnt + size(boundary,1);
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)%画出边缘的横纵坐标
   hold on;
end%整个循环表示的是描边,将所有的描边画出来
title('去除噪点后画出边缘');

cnt = round(cnt /2);
fprintf('上半部分所包含的前三个倒U形叶片的外轮廓的弧长是%d个像素\n',cnt);