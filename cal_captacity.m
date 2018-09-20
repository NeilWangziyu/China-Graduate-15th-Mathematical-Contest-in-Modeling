function capacity = cal_captacity(distance)
if distance<=600
            capacity = 32; %×ÜÈÝÁ¿
        elseif (distance<=1200)
            capacity = 16;
        elseif (distance<=3000)
            capacity = 8;
        else
            capacity = 0;
        end
end

