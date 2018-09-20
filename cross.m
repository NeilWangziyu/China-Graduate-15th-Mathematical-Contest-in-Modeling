function [A,B] = cross(A,B)
%cross 
%   ½»²æ²Ù×÷
    L = length(A);
    W = randperm(L);
    start_point = W(1);
    end_point = W(2);
    if start_point>end_point
        [start_point, end_point] = exchange(start_point, end_point);
    end
        
    for i = start_point:end_point
       if isempty(find(B==A(i))) && isempty(find(A==B(i)))
           [A(i),B(i)] = exchange(A(i),B(i));
       end
end

