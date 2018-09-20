clear
clc
load DATA
% 计算哪两座城市可以由第三座城市作为中转


% 单位：万人
% 顺序：from 1 to 12
% 北京&天津 哈尔滨 乌鲁木齐 西安 郑州 上海 拉萨 成都 重庆 武汉 昆明 广州&深圳

for i=1:12
    for j = 1:12
        if i>j
            Distance(i,j) = Distance(j,i);
        end
    end
end


count = 0;
relay_city_list=[];
possible_situation = [];
% list used to save the cities to store relay cities
for i=1:12
    for j = i+1:12
        for k = 1:12
            if (k ~= i) && (k ~= j)&& Distance(i,k)<3000 && Distance(k,j)<3000
%                 此时将拉萨与乌鲁木齐列为中介考查范围
%             if (k ~= i) && (k ~= j) && (i ~=j) && (k ~=3) && (k~=7)
%                 此时不将拉萨与乌鲁木齐列为考查范围
               if sqrt(Population(i)*Population(j))>sqrt(Population(i)*Population(k))+sqrt(Population(k)*Population(j))
                  fprintf('%d 与 %d 之间可以通过 %d作为中继\n',i, j, k);
                   count = count + 1;
                   relay_city_list=[relay_city_list, k];
%                    计算价值差值
                   % captacity_i_j = cal_captacity(Distance(i,j));
                   captacity_i_k = cal_captacity(Distance(i,k));
                   captacity_k_j = cal_captacity(Distance(k,j));
                   
                   delta_old_weight = captacity_i_k*sqrt(Population(i)*Population(k))+captacity_k_j*sqrt(Population(k)*Population(j));
                   
                   if captacity_k_j>captacity_i_k
                       % i k 满载
                       delta_new_weight = captacity_i_k*sqrt(Population(i)*Population(j))+(captacity_k_j-captacity_i_k)*sqrt(Population(k)*Population(j));
                   elseif captacity_k_j<captacity_i_k
                       delta_new_weight = captacity_k_j*sqrt(Population(k)*Population(j))+(captacity_i_k-captacity_k_j)*sqrt(Population(k)*Population(i));
                   else
                       delta_new_weight = captacity_k_j*sqrt(Population(i)*Population(j));
                   end
                   
                   delta_weight = delta_new_weight-delta_old_weight;
                   routea = [i,k];
                   routeb = [k,j];
                   situation = [routea,routeb,delta_new_weight,delta_old_weight, delta_weight];
                   possible_situation = [possible_situation;situation];
               end
               
            end
        end
    end
end
fprintf('一个中继点可能被选为中介城市');
relay_city_list=unique(relay_city_list)
fprintf('1个中继点，总共有%d种情况\n',count);
possible_situation = sortrows(possible_situation,5);
%possible_situation = sortrows(possible_situation,7);
% 此种情况按照提升的水平possible_situation进行排序

% 注意，此时的delta_weight是与当前两条通路已经联通时进行对比的增益,可以用于既有线路的优化
% 当i,j,k之间只连接了一点时，如只连接i,k,那么可以计算出如果需要继续连接kj一条线，之后可以增加的delta_weight，
% 可以用于判断接下来能否增加连接






relay_three_city_list=[];
possible_three_city_situation = [];

count = 0;
list=[];
for i=1:12
    for j = i:12
%         遍历k, l
        for k = 1:12
            for l = k:12
                if (k ~= i) && (k ~= j) && (i ~=j)&&(l ~= i)&& (l ~= j)&&(l~= k)&&(Distance(i,k)<3000||Distance(i,l)<3000)&&(Distance(j,k)<3000||Distance(j,l)<3000)
%                     此种解包括将拉萨和乌鲁木齐作为中介城市
%                 if (k ~= i) && (k ~= j) && (i ~=j)&&(l ~= i) && (l ~= j)&&(l~= k) && (k ~=3) && (k~=7) &&(l ~=3) && (l~=7)
%                       此时中介城市不包括拉萨与乌鲁木齐
                   if sqrt(Population(i)*Population(j))>sqrt(Population(i)*Population(k))+sqrt(Population(k)*Population(l))+sqrt(Population(l)*Population(j))
%                     % 判断两个中继点情况是否优于一个中继点情况
                        if sqrt(Population(i)*Population(k))+sqrt(Population(k)*Population(l))+sqrt(Population(l)*Population(j)) > sqrt(Population(i)*Population(k))+sqrt(Population(k)*Population(j)) ...
                                && sqrt(Population(i)*Population(k))+sqrt(Population(k)*Population(l))+sqrt(Population(l)*Population(j)) > sqrt(Population(i)*Population(l))+sqrt(Population(l)*Population(j))
                            %   -----------------
                            % captacity_i_j = cal_captacity(Distance(i,j));
                            captacity_i_k = cal_captacity(Distance(i,k));
                            captacity_k_l = cal_captacity(Distance(k,l));
                            captacity_l_j = cal_captacity(Distance(k,l));
                            
                            min_captcity = min(captacity_i_k,captacity_k_l);
                            min_captcity = min(captacity_l_j, min_captcity);
                            
                            delta_new_weight = sqrt(Population(i)*Population(j))*min_captcity+ sqrt(Population(i)*Population(k))*(captacity_i_k-min_captcity) + sqrt(Population(k)*Population(l))*(captacity_k_l-min_captcity) + sqrt(Population(l)*Population(j))*(captacity_l_j-min_captcity)
                            delta_old_weight =  sqrt(Population(i)*Population(k))*(captacity_i_k) + sqrt(Population(k)*Population(l))*(captacity_k_l) + sqrt(Population(l)*Population(j))*(captacity_l_j)
                            delta_weight = delta_new_weight - delta_old_weight
                            
                            
                            %   -----------------
                           fprintf('%d 与 %d 之间可以通过 %d和%d作为中继\n',i, j, k, l);
                           count = count + 1;
                           str_f = sprintf('%d与%d\n',k,l);
                           list=[list, k, l];
                           
                           routea = [i,k];
                            routeb = [k,l];
                            routec = [l,j];
                            
                            three_situation = [routea,routeb,routec, delta_new_weight,delta_old_weight];
                            possible_three_city_situation = [possible_three_city_situation;three_situation];
                        end
                   end
                end
            end
        end
    end
end
fprintf('2个中继点可能被选为中介城市');
list=unique(list)
fprintf('2个中继点总共有%d种情况\n',count);




% 
% 
%  
% count = 0;
% list=[];
% for i=1:12
%     for j = i:12
%         for k = 1:12
%             for l = 1:12
%                 for m = 1:12
%                     if (k ~= i) && (k ~= j) && (i ~=j)&&(l ~= i) && (l ~= j)&&(l~= k)&&(m ~= i) && (m ~= j) &&(m ~= k) && (m ~= l)
% %                     此种解包括将拉萨和乌鲁木齐作为中介城市
% %                   if (k ~= i) && (k ~= j) && (i ~=j)&&(l ~= i) && (l ~= j)&&(l~= k) && (k ~=3) && (k~=7) &&(l ~=3) && (l~=7)&&(m ~= i) && (m ~= j) &&(m ~= k) && (m ~= l)
% %                       此时中介城市不包括拉萨与乌鲁木齐
%                    if sqrt(Populations(i)*Populations(j))>sqrt(Populations(i)*Populations(k))+sqrt(Populations(k)*Populations(l))+sqrt(Populations(l)*Populations(j))
% %                        fprintf('%d 与 %d 之间可以通过 %d、%d和%d作为中继\n',i, j, k, l,m);
%                        count = count + 1;
%                     end
%                    end
%                 end
%             end
%         end
%     end
% end
% fprintf('3个中继点总共有%d种情况\n',count);
                
 




              