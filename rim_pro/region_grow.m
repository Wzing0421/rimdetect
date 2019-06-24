function image = region_grow( Subimage )
%REGION_GROW Summary of this function goes here
%   Detailed explanation goes here

%首先处理第三边缘的左下角部分，区域是x起始110终止150，y在36到39范围内的矩形里面
%对于每个目标点，都寻找他下面一层符合条件的点，类似于深搜的思想
darkestPos = 0;
for ii = 110:1:150
    mingray = 256;
    recpos = 0;
    for jj = 36:1:40%这个区域要寻找的是灰度值最低的点
        %如果是与上一个认为边界的点相连的点并且灰度最小，将其处理
        if Subimage(ii,jj) < mingray
            recpos = jj;
            mingray = Subimage(ii,jj);
        end
    end
    Subimage(ii,recpos) = 30;
end

%同样道理对第三个圆弧的右上边进行处理(28,330)
tempX = 25;%起始坐标是（28,330）
for jj = 325:1:401
    recMax = 0;
    recposX = 0;
     for ii = tempX -1:1:tempX + 2
         if Subimage(ii,jj) > recMax
             recMax = Subimage(ii,jj);
             recposX = ii;
         end
     end
     tempX = recposX;
     Subimage(tempX,jj) = 240;
     Subimage(tempX+1,jj) = 240;
end

image = Subimage;
end

