function [] = ADD_TREE(city,T)
% ��ԭ�еĵ�ͼ�����Ӽ�����

[T1,~] = size(T);
for i = 1:T1
    x = T(i,1);
    y = T(i,2);
    plot([city.long(x),city.long(y)],[city.lat(x),city.lat(y)],'b');
    hold on
end

end

