function P = LOCATION(count,index,N)
% �ҵ�count�����ֵ�ھ����е�λ������

P = zeros(count,2); % ���count��ֵ����λ��
for i = 1:count
    p = index(i);
    x = rem(p,N);
    if x == 0
        x = N;
    end
    y = ceil(p/N);
    P(i,:) = [x,y];
end

end

