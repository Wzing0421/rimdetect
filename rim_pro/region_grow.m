function image = region_grow( Subimage )
%REGION_GROW Summary of this function goes here
%   Detailed explanation goes here

%���ȴ��������Ե�����½ǲ��֣�������x��ʼ110��ֹ150��y��36��39��Χ�ڵľ�������
%����ÿ��Ŀ��㣬��Ѱ��������һ����������ĵ㣬���������ѵ�˼��
darkestPos = 0;
for ii = 110:1:150
    mingray = 256;
    recpos = 0;
    for jj = 36:1:40%�������ҪѰ�ҵ��ǻҶ�ֵ��͵ĵ�
        %���������һ����Ϊ�߽�ĵ������ĵ㲢�һҶ���С�����䴦��
        if Subimage(ii,jj) < mingray
            recpos = jj;
            mingray = Subimage(ii,jj);
        end
    end
    Subimage(ii,recpos) = 30;
end

%ͬ������Ե�����Բ�������ϱ߽��д���(28,330)
tempX = 25;%��ʼ�����ǣ�28,330��
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

