function [ img_proc ] = sobel( img )
%SOBEL Summary of this function goes here
%   Detailed explanation goes here
%����sobel���Ӽ���ͼ���Ե

%��ͼ���uint8��ʽת����double���ͷ����ڼӼ���ʱ�����������Ӱ�쾫������
img_double = im2double(img);
%��ȡ����������
%[m,n] = size(img_double);

y_grad = [-1 -2 -1;0 0 0 ;1 2 1]; %��ֱ�ݶȵ�ģ��
x_grad = y_grad'; %ˮƽ�����ģ��

%�ֱ����ˮƽ�ʹ�ֱ������������ݶ�
gradx = abs(filter2(x_grad,img_double,'same'));
grady = abs(filter2(y_grad,img_double,'same'));

scale = 4; %���ڼ�����ֵ
b = gradx.*gradx + grady.*grady;
img_proc = gradx + grady;
cutoff = scale*mean2(b);
thresh = sqrt(cutoff);
img_proc = img_proc > thresh;
end

