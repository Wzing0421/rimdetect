function [ img_proc ] = sobel( img )
%SOBEL Summary of this function goes here
%   Detailed explanation goes here
%运用sobel算子计算图像边缘

%将图像从uint8形式转换成double类型否则在加减的时候会产生溢出等影响精度事情
img_double = im2double(img);
%获取行数和列数
%[m,n] = size(img_double);

y_grad = [-1 -2 -1;0 0 0 ;1 2 1]; %垂直梯度的模板
x_grad = y_grad'; %水平方向的模板

%分别计算水平和垂直方向的索贝尔梯度
gradx = abs(filter2(x_grad,img_double,'same'));
grady = abs(filter2(y_grad,img_double,'same'));

scale = 4; %用于计算阈值
b = gradx.*gradx + grady.*grady;
img_proc = gradx + grady;
cutoff = scale*mean2(b);
thresh = sqrt(cutoff);
img_proc = img_proc > thresh;
end

