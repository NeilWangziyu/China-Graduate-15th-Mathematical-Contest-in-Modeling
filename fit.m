function fitness = fit( len, maxlen, minlen )
%fitness 用于计算适应度,maxlen越大，则计算得到的fitness好
    fitness = len;
    for i = 1:length(len)
        fitness(i, 1) = ((len(i,1)-minlen)/(maxlen-minlen+0.001));
    end

end

