function P = LOCATION(count,index,N)
% 找到count个最大值在矩阵中的位置坐标

P = zeros(count,2); % 最大count个值所在位置
for i = 1:count
    p = index(i);
    x = rem(p,N);
    if x == 0
        x = N;
    end
    y = ceil(p/N);
    P(i,:) = [x,y];
end

end

