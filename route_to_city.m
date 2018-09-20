load city_connection_list.mat
load route.mat
way = []

for i = 1:length(one_popm_a)
 
    city = city_connection_list(one_popm_a(i),:)
    way = [way;city(1), city(2)];

end
save way.mat way


