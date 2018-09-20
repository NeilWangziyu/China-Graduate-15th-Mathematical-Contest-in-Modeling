clear all
close all
load DATA
clc
% 输入原始数据：Population(1*12 double)（百万人）
%                   Distance(12*12 double)（公里）
% 顺序：北京&天津 哈尔滨 乌鲁木齐 西安 郑州 上海 拉萨 成都 重庆 武汉 昆明 广州&深圳

N = 12; %城市数量
Matrix_NV = zeros(N,N); %每两个城市间的网络价值 单位：mTb/s
for i = 1:N
    for j = (i+1):N      
        if Distance(i,j)<=600
            capacity = 32; %总容量
        elseif (Distance(i,j)<=1200)
            capacity = 16;
        elseif (Distance(i,j)<=3000)
            capacity = 8;
        else
            capacity = 0;
        end
        Matrix_NV(i,j) = capacity*sqrt(Population(i)*Population(j));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 找出最大的count个线路
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = reshape(Matrix_NV,1,N*N); % Matrix_NV排序
[M,index] = sort(M,'descend');
count = 16;
NV = sum(M(1:count));
disp('16路径的最大值：NV = ');disp(NV);
P = LOCATION(count,index,N); %调用函数，寻找矩阵最大值所在位置
PLOT_MAP(border,city,P);

count = 33;
NV = sum(M(1:count));
disp('33路径的最大值：NV = ');disp(NV);
P = LOCATION(count,index,N);
PLOT_MAP(border,city,P);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 找出最大的	N-1个线路,全连通图
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = [];
t = [];
weights = [];
for i = 1:N
    for j = i+1:N
        s = [s,i];
        t = [t,j];
        weights = [weights,-Matrix_NV(i,j)];        
    end
end
G = graph(s,t,weights);
[T,~] = minspantree(G);
T = table2array(T.Edges(:,1)); %最大生成树

Matrix_NV_temp = Matrix_NV;
NV_temp = 0;
for i = 1:N-1
    NV_temp = NV_temp+Matrix_NV_temp(T(i,1),T(i,2));
    Matrix_NV_temp(T(i,1),T(i,2)) = 0;
end
M = reshape(Matrix_NV_temp,1,N*N);
[M,index] = sort(M,'descend');
count = 16-(N-1);
NV = NV_temp+sum(M(1:count));
disp('全连通16路径的最大值：NV = ');disp(NV);
P = LOCATION(count,index,N); 
PLOT_MAP(border,city,P);ADD_TREE(city,T);

count = 33-(N-1);
NV = NV_temp+sum(M(1:count));
disp('全连通33路径的最大值：NV = ');disp(NV);
P = LOCATION(count,index,N);
PLOT_MAP(border,city,P);ADD_TREE(city,T);
clear NV_temp Matrix_NV_temp;


% for i=1:12
%     for j = 1:12
%         if i>j
%             Matrix_NV(i,j) = Matrix_NV(j,i);
%         end
%     end
% end
% save Matrix_NV


