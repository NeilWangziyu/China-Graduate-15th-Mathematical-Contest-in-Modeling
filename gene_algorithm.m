clear
clc
load DATA
load relay_pool

N = 33;     % route
M = 100;     % ��Ⱥ����
C = 1500;
C_old = C;
Pc = 0.4;   %�������
m = 2;      %��Ӧ�Թ�һ����̭����ָ��
Pmutation = 0.2;    %�������
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


% ���ɳ�ʼȺ��
popm =zeros(M,N);

for i=1:M
    popm(i, :) = randperm(61, N);
end
%popm(M,:) =  [1 3 4 5 9 19 27 31 32 35 38 39 40 30 52 58];
popmInit = popm;
% city_connection_list���������е�·���������

% ��ʼ����Ⱥ����Ӧ����
fitness = zeros(M,1);
% fitness���������·���Ż�������·�߼�ֵ
len = zeros(M,1);
for i=1:M
    len(i,1) = Calculation_total_value(popm(i,:));
    % len���󴢴�ÿһ�������popm���ܼ�ֵ
end

maxlen = max(len);
minlen = min(len);
fitness = fit(len, maxlen, minlen);

rr = find(len==maxlen);
R = popm(rr(1,1),:);
%   R�������ŵ��������·��
TotalBestValue = maxlen;
TotalBestRoute = R;
precent = 0;
% ������
fprintf('��ʼȫ�����%d\n',TotalBestValue);
fprintf('·�ߣ�');
TotalBestRoute


%   ��ʼ����
while C>=0
    fprintf('����%d��\n',C_old-C);
       
    
    
        % ѡ�����
        nn = 0;
        % ��һ��ѡ��֮������nn��Ⱦɫ��
         number = size(popm,1) ;
         if number<1000
             jc = rand*0.95;
         elseif number < 3000
             jc = 0.90;
         elseif number < 6000
             jc = 0.95;
             fprintf('�������࣬����ѹ������')
         elseif number <10000
             jc = 0.97;
             fprintf('�������࣬����ѹ������')
         elseif number < 15000
             jc = 0.99;
             fprintf('�������࣬����ѹ������')
         else
             jc = 0.995;
             fprintf('�������࣬����ѹ������')
         end
         
        for i =1:size(popm,1)
            if all_city_connected(popm(i,:), city_connection_list) ==1
                if fitness(i,1)>=jc
                    % Ⱦɫ����
                    nn = nn+1;
                    popm_sel(nn, :) = popm(i,:);
                end
            end
        end
        fprintf('��%d��ѡ��֮�󣬹���%dֻ��Ⱥ���\n',C_old-C, nn);
        percent = nn / number;
        fprintf('������%2f\n',percent);
        
        
        % �������
        for i=1:floor(nn/2)
          % �ķ�֮һ�ķ�������
          nn= size(popm_sel, 1);
          nnper = randperm(nn);
          % nnper ��һ�����д�1-nn
          A = popm_sel(nnper(1), :);
          B = popm_sel(nnper(2), :);
          [A, B] = cross(A, B);
          popm_sel = [popm_sel;A;B];
        end
        
        %popm_sel = unique(popm_sel, 'rows');
        
        % С�����������
        % �滻�����������е�ĳһ��ֵ�滻Ϊδ�����һ��ֵ
        Mutation_small_add = [];
        nn= size(popm_sel, 1);
        % ��ʱ��Ҫ����nn
        for  i=1:floor(nn/2)
            pick = rand;
            % rand����0-1֮�����
            while pick == 0
                pick = rand;
            end
            if pick <= Pmutation
                pool_tem = setdiff(city_connection_pool, popm_sel(i,:));
                length_pool = length(pool_tem);
                index_popm = randperm(N,1);
                index_pool = randperm(length_pool,1);
                % ����popm��pool��index
                mutated_popm = popm_sel(i,:);
                mutated_popm(index_popm) = pool_tem(index_pool);
                Mutation_small_add = [Mutation_small_add;mutated_popm];
            end
        end
        popm_sel = [popm_sel;Mutation_small_add];
        
        % ��������
        % ֱ�Ӽ����������ֵ
        Mutation_add = [];
        nn= size(popm_sel, 1);
        % ��ʱ��Ҫ����nn
       
         if nn<1000
             m_number = floor(nn/4);
         elseif number < 3000
             m_number = floor(nn/100);
         else
             m_number = floor(nn/1000);
             fprintf('�ޱ���');
         end
        
        for i =1:m_number
            Mutation_add = [Mutation_add;Mutation(popm_sel(i,:),N)];
        end
        
        popm_sel = [popm_sel;Mutation_add];
        
        for len_tem = 1:length(popm_sel(:,1))
            popm_sel(len_tem,:) = sort(popm_sel(len_tem,:));
        end
        popm_sel = unique(popm_sel,'rows');
        fprintf('��ϴ��ͬ��Ⱥ');
        
        
        % ����Ӧ�Ⱥ���
        NN= size(popm_sel, 1);
        fprintf('��ʱ����Ⱥ����%d\n',NN);
        len = zeros(NN,1);
        for i=1:NN
            len(i,1) = Calculation_total_value(popm_sel(i,:));
            % len���󴢴�ÿһ�������popm���ܼ�ֵ
        end
        
        maxlen = max(len);
        lenNoZero = len;
        lenNoZero(lenNoZero==0)=[];
        minlen = min(lenNoZero);
       
        fitness = fit(len, maxlen, minlen);
        rr = find(len==maxlen);
        fprintf('�˴α�������maxlen=%d\n',maxlen);
        R = popm_sel(rr(1,1),:);
        
        %   R�������ŵ��������·��
        popm = []; 
        popm = popm_sel;
        popm_sel = [];
        
        if maxlen>TotalBestValue
            if all_city_connected(R,city_connection_list)==1
                TotalBestValue = maxlen;
                TotalBestRoute = R;
                fprintf('����ȫ�����\n');
                fprintf('ȫ�����%d\n',TotalBestValue);
                fprintf('·�ߣ�');
                TotalBestRoute
            else
                fprintf('��ѽ��������ȫ����Ҫ��\n');
            end
        end
C = C - 1;
end
