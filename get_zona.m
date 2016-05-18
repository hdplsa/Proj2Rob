function [ zona ] = get_zona( j )
 %Retorna em que zona está o robot
    
    switch j-1
        case {1,2}
            zona = 1;
        case {3,4}
            zona = 2;
        case 5
            zona = 3;
        case {6,7}
            zona = 4;
        case 8
            zona = 5;
        case {9,10}
            zona = 6;
        case 11
            zona = 7;
        case {12,13}
            zona = 8;
        case {14,15}
            zona = 9;
    end
    
end

