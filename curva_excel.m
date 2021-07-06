fclose all
close all
clear all
clc
warning('off');

open_system('curva_modulo.slx');
Voc = str2num(get_param('curva_modulo/PV Array','Voc'));
Voc_aux = round(Voc/10)*10;
Isc = str2num(get_param('curva_modulo/PV Array','Isc'));
Isc_aux = round(Isc/10)*10;
Pm = str2num(get_param('curva_modulo/PV Array','Pm'));
Pm_aux = round((Pm+50)/100)*100;
Modulo = (get_param('curva_modulo/PV Array','ModuleName'));
mkdir(Modulo);
% count = 0;
flag = 1;
for j = 1:3
for i = 1:5
    
    if flag == 1
        Ir = 40*i;
        T = 25;
%         count = count + 1
        main_curva
    end
    if flag == 0 & i == 5
        Ir = 1000;
        T = 25*j;
%         count = count + 1
        main_curva     
    end
    
if i == 5
    flag = 0;
end
end
end