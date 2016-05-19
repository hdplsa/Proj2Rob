function [ zona ] = get_zona( j )
 %Retorna em que zona está o robot
    
    switch j-1
        case {1,2,3}
            zona = 1;
        case 4
            zona = 2;
        case 5
            zona = 3;
        case 6
            zona = 4;
        case 7
            zona = 5;
        case 8
            zona = 6;
        case 9
            zona = 7;
        case 10
            zona = 8;
        case {11,12,13}
            zona = 9;
    end
    
end

