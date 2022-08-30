%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Boas Praticas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;close all;
contfiguras = 0;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Lendo as informacoes e salvando em arrays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load("Dados.mat")

SaidaReal = SIRpd;
%%Visualizando os dados coletados

t = (0:1:length(R)-1);

contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,I,t,S,t,R);




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Gerando o ruido & addicionando aos dados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t = (0:1:length(R)-1);

%r=media+variancia*R(t,I)


%desvios padrão
std(I);
std(R);
std(S);
%%%
%{

correto que dá erro
Sdn = 0+std(S)/10*rand(1,length(S));
Idn = 0+std(I)/5*rand(1,length(S)); 
Rdn = 0+std(R)/10*rand(1,length(S));
%}


%incorreto que funciona
Sdn = rand(1,length(S));
Idn = rand(1,length(S)); 
Rdn = rand(1,length(S));

%% transformando em colunas
Sdn = Sdn(:);
Idn = Idn(:);
Rdn = Rdn(:);

%controle dados txt

%%%%% Adicionando

s = S + Sdn;
i = I + Idn;
r = R + Rdn;

%{
s = inv(S) + Sdn;
i = inv(I) + Idn;
r = inv(R) + Rdn;
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualizando
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%{
contfiguras = contfiguras+1;
figure(contfiguras)
plot(t,s,"o")
hold on
plot(t,i,"o")
plot(t,r,"o")
hold off
%}
%{
contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,i,"o",t,s,"o",t,r,"o")


contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,i,"-",t,s,"-",t,r,"-")

%}
contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,i,t,s,t,r)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONDICOES INICIAIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%COMANDO sim
%Tamanho da populacao - N
N = 500;

%Valores iniciais 
I0 = 1 ;
R0 = 0;
S0 = N - I0;

%Vetor de condicoes iniciais

y0 = [S0, I0, R0];  


%%%%%%%% Beta e r
theta0 = [1e-4,1e-2];% valores iniciais
beta = theta0(1);

rv = theta0(2);


%Definicao do conjunto de equacoes diferencias nao lineares que formam o modelo.

t = linspace(0, 1000, 1000);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%ErroQuadratico(X,SaidaReal,t,EntradaReal),theta0);

X = fminsearch(@(x) ErroQuadratico(x,SaidaReal,t) ,theta0);

beta = X(1)

rv = X(2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualizando
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Valores de beta e r achados anteriormente
beta = X(1)
rv = X(2)

%%{
mdl = 'Aula1';
load_system(mdl)
cs = getActiveConfigSet(mdl);
mdl_cs = cs.copy;
%set_param(mdl_cs,'AbsTol','1e-5','SaveState','on','StateSaveName','xoutNew','SaveOutput','on','OutputSaveName','youtNew')
simOut = sim(mdl, mdl_cs);



%%
rSimulador = simOut.logsout{3}.Values.Data ; 
sSimulador = simOut.logsout{1}.Values.Data  ;
iSimulador = simOut.logsout{2}.Values.Data  ;
tSimulador = simOut.logsout{2}.Values.Time  ;

%%
contfiguras = contfiguras+1;
figure(contfiguras)


subplot(3,1,1);
plot(tSimulador, iSimulador,tSimulador,sSimulador,tSimulador,rSimulador)
title('Dados do Simulador');
xlabel('tempo');
ylabel('Pessoas')
hold

subplot(3,1,2);
plot(t,i,t,s,t,r)
title('Dados Coletados sem ruido');
xlabel('tempo');
ylabel('Pessoas')
hold



subplot(3,1,3);
plot(t,i,t,s,t,r,tSimulador, iSimulador,tSimulador,sSimulador,tSimulador,rSimulador)
title('Ambos os Graficos');
xlabel('tempo');
ylabel('Pessoas')
hold
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%}


