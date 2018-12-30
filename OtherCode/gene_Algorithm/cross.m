function [A,B] = cross(A,B)
%cross 
%   交叉操作
    L = length(A);
    if L<10
        W = L;
    elseif ((L/10) - floor(L/10))>=rand&&L>10
        W = ceil(L/10)+8;
%         ceil(x)：向右取整
    else
        W = floor(L/10)+8;
%         floor(x)：向左取整
    end
    p = unidrnd(L-W+1);
    fprintf('p=%d',p);
    for i = 1:W
        x = find(A == B(1, p+i-1));
        y = find(B == A(1, p+i-1));
        [A(1,p+i-1),B(1,p+i-1)] = exchange(A(1, p+i-1),B(1,p+i-1));
        [A(1,x),B(1,y)] = exchange(A(1,x),B(1,y));
    end
end

