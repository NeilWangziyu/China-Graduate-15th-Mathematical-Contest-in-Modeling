function a = Mutation(A)
%Mutation 
%   ���캯��
    index1 = 0; index2 = 0;
    nnper = randperm(size(A,2));
    index1 = nnper(1);
    index2 = nnper(2);
    temp = 0;
    temp = A(index1);
    A(index1) = A(index2);
    A(index2) = temp;
    a = A;
end

