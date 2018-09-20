clear
clc
load DATA
load relay_pool

N = 33;     % route
M = 100;     % 种群数量
C = 1500;
C_old = C;
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
city_connection_pool = linspace(1,61,61);


% 生成初始群体
popm =zeros(M,N);

for i=1:M
    popm(i, :) = randperm(61, N);
end
%popm(M,:) =  [1 3 4 5 9 19 27 31 32 35 38 39 40 30 52 58];
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
minlen = min(len);
fitness = fit(len, maxlen, minlen);

rr = find(len==maxlen);
R = popm(rr(1,1),:);
%   R代表保存着的最佳连接路线
TotalBestValue = maxlen;
TotalBestRoute = R;
precent = 0;
% 存活比例
fprintf('初始全局最佳%d\n',TotalBestValue);
fprintf('路线：');
TotalBestRoute


%   开始迭代
while C>=0
    fprintf('迭代%d次\n',C_old-C);
       
    
    
        % 选择操作
        nn = 0;
        % 这一次选择之后，留下nn条染色体
         number = size(popm,1) ;
         if number<1000
             jc = rand*0.95;
         elseif number < 3000
             jc = 0.90;
         elseif number < 6000
             jc = 0.95;
             fprintf('数量过多，生存压力增大')
         elseif number <10000
             jc = 0.97;
             fprintf('数量过多，生存压力增大')
         elseif number < 15000
             jc = 0.99;
             fprintf('数量过多，生存压力增大')
         else
             jc = 0.995;
             fprintf('数量过多，生存压力增大')
         end
         
        for i =1:size(popm,1)
            if all_city_connected(popm(i,:), city_connection_list) ==1
                if fitness(i,1)>=jc
                    % 染色体存活
                    nn = nn+1;
                    popm_sel(nn, :) = popm(i,:);
                end
            end
        end
        fprintf('第%d次选择之后，共有%d只种群存活\n',C_old-C, nn);
        percent = nn / number;
        fprintf('存活比例%2f\n',percent);
        
        
        % 交叉操作
        for i=1:floor(nn/2)
          % 四分之一的发生交换
          nn= size(popm_sel, 1);
          nnper = randperm(nn);
          % nnper 是一组数列从1-nn
          A = popm_sel(nnper(1), :);
          B = popm_sel(nnper(2), :);
          [A, B] = cross(A, B);
          popm_sel = [popm_sel;A;B];
        end
        
        %popm_sel = unique(popm_sel, 'rows');
        
        % 小变异操作操作
        % 替换操作，将已有的某一个值替换为未加入的一个值
        Mutation_small_add = [];
        nn= size(popm_sel, 1);
        % 此时需要更新nn
        for  i=1:floor(nn/2)
            pick = rand;
            % rand生成0-1之间的数
            while pick == 0
                pick = rand;
            end
            if pick <= Pmutation
                pool_tem = setdiff(city_connection_pool, popm_sel(i,:));
                length_pool = length(pool_tem);
                index_popm = randperm(N,1);
                index_pool = randperm(length_pool,1);
                % 生成popm和pool的index
                mutated_popm = popm_sel(i,:);
                mutated_popm(index_popm) = pool_tem(index_pool);
                Mutation_small_add = [Mutation_small_add;mutated_popm];
            end
        end
        popm_sel = [popm_sel;Mutation_small_add];
        
        % 大变异操作
        % 直接加上随机的新值
        Mutation_add = [];
        nn= size(popm_sel, 1);
        % 此时需要更新nn
       
         if nn<1000
             m_number = floor(nn/4);
         elseif number < 3000
             m_number = floor(nn/100);
         else
             m_number = floor(nn/1000);
             fprintf('无变异');
         end
        
        for i =1:m_number
            Mutation_add = [Mutation_add;Mutation(popm_sel(i,:),N)];
        end
        
        popm_sel = [popm_sel;Mutation_add];
        
        for len_tem = 1:length(popm_sel(:,1))
            popm_sel(len_tem,:) = sort(popm_sel(len_tem,:));
        end
        popm_sel = unique(popm_sel,'rows');
        fprintf('清洗相同种群');
        
        
        % 求适应度函数
        NN= size(popm_sel, 1);
        fprintf('此时新种群数量%d\n',NN);
        len = zeros(NN,1);
        for i=1:NN
            len(i,1) = Calculation_total_value(popm_sel(i,:));
            % len矩阵储存每一种情况下popm的总价值
        end
        
        maxlen = max(len);
        lenNoZero = len;
        lenNoZero(lenNoZero==0)=[];
        minlen = min(lenNoZero);
       
        fitness = fit(len, maxlen, minlen);
        rr = find(len==maxlen);
        fprintf('此次变异后最佳maxlen=%d\n',maxlen);
        R = popm_sel(rr(1,1),:);
        
        %   R代表保存着的最佳连接路线
        popm = []; 
        popm = popm_sel;
        popm_sel = [];
        
        if maxlen>TotalBestValue
            if all_city_connected(R,city_connection_list)==1
                TotalBestValue = maxlen;
                TotalBestRoute = R;
                fprintf('更新全局最佳\n');
                fprintf('全局最佳%d\n',TotalBestValue);
                fprintf('路线：');
                TotalBestRoute
            else
                fprintf('最佳结果不符合全连接要求\n');
            end
        end
C = C - 1;
end
