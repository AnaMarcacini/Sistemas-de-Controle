function [Eq] = ErroQuadratico(X,y,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y - SAIDAS REAIS - Laboratório
% t - tempo real - Laboratório // inutil
% X = [beta rv] - o que eu quero descobrir
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Valores iniciais ---- DADO

beta = X(1);
rv = X(2);

%% Saida do modelo ---  SIMULADOR

%mdl = 'Aula1';
%%load_system(mdl)
%cs = getActiveConfigSet(mdl);
%mdl_cs = cs.copy;
%set_param(mdl_cs,'AbsTol','1e-5','SaveState','on','StateSaveName','xoutNew','SaveOutput','on','OutputSaveName','youtNew')
simOut = sim('Aula1');

%% Valores do simulador

rSimulador = simOut.logsout{3}.Values.Data ; 
sSimulador = simOut.logsout{1}.Values.Data  ;
iSimulador = simOut.logsout{2}.Values.Data  ;
tSimulador = simOut.logsout{2}.Values.Time  ;%comparar valores de tempo do simulador 

%% Erro quadrÃ¡tico - comparar com os dados experimentais

%Eq = sum((y - ym).^2);   % calculo do erro

Eq = sum((y.R - rSimulador).^2);    % calculo do erro
Eq = Eq+ sum((y.S - sSimulador).^2);    % calculo do erro
Eq = Eq+ sum((y.I - iSimulador).^2);   % calculo do erro



end

