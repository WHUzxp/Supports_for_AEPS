%%%日前无序充电功率(优先充电原则)%%%
clear
clc
load data_potential_DA
%充电站1
Pch_CS1_disorder=sdpvar(1,97);%充电
Pdis_CS1_disorder=zeros(1,97);%放电
S_CS1_disorder=sdpvar(1,97);%SOC
f_CS1_disorder=Pch_CS1_disorder*[1:97]';%优先充电原则目标函数
C_CS1_disorder=[0<=Pch_CS1_disorder<=Forecast_CS1(1,:),
    Forecast_CS1(3,:)<=S_CS1_disorder<=Forecast_CS1(4,:),
    S_CS1_disorder(1)==0.25*0.95*Pch_CS1_disorder(1)+Forecast_CS1(5,1),
    S_CS1_disorder(2:97)==S_CS1_disorder(1:96)+0.25*0.95*Pch_CS1_disorder(2:97)+Forecast_CS1(5,2:97)];%约束条件
solvesdp(C_CS1_disorder,f_CS1_disorder);
Pch_CS1_disorder=double(Pch_CS1_disorder);
S_CS1_disorder=double(S_CS1_disorder);
%充电站2
Pch_CS2_disorder=sdpvar(1,97);%充电
Pdis_CS2_disorder=zeros(1,97);%放电
S_CS2_disorder=sdpvar(1,97);%SOC
f_CS2_disorder=Pch_CS2_disorder*[1:97]';%优先充电原则目标函数
C_CS2_disorder=[0<=Pch_CS2_disorder<=Forecast_CS2(1,:),
    Forecast_CS2(3,:)<=S_CS2_disorder<=Forecast_CS2(4,:),
    S_CS2_disorder(1)==0.25*0.95*Pch_CS2_disorder(1)+Forecast_CS2(5,1),
    S_CS2_disorder(2:97)==S_CS2_disorder(1:96)+0.25*0.95*Pch_CS2_disorder(2:97)+Forecast_CS2(5,2:97)];%约束条件
solvesdp(C_CS2_disorder,f_CS2_disorder);
Pch_CS2_disorder=double(Pch_CS2_disorder);
S_CS2_disorder=double(S_CS2_disorder);
%充电站3
Pch_CS3_disorder=sdpvar(1,97);%充电
Pdis_CS3_disorder=zeros(1,97);%放电
S_CS3_disorder=sdpvar(1,97);%SOC
f_CS3_disorder=Pch_CS3_disorder*[1:97]';%优先充电原则目标函数
C_CS3_disorder=[0<=Pch_CS3_disorder<=Forecast_CS3(1,:),
    Forecast_CS3(3,:)<=S_CS3_disorder<=Forecast_CS3(4,:),
    S_CS3_disorder(1)==0.25*0.95*Pch_CS3_disorder(1)+Forecast_CS3(5,1),
    S_CS3_disorder(2:97)==S_CS3_disorder(1:96)+0.25*0.95*Pch_CS3_disorder(2:97)+Forecast_CS3(5,2:97)];%约束条件
solvesdp(C_CS3_disorder,f_CS3_disorder);
Pch_CS3_disorder=double(Pch_CS3_disorder);
S_CS3_disorder=double(S_CS3_disorder);
%充电站4
Pch_CS4_disorder=sdpvar(1,97);%充电
Pdis_CS4_disorder=zeros(1,97);%放电
S_CS4_disorder=sdpvar(1,97);%SOC
f_CS4_disorder=Pch_CS4_disorder*[1:97]';%优先充电原则目标函数
C_CS4_disorder=[0<=Pch_CS4_disorder<=Forecast_CS4(1,:),
    Forecast_CS4(3,:)<=S_CS4_disorder<=Forecast_CS4(4,:),
    S_CS4_disorder(1)==0.25*0.95*Pch_CS4_disorder(1)+Forecast_CS4(5,1),
    S_CS4_disorder(2:97)==S_CS4_disorder(1:96)+0.25*0.95*Pch_CS4_disorder(2:97)+Forecast_CS4(5,2:97)];%约束条件
solvesdp(C_CS4_disorder,f_CS4_disorder);
Pch_CS4_disorder=double(Pch_CS4_disorder);
S_CS4_disorder=double(S_CS4_disorder);
%绘图，以充电站3为例
figure(7);
hold on
plot(Forecast_CS3(1,:),'b')%充电功率边界
plot(-Forecast_CS3(2,:),'g')%放电功率边界
plot(Pch_CS3_disorder,'r.-')
legend('充电功率上界','放电功率上界','实际充放电功率')
xlabel 时间
ylabel 功率(kW)
figure(8);
hold on
plot(Forecast_CS3(4,:),'g')%SOC上界
plot(Forecast_CS3(3,:),'b')%SOC下界
plot(S_CS3_disorder,'r.-')
legend('SOC上界','SOC下界','实际SOC')
xlabel 时间
ylabel 容量(kWh)
%选取前96个断面
Pch_CS1_disorder=Pch_CS1_disorder(1:96);Pch_CS2_disorder=Pch_CS2_disorder(1:96);Pch_CS3_disorder=Pch_CS3_disorder(1:96);Pch_CS4_disorder=Pch_CS4_disorder(1:96);
save('data_disorder','Pch_CS1_disorder','Pch_CS2_disorder','Pch_CS3_disorder','Pch_CS4_disorder');%无序充电数据
