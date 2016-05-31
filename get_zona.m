function [ zona ] = get_zona( j )
 %Retorna em que zona está o robot
    
 global i;
 
    switch j-1
        case {1,2,3}
            zona = 1;
        case 4
            zona = 2;
            fprintf('mudei para a zona %d, i=%d\n',zona,i);
        case 5
            zona = 3;
            fprintf('mudei para a zona %d, i=%d\n',zona,i);
        case 6
            zona = 4;
            fprintf('mudei para a zona %d, i=%d\n',zona,i);
        case 7
            zona = 5;
            fprintf('mudei para a zona %d, i=%d\n',zona,i);
        case 8
            zona = 6;
            fprintf('mudei para a zona %d, i=%d\n',zona,i);
        case 9
            zona = 7;
            fprintf('mudei para a zona %d, i=%d\n',zona,i);
        case 10
            zona = 8;
            fprintf('mudei para a zona %d, i=%d\n',zona,i);
        case {11,12,13}
            zona = 9;
    end
    
end

