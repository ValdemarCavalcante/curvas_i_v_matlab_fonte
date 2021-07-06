out = sim('curva_modulo.slx');
tensao = out.simout.V_PV.DATA;
corrente = out.simout.I_PV.DATA;

pos = find(corrente < 0);
corrente(pos) = [];
tensao(pos) = [];

potencia = tensao.*corrente;
pos_max = find(potencia == max(potencia));

pontos_totais = 64;
curva_i_constante = flip(round(linspace(0.70*pos_max,1,floor(0.2*pontos_totais))));
curva_mpp = flip(round(linspace(length(potencia),0.85*pos_max,ceil(0.8*pontos_totais))));
pos = [curva_i_constante curva_mpp];

potencia = potencia(pos);
corrente = corrente(pos);
tensao = tensao(pos);

f = figure('visible', 'off');
subplot(2,1,1)
plot(tensao,corrente,'*-')
title('Curva IxV')
xlim([0 Voc_aux])
ylim([0 Isc_aux])
grid on
box on
subplot(2,1,2)
plot(tensao,potencia,'*-')
title('Curva PxV')
xlim([0 Voc_aux])
ylim([0 Pm_aux])
grid on
box on

pos = find(corrente < 0.009);
corrente(pos) = 0;
formatSpec = '%.3f';
corrente = num2str(corrente, formatSpec);
corrente = cellstr(corrente);
pos = find(tensao < 0.009);
tensao(pos) = 0;
tensao = num2str(tensao, formatSpec);
tensao = cellstr(tensao);

% for i = 1:64
%     vetor{i,1} = [tensao{i} ',' corrente{i}];
% end
nome_arq = [pwd '\' Modulo '\' Modulo '_' num2str(Ir) '_' num2str(T) '.jpg'];
saveas(f,nome_arq);


vetor = [tensao corrente];
nome_arq = [ pwd  '\' Modulo '\' Modulo '_' num2str(Ir) '_' num2str(T) '.xls'];
xlswrite(nome_arq,vetor);

caminho = [pwd  '\' Modulo];
nome_arq2 = [Modulo '_' num2str(Ir) '_' num2str(T)];
xlsx2csv(nome_arq,caminho,nome_arq2)

