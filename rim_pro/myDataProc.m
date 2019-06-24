function Edge_image = myDataProc(Edge_image) 
%MY Summary of this function goes here
%   Detailed explanation goes here

%将左上角，右上角，右下角的数据除去，因为它们包含着除了三个边缘以外的信息
   %获得行数和列数的平均值
   for ii = 1:1:size(Edge_image,1)%行数
       for jj = 1:1:size(Edge_image,2)%列数
           
           if(Edge_image(ii,jj)==1)%是白色
               %if((ii + jj < 100) || (ii>100 && jj >=140 && jj <=350)|| (ii>80 && jj >=160 && jj <=220) || (jj - ii > 310) )
               if((ii + jj < 100) || (ii>100 && jj >=140 && jj <=350)|| (ii>80 && jj >=160 && jj <=220) || (ii<=20 && jj >=300)  )
                   Edge_image(ii,jj)=0;
               end
           end
           
       end
   end
   %plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)%画出边缘的横纵坐标
   %title('第%d个',k);


end

