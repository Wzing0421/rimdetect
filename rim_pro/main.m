% %�����ɫͼ�������ҵ��뷨�ǰѲ�ɫ�ĺͺڰ׵ķֱ���б�Ե���
% %����Ч��˭�ĺþ���˭��,������Ч����࣬�ó��������ò�ɫ��
% %sobel��prewitt���ӵĽ��Ҫ����log���Ӻ�robert���ӣ��������sobel����
% 
% 
% %�Ҿ����ƺ���Ҫ����һ����Ե��
% 
% %����ͼ��,��һ����ɫͼ��
% Image_=imread('rim.jpg');
% %�ֱ���RGB��������ķ���
% Instance_R = Image_(:,:,1);%Rͨ��
% Instance_G = Image_(:,:,2);%Gͨ��
% Instance_B = Image_(:,:,3);%Bͨ��
% 
% %ͼ���Ԥ������ǿ�Աȶȣ��񻯵�Ч�����ã�ָ������һ��Ч������Ҳû�䣬��Ŀǰ�뷨��ָ��һ��
% %Ŀǰ��ָ��1.5Ч����2��2.5��һ��
% % p1 =fspecial('sobel');
% % add1 =imfilter(Instance_R,p1);
% % Instance_R = Instance_R + add1;
% % add2 =imfilter(Instance_G,p1);
% % Instance_G = Instance_G + add2;
% % add3 =imfilter(Instance_B,p1);
% % Instance_B = Instance_B + add3;
% 
% %ָ����ǿ�Աȶ�
% Instance_R = myExpEnhance(Instance_R,1.5);
% Instance_G = myExpEnhance(Instance_G,1.5);
% Instance_B = myExpEnhance(Instance_B,1.5);
% rgb = im2uint8(cat(3, Instance_R, Instance_G, Instance_B));
% subplot(325),imshow(rgb);title('srcrgb');
% 
% %sobel�ݶ����Ӽ���Ե
% % Edge_R = edge(Instance_R, 'sobel');
% % Edge_G = edge(Instance_G, 'sobel');
% % Edge_B = edge(Instance_B, 'sobel');
% Edge_R = sobel(Instance_R);
% Edge_G = sobel(Instance_G);
% Edge_B = sobel(Instance_B);
% %����һ��������ͨ�����е��Ӻϳ�
% rgb = im2uint8(cat(3, Edge_R, Edge_G, Edge_B));
% rim_gray = rgb2gray(rgb);
% subplot(321),imshow(rim_gray);title('sobelrgb');
% 
% % %%%%%%%%%
% % ����ֱ�ӰѲ�ɫͼת���ɻҶ�ͼ�����ģ�Ч��������ת����ͨ���ֱ���Ȼ��ϳɵĺ�
% grayImage = rgb2gray(Image_);
% J2=edge(grayImage,'sobel');
% subplot(322),imshow(J2);title('sobel');
% % %%%%%%%%%
% 
% %�ղ�����ʹ�ö��ѵı�Ե��ͨ
% se=strel('square',3);
% img_res = imclose(rim_gray,se);
% subplot(323),imshow(img_res);title('�ղ���');
% 
% [B,L] = bwboundaries(img_res,'noholes');%Ѱ�ұ�Ե����������
% figure(14);
% imshow(label2rgb(L, @jet, [.5 .5 .5]))%��ʾͼ��
% hold on
% for k = 1:length(B)
%    boundary = B{k}; %ÿһ������ʾһ����Ե
%    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)%������Ե�ĺ�������
%    hold on;
% end%����ѭ����ʾ�������,�����е���߻�����
% 
% %�ҵĳ����뷨�ǻ��ǰ��մ𰸵ķ���������Ȼ�󻭳��߽磬��һ��٣���ס������Ҫ���µĲ��֡�
% %Ȼ�����ͳ�ƣ�ͳ�ƵĹ����г���2���������ĳ��� 

clc;
clear;
%����ͼ��,��һ����ɫͼ��
Image_=imread('rim.jpg');

%
%���������Ԥ�����ʱ��������������İ취����ʮ�¿μ�60ҳ
%�Ҷ���ı�׼��Ե���ص�RGBֵ�ǣ�142��137��133��
%
figure(1);
imshow(Image_);
title('ԭͼ��');

%Image_ = region_grow(Image_);
%����ֱ��ͼ���⻯��ǿһ���Աȶ�
Image_(:,:,1) = histeq(Image_(:,:,1), 256);
Image_(:,:,2) = histeq(Image_(:,:,2), 256);
Image_(:,:,3) = histeq(Image_(:,:,3), 256);
%RGBģʽת����YCbCrģʽ
Image_YCbCr = rgb2ycbcr(Image_);
%ȡ���Ȳ��֣�Ҳ���ǻҶȲ���
Image_Y = Image_YCbCr(:,:,1);
Image_Y_R = 255 - Image_Y;
figure(2);
imshow(Image_Y_R);
title('ֱ��ͼ���⻯��ȡ���Ҷ�ֵͼ��');

%ȡ����ͼƬ��һ����
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
title('��ȡСͼ');
%������ֱ��ͼ���⻯
Subimage = histeq(Subimage, 256);
figure(4);
imshow(Subimage);
title('ֱ��ͼ���⻯ͻ���Աȶ�');

%
%������Ӧ������������������,����ĳ����������Ϳ�����
%
Subimage = region_grow(Subimage);%�����������ֱ�����������

figure(13);
imshow(Subimage);
title('�����������ͼ��');

Edge_image = edge(Subimage, 'sobel');
figure(5);
imshow(Edge_image);
title('sobel���ӱ�Ե���');

%��Ե�Ž�
Edge_image=bwmorph(Edge_image,'bridge',20);                  
figure(6);
imshow(Edge_image);
title('bridge���ӱ�Ե');

%�ղ�����ʹ�ö��ѵı�Ե��ͨ
se=strel('square',3);
Edge_image = imclose(Edge_image,se);
figure(7);
imshow(Edge_image);
title('�ղ��������Ӷ��ѱ�Ե');

%�Ƴ�����̵�����
Edge_image=bwmorph(Edge_image,'spur');                  
figure(8);
imshow(Edge_image);
title('�Ƴ���spur��Ե');

%�Ƴ�����������
Edge_image=bwmorph(Edge_image,'clean');                  
figure(9);
imshow(Edge_image);
title('ȥ���������������');

%ϸ����ȡ��ͼ��ĹǼ�
Edge_image = bwmorph(Edge_image,'thin');
%ȥ��ͼ������
Edge_image = bwmorph(Edge_image,'clean',200);
figure(10);
imshow(Edge_image);
title('��Ǽܣ�ϸ��');

[B,L] = bwboundaries(Edge_image,'noholes');%Ѱ�ұ�Ե����������
figure(11);
imshow(Edge_image);
%imshow(label2rgb(L, @jet, [.5 .5 .5]))%��ʾͼ��
hold on
for k = 1:length(B)
   boundary = B{k}; %ÿһ������ʾһ����Ե
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)%������Ե�ĺ�������
   hold on;
end%����ѭ����ʾ�������,�����е���߻�����
title('���߻�����Ե');

%��Ҫ����һ�����ݴ���ȥ�����ϣ������Լ����²��ֵ����
Edge_image = myDataProc(Edge_image);
% 
[B,L] = bwboundaries(Edge_image,'noholes');%Ѱ�ұ�Ե����������
figure(12);
imshow(Edge_image);
%imshow(label2rgb(L, @jet, [.5 .5 .5]))%��ʾͼ��
hold on

cnt = 0;%ͳ������
for k = 1:length(B)
   boundary = B{k}; %ÿһ������ʾһ����Ե
   cnt = cnt + size(boundary,1);
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)%������Ե�ĺ�������
   hold on;
end%����ѭ����ʾ�������,�����е���߻�����
title('ȥ�����󻭳���Ե');

cnt = round(cnt /2);
fprintf('�ϰ벿����������ǰ������U��ҶƬ���������Ļ�����%d������\n',cnt);