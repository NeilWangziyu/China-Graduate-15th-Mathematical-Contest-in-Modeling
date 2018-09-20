clear
clc
load DATA

N = 16;     % route
M = 20;     % ��Ⱥ����
C = 1000;
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

% ���ɳ�ʼȺ��
popm =zeros(M,N);

for i=1:M
    popm(i, :) = randperm(61, N);
end
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
TotalBestValue = maxlen;

rr = find(len==maxlen);
R = popm(rr(1,1),:);
%   R�������ŵ��������·��
value_max = zeros(C+1, 1);
TotalBestRoute = R;
fprintf('��ʼȫ�����%d\n',TotalBestValue);
fprintf('·�ߣ�');
TotalBestRoute
            
%   ��ʼ����
while C>=0
    fprintf('����%d��\n',C);
    
        % ���ؿ���ÿ�θ���
        for i=1:M
            popm(i, :) = randperm(61, N);
        end
        
        % ����Ӧ�Ⱥ���
        NN= size(popm, 1);
        len = zeros(NN,1);
        for i=1:M
            len(i,1) = Calculation_total_value(popm(i,:));
            % len���󴢴�ÿһ�������popm���ܼ�ֵ
        end

        maxlen = max(len);
        rr = find(len==maxlen);
        %  fprintf('maxlen=%d\n',maxlen);
        R = popm(rr(1,1),:);
        %   R�������ŵ��������·��

        if maxlen>TotalBestValue
            TotalBestValue = maxlen;
            TotalBestRoute = R;
            fprintf('����ȫ�����\n');
            fprintf('ȫ�����%d\n',TotalBestValue);
            fprintf('·�ߣ�');
            TotalBestRoute

        end
    
    C = C - 1;
    
end
