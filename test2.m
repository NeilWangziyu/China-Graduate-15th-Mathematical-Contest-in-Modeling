load Matrix_NV
load DATA
load city_connection_list
load relay_pool

route = [1	2	3	4	5	6	7	8	9	11	23	26	29	30	31	34	36	37	38	42	43	44	46	48	52	53	54	55	56	57	58	60	61];
one_popm =  route %[[26,38,48,43,7,36,55,5,31,56,2,54,52,44,42,60,37,30,4,61,16,1,57,46,11,3,58,18,29,34,53,9,8];
%     [26,38,48,43,7,36,55,5,31,56,2,54,52,44,42,60,37,30,4,61,16,1,57,46,11,3,58,18,29,34,53,9,8]]
% popm = unique(popm_sel,'rows');
% one_popm = unique(one_popm, 'rows')
total_weight = 0;
count = 0;
result = 1;
%result = all_city_connected(one_popm,city_connection_list);
if result==1
 %-------  
           route_all = (one_popm);
        %total_weight = total_weight + Matrix_NV(route(1),route(2));
        
         for index=1:length(relay_pool)
            if find(route_all == relay_pool(index,1)) & find(route_all == relay_pool(index,2))
                % 存在中继点
                total_weight = total_weight + relay_pool(index,3);
                route_all(find(route_all == relay_pool(index,1))) = [];
                route_all(find(route_all == relay_pool(index,2))) = [];
                count = count + 1;
                fprintf('index=%d的中继路线已找到\n',index)
            end
         end    
        fprintf('存在中继线路%d条\n',count);
        
        % ---下面按照顺序计算
        route_all
        for t=1:length(route_all)
            route_used = city_connection_list(route_all(t),:);
            total_weight = total_weight + Matrix_NV(route_used(1),route_used(2));
        end
  %-------------  
else
    % 不连通情况
    total_weight = 0;
end

total_weight
