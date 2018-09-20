function [] = ADD_TREE(city,T)
% 在原有的地图上增加几条线

[T1,~] = size(T);
for i = 1:T1
    x = T(i,1);
    y = T(i,2);
    plot([city.long(x),city.long(y)],[city.lat(x),city.lat(y)],'b');
    hold on
end

end

