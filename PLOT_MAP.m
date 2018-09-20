function [] = PLOT_MAP(border,city,P)
% ������ͼ�����У�����

figure()
plot(border.long,border.lat,'k','linewidth',1.5);
hold on
plot(city.long,city.lat,'o','markersize',5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k');
axis([70 140 15 55]);

[P1,~] = size(P);
for i = 1:P1
    x = P(i,1);
    y = P(i,2);
    plot([city.long(x),city.long(y)],[city.lat(x),city.lat(y)],'b');
    hold on
end

text(108,41.5,'����&���','fontsize',12);
text(121,48,'������','fontsize',12);
text(82.5,42,'��³ľ��','fontsize',12);
text(103,35.5,'����','fontsize',12);
text(115,35.5,'֣��','fontsize',12);
text(122.5,31.5,'�Ϻ�','fontsize',12);
text(86,31.5,'����','fontsize',12);
text(98,31,'�ɶ�','fontsize',12);
text(104,28,'����','fontsize',12);
text(112,29,'�人','fontsize',12);
text(96.5,25.5,'����','fontsize',12);
text(111.5,20.5,'����&����','fontsize',12);

box off
axis off
       
end

