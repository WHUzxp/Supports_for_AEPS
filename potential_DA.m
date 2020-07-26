%%%日前可调度潜力预测%%%
%%%根据历史可调度潜力预测日前可调度潜力%%%
%%%本文中各数据集权重相等%%%
clear
clc
load data_potential_history
%充电站1
Pch_CS1=zeros(1000,97);Pdis_CS1=zeros(1000,97);Smin_CS1=zeros(1000,97);Smax_CS1=zeros(1000,97);dS_CS1=zeros(1000,97);
for i=1:1000
    Pch_CS1(i,:)=data_CS1(i).Pch;Pdis_CS1(i,:)=data_CS1(i).Pdis;Smin_CS1(i,:)=data_CS1(i).Smin;Smax_CS1(i,:)=data_CS1(i).Smax;dS_CS1(i,:)=data_CS1(i).dS;
end
Forecast_CS1=[mean(Pch_CS1);mean(Pdis_CS1);mean(Smin_CS1);mean(Smax_CS1);mean(dS_CS1)];
%充电站2
Pch_CS2=zeros(1000,97);Pdis_CS2=zeros(1000,97);Smin_CS2=zeros(1000,97);Smax_CS2=zeros(1000,97);dS_CS2=zeros(1000,97);
for i=1:1000
    Pch_CS2(i,:)=data_CS2(i).Pch;Pdis_CS2(i,:)=data_CS2(i).Pdis;Smin_CS2(i,:)=data_CS2(i).Smin;Smax_CS2(i,:)=data_CS2(i).Smax;dS_CS2(i,:)=data_CS2(i).dS;
end
Forecast_CS2=[mean(Pch_CS2);mean(Pdis_CS2);mean(Smin_CS2);mean(Smax_CS2);mean(dS_CS2)];
%充电站3
Pch_CS3=zeros(1000,97);Pdis_CS3=zeros(1000,97);Smin_CS3=zeros(1000,97);Smax_CS3=zeros(1000,97);dS_CS3=zeros(1000,97);
for i=1:1000
    Pch_CS3(i,:)=data_CS3(i).Pch;Pdis_CS3(i,:)=data_CS3(i).Pdis;Smin_CS3(i,:)=data_CS3(i).Smin;Smax_CS3(i,:)=data_CS3(i).Smax;dS_CS3(i,:)=data_CS3(i).dS;
end
Forecast_CS3=[mean(Pch_CS3);mean(Pdis_CS3);mean(Smin_CS3);mean(Smax_CS3);mean(dS_CS3)];
%充电站4
Pch_CS4=zeros(1000,97);Pdis_CS4=zeros(1000,97);Smin_CS4=zeros(1000,97);Smax_CS4=zeros(1000,97);dS_CS4=zeros(1000,97);
for i=1:1000
    Pch_CS4(i,:)=data_CS4(i).Pch;Pdis_CS4(i,:)=data_CS4(i).Pdis;Smin_CS4(i,:)=data_CS4(i).Smin;Smax_CS4(i,:)=data_CS4(i).Smax;dS_CS4(i,:)=data_CS4(i).dS;
end
Forecast_CS4=[mean(Pch_CS4);mean(Pdis_CS4);mean(Smin_CS4);mean(Smax_CS4);mean(dS_CS4)];
save('data_potential_DA','Forecast_CS1','Forecast_CS2','Forecast_CS3','Forecast_CS4');%日前可调度潜力