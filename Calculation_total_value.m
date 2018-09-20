function [ total_weight ] = Calculation_total_value(one_popm)
%Calculation_total_value 用于计算某一次遍历后的权重
load Matrix_NV
load DATA
load city_connection_list
load relay_pool

total_weight = 0;
count = 0;
result = all_city_connected(one_popm,city_connection_list);
if result==1
 %-------  
           route_all = (one_popm);
        %total_weight = total_weight + Matrix_NV(route(1),route(2));
        % 首先寻找特殊中继节点 同时出现10，45，57
        if find(route_all == 10) & find(route_all == 61)&find(route_all == 57)
            total_weight = total_weight + 609.33;
            route_all(find(route_all == 10)) = [];
            route_all(find(route_all == 61)) = [];
            route_all(find(route_all == 57)) = [];
            %fprintf('昆明为北京，重庆，广州中继点');
            count = count + 1;
        elseif find(route_all == 10) & find(route_all == 45)&find(route_all == 57)
            total_weight = total_weight + 488.98;
            route_all(find(route_all == 10)) = [];
            route_all(find(route_all == 45)) = [];
            route_all(find(route_all == 57)) = [];
            %fprintf('昆明为北京，重庆，上海中继点');
            count = count + 1;
        end
        
        %--------------
         for index=1:length(relay_pool)
            if find(route_all == relay_pool(index,1)) & find(route_all == relay_pool(index,2))
                % 存在中继点
                total_weight = total_weight + relay_pool(index,3);
                route_all(find(route_all == relay_pool(index,1))) = [];
                route_all(find(route_all == relay_pool(index,2))) = [];
                count = count + 1;
                %fprintf('index=%d的中继路线已找到\n',index)
            end
         end   
        % ------------
        %fprintf('存在中继线路%d条\n',count);
        
        % ---下面按照顺序计算
        for t=1:length(route_all)
            route_used = city_connection_list(route_all(t),:);
            total_weight = total_weight + Matrix_NV(route_used(1),route_used(2));
        end
  %-------------  
else
    % 不连通情况
end

end

