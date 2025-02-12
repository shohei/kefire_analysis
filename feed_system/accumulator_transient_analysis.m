clc; clear; close all;

deltaT = 0.1;%s 100ms
rho_eth = 789; %;kg/m^3
mdot_fuel = 0.5161;%kg/s

Vacc_L = 26.5;%L :This tank should be smaller.
Vacc = Vacc_L * 0.001;%m3

Pacc_bar = 35;%bar
Pacc = Pacc_bar * 101325;%Pa

M_N2 = 28;%分子量

%(仮説)
%最初に充填する窒素の量(m_N2_0)に応じて必要な窒素ガスの体積は変わってくる。
%m_N2_0をいくらにするかは、ガスの再充填に関わってくる。
%m_N2_0が小さいと、必要な体積は小さくなる。この場合、タンクのほとんどが
%燃料で占められる。タンクが流出する際の相対的な圧力変動が大きくなるため、
%圧力は急激に降下する。そのため、下流のFCVだけでなく上流のPRの操作が必要になる。

%n=1molの場合
T = 300;%K
R = 8.314510;%mol•K 一般気体定数
n_N2 = 1; %mol
m_N2 = n_N2 / M_N2;%kg
Vgas = n_N2 * R * T/ Pacc;%m^3
Vgas_L = Vgas * 1000;%L

%Vliquid = Vacc - Vgas; 
%Vliquid_L = Vliquid * 1000;

Vgas_prime = Vgas + mdot_fuel / rho_eth * deltaT;
Pacc_prime = n_N2 * R * T / Vgas_prime;
delta_P = Pacc_prime - Pacc;%Pa
delta_P_bar = delta_P / 101325;%bar
fprintf('***************\n');
fprintf('Case1: Initial mass of N2 gas in the accumulator m=%.2f[kg]\n',m_N2);
fprintf('Initial N2 gas volume in accumulator: %.2f[L]\n',Vgas_L);
fprintf('Pressure drop after ΔT=%.2f[s]: ΔP=%.3f [bar]\n',deltaT,delta_P_bar);

%n=0.5kgの場合
%注：大型ボンベ(47L, 7000litre)には8.2kgの窒素が入っている

m_N2 = 0.5;%kg
n_N2 = m_N2*1000 / M_N2;
Vgas = m_N2*1000/M_N2 * R * T/ Pacc;%m^3
Vgas_L = Vgas * 1000;%L

%Vliquid = Vacc - Vgas; %;
%Vliquid_L = Vliquid * 1000;

Vgas_prime = Vgas + mdot_fuel / rho_eth * deltaT;
Pacc_prime = n_N2 * R * T / Vgas_prime;
delta_P = Pacc_prime - Pacc;%Pa
delta_P_bar = delta_P / 101325;%bar
fprintf('***************\n');
fprintf('Case2: Initial mass of N2 gas in the accumulator m=%.2f[kg]\n',m_N2);
fprintf('Initial N2 gas volume in accumulator: %.2f[L]\n',Vgas_L);
fprintf('Pressure drop after ΔT=%.2f[s]: ΔP=%.3f [bar]\n',deltaT,delta_P_bar);


