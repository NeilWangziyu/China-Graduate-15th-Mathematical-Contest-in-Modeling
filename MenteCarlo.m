clear
clc
load DATA

N = 16;     % route
M = 20;     % 种群数量
C = 1000;
Pc = 0.4;   %交叉概率
m = 2;      %适应性归一化淘汰加速指数
Pmutation = 0.2;    %变异概率
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
city_connection_list=[];
% list used to save the cities to store relay cities
for i=1:12
    for j = i+1:12
        if Distance(i,j)<3000 
            city_connection_list = [city_connection_list;[i,j]];
        end
    end
end

% 生成初始群体
popm =zeros(M,N);

for i=1:M
    popm(i, :) = randperm(61, N);
end
popmInit = popm;
% city_connection_list代表了所有的路线连接情况

% 初始化种群及适应函数
fitness = zeros(M,1);
% fitness代表了这次路程优化的最终路线价值
len = zeros(M,1);
for i=1:M
    len(i,1) = Calculation_total_value(popm(i,:));
    % len矩阵储存每一种情况下popm的总价值
end

maxlen = max(len);
TotalBestValue = maxlen;

rr = find(len==maxlen);
R = popm(rr(1,1),:);
%   R代表保存着的最佳连接路线
value_max = zeros(C+1, 1);
TotalBestRoute = R;
fprintf('初始全局最佳%d\n',TotalBestValue);
fprintf('路线：');
TotalBestRoute
            
%   开始迭代
while C>=0
    fprintf('迭代%d次\n',C);
    
        % 蒙特卡洛每次更新
        for i=1:M
            popm(i, :) = randperm(61, N);
        end
        
        % 求适应度函数
        NN= size(popm, 1);
        len = zeros(NN,1);
        for i=1:M
            len(i,1) = Calculation_total_value(popm(i,:));
            % len矩阵储存每一种情况下popm的总价值
        end

        maxlen = max(len);
        rr = find(len==maxlen);
        %  fprintf('maxlen=%d\n',maxlen);
        R = popm(rr(1,1),:);
        %   R代表保存着的最佳连接路线

        if maxlen>TotalBestValue
            TotalBestValue = maxlen;
            TotalBestRoute = R;
            fprintf('更新全局最佳\n');
            fprintf('全局最佳%d\n',TotalBestValue);
            fprintf('路线：');
            TotalBestRoute

        end
    
    C = C - 1;
    
end
