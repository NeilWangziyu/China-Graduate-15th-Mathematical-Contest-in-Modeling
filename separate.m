
load Matrix_NV
load DATA
load city_connection_list
load relay_pool
load Distance
Distance = Distance+Distance';


one_popm = [  1     3     4     5     8     9    12    13    14    16    19    26    27    29    30    31    32   ];
one_popm_sep = [];
for i=1:length(one_popm)
    city = city_connection_list(one_popm(i),:)
    i = city(1);
    j = city(2);
    if Distance(i,j)<600
        separation = 4
        
    elseif Distance(i,j)<1200
        separation = 2
    elseif Distance(i,j)<3000
        separation = 1
    else
        separation = 0;
    end
  
    represent = (one_popm(i)) *separation;
    one_popm_sep = [one_popm_sep, represent ];
    
end