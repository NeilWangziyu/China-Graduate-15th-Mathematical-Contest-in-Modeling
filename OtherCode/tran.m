function [rho,theta] = tran(x,y)
%tran ��x, y��:ֱ������
%   ֱ������x�� y�ͼ�����ת��
rho = sqrt(x*x+y*y);
theta = atan(y/x);
end

