function Edge_image = myDataProc(Edge_image) 
%MY Summary of this function goes here
%   Detailed explanation goes here

%�����Ͻǣ����Ͻǣ����½ǵ����ݳ�ȥ����Ϊ���ǰ����ų���������Ե�������Ϣ
   %���������������ƽ��ֵ
   for ii = 1:1:size(Edge_image,1)%����
       for jj = 1:1:size(Edge_image,2)%����
           
           if(Edge_image(ii,jj)==1)%�ǰ�ɫ
               %if((ii + jj < 100) || (ii>100 && jj >=140 && jj <=350)|| (ii>80 && jj >=160 && jj <=220) || (jj - ii > 310) )
               if((ii + jj < 100) || (ii>100 && jj >=140 && jj <=350)|| (ii>80 && jj >=160 && jj <=220) || (ii<=20 && jj >=300)  )
                   Edge_image(ii,jj)=0;
               end
           end
           
       end
   end
   %plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)%������Ե�ĺ�������
   %title('��%d��',k);


end

