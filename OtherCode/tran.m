function [rho,theta] = tran(x,y)
%tran （x, y）:直角坐标
%   直角坐标x， y和极坐标转换
rho = sqrt(x*x+y*y);
theta = atan(y/x);
end

