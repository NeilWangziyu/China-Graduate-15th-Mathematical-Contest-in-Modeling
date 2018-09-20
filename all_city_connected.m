function result = all_city_connected(A, city_connection_list)
%all_city_connected return True when all city is connected
result = 0;

num_A = length(A);
P = city_connection_list(A(1:num_A),:); 

J = zeros(12,12);
for i = 1:num_A
    J(P(i,1),P(i,2)) = 1;
end

if all(sum(J)+sum(J'))
    flag = zeros(1,12); 
    value = 1;
    while(1)
        flag(value) = 1;
        if all(flag)
            result = 1;
            break;
        end
        num1 = length(value);
        value_next = [];
        for i = 1:num1
            [x,y] = find(P==value(i));
            if ~isempty(x)
                for j=1:length(x)
                    if y(j)==1
                        value_next = [value_next,P(x(j),2)];
                    else
                        value_next = [value_next,P(x(j),1)];
                    end
                    P(x(j),:) = 0;
                end
            end 
        end
        value_next = unique(value_next);
        value = value_next;
        if isempty(value)
            break;
        end
    end %while(1)
end

end




