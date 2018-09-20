clear all
close all
load DATA
clc
% ����ԭʼ���ݣ�Population(1*12 double)�������ˣ�
%                   Distance(12*12 double)�����
% ˳�򣺱���&��� ������ ��³ľ�� ���� ֣�� �Ϻ� ���� �ɶ� ���� �人 ���� ����&����

N = 12; %��������
Matrix_NV = zeros(N,N); %ÿ�������м�������ֵ ��λ��mTb/s
for i = 1:N
    for j = (i+1):N      
        if Distance(i,j)<=600
            capacity = 32; %������
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
% �ҳ�����count����·
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = reshape(Matrix_NV,1,N*N); % Matrix_NV����
[M,index] = sort(M,'descend');
count = 16;
NV = sum(M(1:count));
disp('16·�������ֵ��NV = ');disp(NV);
P = LOCATION(count,index,N); %���ú�����Ѱ�Ҿ������ֵ����λ��
PLOT_MAP(border,city,P);

count = 33;
NV = sum(M(1:count));
disp('33·�������ֵ��NV = ');disp(NV);
P = LOCATION(count,index,N);
PLOT_MAP(border,city,P);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �ҳ�����	N-1����·,ȫ��ͨͼ
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
T = table2array(T.Edges(:,1)); %���������

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
disp('ȫ��ͨ16·�������ֵ��NV = ');disp(NV);
P = LOCATION(count,index,N); 
PLOT_MAP(border,city,P);ADD_TREE(city,T);

count = 33-(N-1);
NV = NV_temp+sum(M(1:count));
disp('ȫ��ͨ33·�������ֵ��NV = ');disp(NV);
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


