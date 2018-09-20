load Matrix_NV
load DATA

% city_connection_list=[];
% % list used to save the cities to store relay cities
% for i=1:12
%     for j = i+1:12
%         if Distance(i,j)<3000 
%             city_connection_list = [city_connection_list;[i,j]];
%         end
%     end
% end
% 
% %popm = randperm(61, N);
% popm = [16,43,17,13,30,60,39,32,60,33,11,2,5,14,58,18];
% total_weight = 0
% for t=1:length(popm)
%     route = city_connection_list(popm(t),:)
%     total_weight = total_weight - Matrix_NV(route(1),route(2));
% end
% total_weight

% 
%     A = [6 2 3 4 5 1 7 8 9 ];
%     B = [11 12 13 14 15 6 17 18 19];
%     L = length(A);
%     W = randperm(L);
%     start_point = W(1);
%     end_point = W(2);
%     if start_point>end_point
%         [start_point, end_point] = exchange(start_point, end_point);
%     end
%         start_point
%         end_point
%         
%     for i = start_point:end_point
%        if isempty(find(B==A(i))) && isempty(find(A==B(i)))
%            [A(i),B(i)] = exchange(A(i),B(i));
%        else
%                        fprintf('%d²»»»',i)
% 
%        end
%        
%     end
%     A
%     B

% cities = [];
% 
% A = [1 3 4 5 9 56 37 57 61 21 38 26 8 30 52 58]
% A = [1 3 4 5 9 56 60 57 37 21 38 26 8 30 52 58]
% A = [1 3 4 5 9 61 46 31 32 7 38 39 40 30 52 58 56 60 57 37 21 26 8 30 29 11 42 43 44 36 55 34 10]
% length(A)
% for i=1:length(A)
%     cityAB= city_connection_list(A(i),:);
%     cities = [cities, cityAB(1), cityAB(2)];
%     cities = unique(cities);
%     if length(cities) == 12;
%         result = 1;
%         % connected
%     else
%         result = 0;
%         % not connected
%     end
% end
% result
% route =[];
% for i = 1:length(A)
%     cityAB= city_connection_list(A(i),:);
%     cities = [cityAB(1), cityAB(2)];
%     route = [route;cities];
% end

% load city_connection_list
% 
% A = [2 3 4 5 6];
% route = []
% relay_pool = []
% count = 0
% for i=1:length(possible_situation)
%     routea = sort(possible_situation(i,1:2));
%     routeb = sort(possible_situation(i,3:4));
%     for t = 1:61
%          for m = 1:61
%               if city_connection_list(t,1) == routea(1) && city_connection_list(t,2) == routea(2)...
%                  && city_connection_list(m,1) == routeb(1) && city_connection_list(m,2) == routeb(2)
%   
%                        fprintf('routea=%d\t',t)
%                        fprintf('routeb=%d\n',m)
%                        count = 1 + count;
%                        delta = possible_situation(i,5);
%                        route = [t,m, delta];
%                        relay_pool = [relay_pool; route];
%             end
%         end
%     end
%     
% end
% save relay_pool

    A = [[2 3 4 7 6]; 
        [2 3 4 8 6];
        [2 3 4 5 6];
        [2 3 4 5 6];
         [2 3 4 6 5];
        ]
   B = unique(A,'rows')  
   sort(A)
   C = unique(A,'rows')
   
