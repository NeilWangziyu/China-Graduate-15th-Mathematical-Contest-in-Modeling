% x = (0:pi/100:2*pi)';
% y1 = 2*exp(-0.5*x)*[1, -1];
% y2 = 2*exp(-0.5*x).*sin(2*pi*x);
% x1 = (0:12)/2
% y3 = 2*exp(-0.5*x1).*sin(2*pi*x1);
% plot(x, y1, 'g', x, y2, 'b--', x1, y3, 'rp');
% title('curve');
% xlabel('independent variable x');
% ylabel('independent variable y');
% text(2.8, 0.5,'blx');


% x = linspace(0, 2*pi, 60);
% y = sin(x);
% z = cos(x);
% t = sin(x)./(cos(x)+eps);
% ct = cos(x)./(sin(x)+eps);
% subplot(2,2,1);
% plot(x,y);title('sin(x)');axis([0, 2*pi, -1, 1]);
% subplot(2, 2,2);
% plot(x, z);title('cos(x)');axis([0, 2*pi, -1, 1]);
% subplot(2, 2, 3);
% plot(x,t);title('tangent(x)');
% axis([0, 2*pi, -40, 40]);
% subplot(2,2,4);
% plot(x, ct);title('cotangent(x)');axis([0, 2*pi, -40, 40]);


% Y= round(rand(5, 3)*10);
% subplot(2,2,1);
% bar(Y, 'group');
% title('Group');
% subplot(222);
% bar(Y, 'Stack');
% title('Stack');
% subplot(223);
% barh(Y, 'stack');
% title('stack');
% subplot(224);
% bar(Y, 1.5);
% title('width=1.5');

% s = 0
% for i = 1:2:12
%     i
%     s = s + i;
% end

% y=0;n=100;
% for i = 1:n
%     y = y+1/i/i;
% end

% s=0; a=[65,76,56,78;98,83,74,85;76,67,78,79;98,58,42,73;67,89,76,87]; 
% for k=a
% s=s+k; 
% end
% disp(s');


% x = input('input x');
% if x == 10
%     y = cos(x+1)+sqrt(x*x+1)
% else
%     y = x*sqrt(x+Sqrt(x));
% end


% c = input('input','s');
% if c>='A' & c<='Z'
%     disp(setstr(abs(c)+1));
% elseif c>='a' & c<= 'z'
%     disp(setstr(abs(c)-1));
% elseif c>='0' & c<='9'
%     disp(abs(c)-abs('0'));
% else
%     disp(c);
% end


% P = [1 -12 0 25 116]
% R = roots(P)
% roots求多项式的根

% clear
% 
% roots=[-2 4 50+i 5-3*i]
% P=poly(roots)
% poly2sym(P)

clear
% x = 0:0.1 :10 ;
% y =sin(x);
% xi = 0:0.25:10;
% yi = interp1(x, y, xi);
% subplot(1,2,1)
% plot(x,y,'r')
% subplot(1,2,2)
% plot(xi,yi,'b')

% syms x t
% limit((1+2*t/x)^(3*x), x, inf)
% 
% clear
% syms x
% limit(x/abs(x), x, 0, 'left')
% limit(x/abs(x), x, 0, 'right')

% syms a b c x
% f = a*x^2+b*x+c;
% diff(f)
% diff(f, b)
% diff(f, 2)


% syms x
% factor(3*x^3 - 0.5*x^3 + 3*x^2)

% syms a b c x
% f = a*x^2 + b*x + c
% solve(f, x)


% dsolve('Dy=1+y^2')

% [x,y]=ode23(@ li,[-2.5 3],[0]);
% plot(x,y)
% 
% function y1=li(x,y)
% y1=1-2*x*y;
% end

% 线性优化：
% c = [2, 1.6]
% a = [-4, -2; -90, -300]
% b = [-2.8,-200]
% a1 = [1, 1]
% b1 = [1]
% lb = [0, 0]
% ub = [inf, inf]
% [x, z]=linprog(c,a,b,a1,b1,lb,ub)


% 非线性优化
 a=[1, -1]; b=1; a1=[1,1]; b1=0;
 x0 = [-1,1];
 [x, f]=fmincon ('nline', x0, a, b, a1, b1, [ ], [ ], 'nyueshu')

