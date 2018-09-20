clear
clc
load DATA
% �������������п����ɵ�����������Ϊ��ת


% ��λ������
% ˳��from 1 to 12
% ����&��� ������ ��³ľ�� ���� ֣�� �Ϻ� ���� �ɶ� ���� �人 ���� ����&����

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
%                 ��ʱ����������³ľ����Ϊ�н鿼�鷶Χ
%             if (k ~= i) && (k ~= j) && (i ~=j) && (k ~=3) && (k~=7)
%                 ��ʱ������������³ľ����Ϊ���鷶Χ
               if sqrt(Population(i)*Population(j))>sqrt(Population(i)*Population(k))+sqrt(Population(k)*Population(j))
                  fprintf('%d �� %d ֮�����ͨ�� %d��Ϊ�м�\n',i, j, k);
                   count = count + 1;
                   relay_city_list=[relay_city_list, k];
%                    �����ֵ��ֵ
                   % captacity_i_j = cal_captacity(Distance(i,j));
                   captacity_i_k = cal_captacity(Distance(i,k));
                   captacity_k_j = cal_captacity(Distance(k,j));
                   
                   delta_old_weight = captacity_i_k*sqrt(Population(i)*Population(k))+captacity_k_j*sqrt(Population(k)*Population(j));
                   
                   if captacity_k_j>captacity_i_k
                       % i k ����
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
fprintf('һ���м̵���ܱ�ѡΪ�н����');
relay_city_list=unique(relay_city_list)
fprintf('1���м̵㣬�ܹ���%d�����\n',count);
possible_situation = sortrows(possible_situation,5);
%possible_situation = sortrows(possible_situation,7);
% �����������������ˮƽpossible_situation��������

% ע�⣬��ʱ��delta_weight���뵱ǰ����ͨ·�Ѿ���ͨʱ���жԱȵ�����,�������ڼ�����·���Ż�
% ��i,j,k֮��ֻ������һ��ʱ����ֻ����i,k,��ô���Լ���������Ҫ��������kjһ���ߣ�֮��������ӵ�delta_weight��
% ���������жϽ������ܷ���������






relay_three_city_list=[];
possible_three_city_situation = [];

count = 0;
list=[];
for i=1:12
    for j = i:12
%         ����k, l
        for k = 1:12
            for l = k:12
                if (k ~= i) && (k ~= j) && (i ~=j)&&(l ~= i)&& (l ~= j)&&(l~= k)&&(Distance(i,k)<3000||Distance(i,l)<3000)&&(Distance(j,k)<3000||Distance(j,l)<3000)
%                     ���ֽ��������������³ľ����Ϊ�н����
%                 if (k ~= i) && (k ~= j) && (i ~=j)&&(l ~= i) && (l ~= j)&&(l~= k) && (k ~=3) && (k~=7) &&(l ~=3) && (l~=7)
%                       ��ʱ�н���в�������������³ľ��
                   if sqrt(Population(i)*Population(j))>sqrt(Population(i)*Population(k))+sqrt(Population(k)*Population(l))+sqrt(Population(l)*Population(j))
%                     % �ж������м̵�����Ƿ�����һ���м̵����
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
                           fprintf('%d �� %d ֮�����ͨ�� %d��%d��Ϊ�м�\n',i, j, k, l);
                           count = count + 1;
                           str_f = sprintf('%d��%d\n',k,l);
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
fprintf('2���м̵���ܱ�ѡΪ�н����');
list=unique(list)
fprintf('2���м̵��ܹ���%d�����\n',count);




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
% %                     ���ֽ��������������³ľ����Ϊ�н����
% %                   if (k ~= i) && (k ~= j) && (i ~=j)&&(l ~= i) && (l ~= j)&&(l~= k) && (k ~=3) && (k~=7) &&(l ~=3) && (l~=7)&&(m ~= i) && (m ~= j) &&(m ~= k) && (m ~= l)
% %                       ��ʱ�н���в�������������³ľ��
%                    if sqrt(Populations(i)*Populations(j))>sqrt(Populations(i)*Populations(k))+sqrt(Populations(k)*Populations(l))+sqrt(Populations(l)*Populations(j))
% %                        fprintf('%d �� %d ֮�����ͨ�� %d��%d��%d��Ϊ�м�\n',i, j, k, l,m);
%                        count = count + 1;
%                     end
%                    end
%                 end
%             end
%         end
%     end
% end
% fprintf('3���м̵��ܹ���%d�����\n',count);
                
 




              