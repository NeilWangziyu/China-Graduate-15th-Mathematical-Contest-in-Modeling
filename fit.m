function fitness = fit( len, maxlen, minlen )
%fitness ���ڼ�����Ӧ��,maxlenԽ�������õ���fitness��
    fitness = len;
    for i = 1:length(len)
        fitness(i, 1) = ((len(i,1)-minlen)/(maxlen-minlen+0.001));
    end

end

