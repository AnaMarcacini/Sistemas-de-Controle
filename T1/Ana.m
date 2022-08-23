%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Boas Praticas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;close all;
contfiguras = 0;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Lendo as informações e salvando em arrays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load("Dados.mat")


%%Visualizando os dados coletados

t = (0:1:length(R)-1);

contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,I,t,S,t,R);

contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,I,"o",t,S,"o",t,R,"o");


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Gerando o ruido & addicionando aos dados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t = (0:1:length(R)-1);

%r=média+variancia*R(t,I)


%desvios padrão
std(I);
std(R);
std(S);
%%%

Sdn = 0+std(S)/10*rand(1,length(S));
Idn = 0+std(I)/5*rand(1,length(S)); 
Rdn = 0+std(R)/10*rand(1,length(S));

%%Cortando
%{
Sdn = Sdn(0:length(S));
Idn = Sdn(0:length(S));
Rdn = Sdn(0:length(S));
%}



%%%%% Adicionando


s = S + Sdn;
i = I + Idn;
r = R + Rdn;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualizando
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



contfiguras = contfiguras+1;
figure(contfiguras)
plot(t,s,"o")
hold
plot(t,i,"o")
hold
plot(t,r,"o")



contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,i,"o",t,s,"o",t,r,"o")


contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,i,"-",t,s,"-",t,r,"-")


contfiguras = contfiguras+1;
figure(contfiguras)


plot(t,i,t,s,t,r)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Voltar
%NAS FUNÇÕES SIRmodel || SIRsim


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONDIÇÕES INICIAIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%COMANDO sim
%Tamanho da populção - N
N = 500;

%Valores iniciais 
I0 = 1 ;
R0 = 0;
S0 = N - I0;

%Vetor de condições iniciais

y0 = [S0, I0, R0];  


%%%%%%%% Beta e r
theta0 = [1e-4,1e-2];% valores iniciais
beta = theta0(1);

rv = theta0(2);


%Definição do conjunto de equações diferencias não lineares que formam o modelo.

t = linspace(0, 1000, 1000);

%=sim('Aula1',[Beta,r])
%%
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

%{
clear ans
clear contfiguras
clear i
clear I
clear Idn
clear N
clear r
clear R
clear Rdn
clear s
clear S
clear Sdn
clear t
clear theta0
clear y0


%}

%{

subplot(2,1,2);plot(f,abs(Dn),'ko');
title('Serie de Fourier do sinal g(t) -- To = 100s');
xlabel('Frequencia em Hz');
ylabel('Amplitude em  volts')
hold

%}


