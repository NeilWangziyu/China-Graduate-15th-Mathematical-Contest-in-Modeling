x = [1 2 3 4 5 6 7 8 9];
y = [9 7 6 3 -1 2 5 7 20];
p = polyfit(x, y, 5);
xi =0:2:10;
yi = polyval(p, xi);
plot(xi,yi,x,y,'r*');
% x = [1 2 3 4 5 6 7 8 9];
% y = [9 7 6 3 -1 2 5 7 20];
% plot(x, y, 'r*');

