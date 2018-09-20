
clear
load possible_situation
load city_connection_list
pool = [];
relay_pool =[];
for index = 1:59

            routea = sort(possible_situation(index,1:2));
            routeb = sort(possible_situation(index,3:4));
            weight = possible_situation(index,5);
            delta = possible_situation(index,7);


        for i = 1:61
            for j = 1:61
                wayi = city_connection_list(i,:);
                wayj = city_connection_list(j,:);
                if wayi(1)==routea(1) &  wayi(2)==routea(2)  & wayj(1)==routeb(1)&wayj(2)==routeb(2)
                        pool = [i,j,weight,delta];
                        relay_pool = [relay_pool;pool];
                end
            end
        end
end
relay_pool = sortrows(relay_pool,-4);
relay_pool(:,4)=[];
