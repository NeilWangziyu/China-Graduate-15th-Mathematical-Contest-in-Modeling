function [ total_weight ] = Calculation_total_value(one_popm)
%Calculation_total_value ���ڼ���ĳһ�α������Ȩ��
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
        % ����Ѱ�������м̽ڵ� ͬʱ����10��45��57
        if find(route_all == 10) & find(route_all == 61)&find(route_all == 57)
            total_weight = total_weight + 609.33;
            route_all(find(route_all == 10)) = [];
            route_all(find(route_all == 61)) = [];
            route_all(find(route_all == 57)) = [];
            %fprintf('����Ϊ���������죬�����м̵�');
            count = count + 1;
        elseif find(route_all == 10) & find(route_all == 45)&find(route_all == 57)
            total_weight = total_weight + 488.98;
            route_all(find(route_all == 10)) = [];
            route_all(find(route_all == 45)) = [];
            route_all(find(route_all == 57)) = [];
            %fprintf('����Ϊ���������죬�Ϻ��м̵�');
            count = count + 1;
        end
        
        %--------------
         for index=1:length(relay_pool)
            if find(route_all == relay_pool(index,1)) & find(route_all == relay_pool(index,2))
                % �����м̵�
                total_weight = total_weight + relay_pool(index,3);
                route_all(find(route_all == relay_pool(index,1))) = [];
                route_all(find(route_all == relay_pool(index,2))) = [];
                count = count + 1;
                %fprintf('index=%d���м�·�����ҵ�\n',index)
            end
         end   
        % ------------
        %fprintf('�����м���·%d��\n',count);
        
        % ---���水��˳�����
        for t=1:length(route_all)
            route_used = city_connection_list(route_all(t),:);
            total_weight = total_weight + Matrix_NV(route_used(1),route_used(2));
        end
  %-------------  
else
    % ����ͨ���
end

end

