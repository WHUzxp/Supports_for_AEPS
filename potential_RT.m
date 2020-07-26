%%%实时可调度潜力计算(采用结构体保存)%%%
%%%间隔15分钟%%%
%%%按照电动汽车进站时间顺序，滚动计算%%%
clear
clc
load('data_EV.mat')
%充电站1
RT_CS1.EV=[data_CS1(1001).Ta;data_CS1(1001).Tl;data_CS1(1001).S0]';
RT_CS1.EV=sortrows(RT_CS1.EV,1);%按照进站时间先后顺序排序
for t=1:97%分时间计算可调度潜力
    temp1=RT_CS1(1).EV(find(RT_CS1(1).EV(:,1)<=t),:);
    RT_CS1(t).EVset=[temp1];%得到电动汽车集合
    [temp2,temp3]=size(RT_CS1(t).EVset);%矩阵长度，目的是得到电动汽车的数量，temp2是数量
    RT_CS1(t).X=zeros(temp2,97);%停泊状态矩阵
    for j=1:temp2
        RT_CS1(t).X(j,RT_CS1(t).EVset(j,1):RT_CS1(t).EVset(j,2))=1;
    end
    RT_CS1(t).EVset=RT_CS1(t).EVset';
    if temp2~=1%只有一辆车的情况要特殊讨论，谨慎使用sum
        RT_CS1(t).Pch=6.6*sum(RT_CS1(t).X);
        RT_CS1(t).Pdis=6.6*sum(RT_CS1(t).X);
        RT_CS1(t).Smin=32*0.15*sum(RT_CS1(t).X);%广义储能的最小容量
        RT_CS1(t).Smax=32*0.9*sum(RT_CS1(t).X);%广义储能的最大容量
        RT_CS1(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS1(t).dS(1)=RT_CS1(t).EVset(3,:)*RT_CS1(t).X(:,1);
        RT_CS1(t).dS(2:97)=RT_CS1(t).EVset(3,:)*(RT_CS1(t).X(:,2:97).*(RT_CS1(t).X(:,2:97)-RT_CS1(t).X(:,1:96)))-32*0.9*sum(RT_CS1(t).X(:,1:96).*(RT_CS1(t).X(:,1:96)-RT_CS1(t).X(:,2:97)));
    else
        RT_CS1(t).Pch=6.6*RT_CS1(t).X;
        RT_CS1(t).Pdis=6.6*RT_CS1(t).X;
        RT_CS1(t).Smin=32*0.15*(RT_CS1(t).X);%广义储能的最小容量
        RT_CS1(t).Smax=32*0.9*(RT_CS1(t).X);%广义储能的最大容量
        RT_CS1(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS1(t).dS(1)=RT_CS1(t).EVset(3,:)*RT_CS1(t).X(:,1);
        RT_CS1(t).dS(2:97)=RT_CS1(t).EVset(3,:)*(RT_CS1(t).X(:,2:97).*(RT_CS1(t).X(:,2:97)-RT_CS1(t).X(:,1:96)))-32*0.9*(RT_CS1(t).X(:,1:96).*(RT_CS1(t).X(:,1:96)-RT_CS1(t).X(:,2:97)));
    end
end
%充电站2
RT_CS2.EV=[data_CS2(1001).Ta;data_CS2(1001).Tl;data_CS2(1001).S0]';
RT_CS2.EV=sortrows(RT_CS2.EV,1);%按照进站时间先后顺序排序
for t=1:97%分时间计算可调度潜力
    temp1=RT_CS2(1).EV(find(RT_CS2(1).EV(:,1)<=t),:);
    RT_CS2(t).EVset=[temp1];%得到电动汽车集合
    [temp2,temp3]=size(RT_CS2(t).EVset);%矩阵长度，目的是得到电动汽车的数量，temp2是数量
    RT_CS2(t).X=zeros(temp2,97);%停泊状态矩阵
    for j=1:temp2
        RT_CS2(t).X(j,RT_CS2(t).EVset(j,1):RT_CS2(t).EVset(j,2))=1;
    end
    RT_CS2(t).EVset=RT_CS2(t).EVset';
    if temp2~=1%只有一辆车的情况要特殊讨论，谨慎使用sum
        RT_CS2(t).Pch=6.6*sum(RT_CS2(t).X);
        RT_CS2(t).Pdis=6.6*sum(RT_CS2(t).X);
        RT_CS2(t).Smin=32*0.15*sum(RT_CS2(t).X);%广义储能的最小容量
        RT_CS2(t).Smax=32*0.9*sum(RT_CS2(t).X);%广义储能的最大容量
        RT_CS2(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS2(t).dS(1)=RT_CS2(t).EVset(3,:)*RT_CS2(t).X(:,1);
        RT_CS2(t).dS(2:97)=RT_CS2(t).EVset(3,:)*(RT_CS2(t).X(:,2:97).*(RT_CS2(t).X(:,2:97)-RT_CS2(t).X(:,1:96)))-32*0.9*sum(RT_CS2(t).X(:,1:96).*(RT_CS2(t).X(:,1:96)-RT_CS2(t).X(:,2:97)));
    else
        RT_CS2(t).Pch=6.6*RT_CS2(t).X;
        RT_CS2(t).Pdis=6.6*RT_CS2(t).X;
        RT_CS2(t).Smin=32*0.15*(RT_CS2(t).X);%广义储能的最小容量
        RT_CS2(t).Smax=32*0.9*(RT_CS2(t).X);%广义储能的最大容量
        RT_CS2(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS2(t).dS(1)=RT_CS2(t).EVset(3,:)*RT_CS2(t).X(:,1);
        RT_CS2(t).dS(2:97)=RT_CS2(t).EVset(3,:)*(RT_CS2(t).X(:,2:97).*(RT_CS2(t).X(:,2:97)-RT_CS2(t).X(:,1:96)))-32*0.9*(RT_CS2(t).X(:,1:96).*(RT_CS2(t).X(:,1:96)-RT_CS2(t).X(:,2:97)));
    end
end
%充电站3
RT_CS3.EV=[data_CS3(1001).Ta;data_CS3(1001).Tl;data_CS3(1001).S0]';
RT_CS3.EV=sortrows(RT_CS3.EV,1);%按照进站时间先后顺序排序
for t=1:97%分时间计算可调度潜力
    temp1=RT_CS3(1).EV(find(RT_CS3(1).EV(:,1)<=t),:);
    RT_CS3(t).EVset=[temp1];%得到电动汽车集合
    [temp2,temp3]=size(RT_CS3(t).EVset);%矩阵长度，目的是得到电动汽车的数量，temp2是数量
    RT_CS3(t).X=zeros(temp2,97);%停泊状态矩阵
    for j=1:temp2
        RT_CS3(t).X(j,RT_CS3(t).EVset(j,1):RT_CS3(t).EVset(j,2))=1;
    end
    RT_CS3(t).EVset=RT_CS3(t).EVset';
    if temp2~=1%只有一辆车的情况要特殊讨论，谨慎使用sum
        RT_CS3(t).Pch=6.6*sum(RT_CS3(t).X);
        RT_CS3(t).Pdis=6.6*sum(RT_CS3(t).X);
        RT_CS3(t).Smin=32*0.15*sum(RT_CS3(t).X);%广义储能的最小容量
        RT_CS3(t).Smax=32*0.9*sum(RT_CS3(t).X);%广义储能的最大容量
        RT_CS3(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS3(t).dS(1)=RT_CS3(t).EVset(3,:)*RT_CS3(t).X(:,1);
        RT_CS3(t).dS(2:97)=RT_CS3(t).EVset(3,:)*(RT_CS3(t).X(:,2:97).*(RT_CS3(t).X(:,2:97)-RT_CS3(t).X(:,1:96)))-32*0.9*sum(RT_CS3(t).X(:,1:96).*(RT_CS3(t).X(:,1:96)-RT_CS3(t).X(:,2:97)));
    else
        RT_CS3(t).Pch=6.6*RT_CS3(t).X;
        RT_CS3(t).Pdis=6.6*RT_CS3(t).X;
        RT_CS3(t).Smin=32*0.15*(RT_CS3(t).X);%广义储能的最小容量
        RT_CS3(t).Smax=32*0.9*(RT_CS3(t).X);%广义储能的最大容量
        RT_CS3(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS3(t).dS(1)=RT_CS3(t).EVset(3,:)*RT_CS3(t).X(:,1);
        RT_CS3(t).dS(2:97)=RT_CS3(t).EVset(3,:)*(RT_CS3(t).X(:,2:97).*(RT_CS3(t).X(:,2:97)-RT_CS3(t).X(:,1:96)))-32*0.9*(RT_CS3(t).X(:,1:96).*(RT_CS3(t).X(:,1:96)-RT_CS3(t).X(:,2:97)));
    end
end
%充电站4
RT_CS4.EV=[data_CS4(1001).Ta;data_CS4(1001).Tl;data_CS4(1001).S0]';
RT_CS4.EV=sortrows(RT_CS4.EV,1);%按照进站时间先后顺序排序
for t=1:97%分时间计算可调度潜力
    temp1=RT_CS4(1).EV(find(RT_CS4(1).EV(:,1)<=t),:);
    RT_CS4(t).EVset=[temp1];%得到电动汽车集合
    [temp2,temp3]=size(RT_CS4(t).EVset);%矩阵长度，目的是得到电动汽车的数量，temp2是数量
    RT_CS4(t).X=zeros(temp2,97);%停泊状态矩阵
    for j=1:temp2
        RT_CS4(t).X(j,RT_CS4(t).EVset(j,1):RT_CS4(t).EVset(j,2))=1;
    end
    RT_CS4(t).EVset=RT_CS4(t).EVset';
    if temp2~=1%只有一辆车的情况要特殊讨论，谨慎使用sum
        RT_CS4(t).Pch=6.6*sum(RT_CS4(t).X);
        RT_CS4(t).Pdis=6.6*sum(RT_CS4(t).X);
        RT_CS4(t).Smin=32*0.15*sum(RT_CS4(t).X);%广义储能的最小容量
        RT_CS4(t).Smax=32*0.9*sum(RT_CS4(t).X);%广义储能的最大容量
        RT_CS4(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS4(t).dS(1)=RT_CS4(t).EVset(3,:)*RT_CS4(t).X(:,1);
        RT_CS4(t).dS(2:97)=RT_CS4(t).EVset(3,:)*(RT_CS4(t).X(:,2:97).*(RT_CS4(t).X(:,2:97)-RT_CS4(t).X(:,1:96)))-32*0.9*sum(RT_CS4(t).X(:,1:96).*(RT_CS4(t).X(:,1:96)-RT_CS4(t).X(:,2:97)));
    else
        RT_CS4(t).Pch=6.6*RT_CS4(t).X;
        RT_CS4(t).Pdis=6.6*RT_CS4(t).X;
        RT_CS4(t).Smin=32*0.15*(RT_CS4(t).X);%广义储能的最小容量
        RT_CS4(t).Smax=32*0.9*(RT_CS4(t).X);%广义储能的最大容量
        RT_CS4(t).dS=zeros(1,97);%广义储能的容量变化量
        RT_CS4(t).dS(1)=RT_CS4(t).EVset(3,:)*RT_CS4(t).X(:,1);
        RT_CS4(t).dS(2:97)=RT_CS4(t).EVset(3,:)*(RT_CS4(t).X(:,2:97).*(RT_CS4(t).X(:,2:97)-RT_CS4(t).X(:,1:96)))-32*0.9*(RT_CS4(t).X(:,1:96).*(RT_CS4(t).X(:,1:96)-RT_CS4(t).X(:,2:97)));
    end
end
%画图，以充电站3为例
load data_potential_DA
figure(3)%第24个15分钟
hold on
plot(RT_CS3(24).Pch,'b')%充电功率边界
plot(-RT_CS3(24).Pdis,'g')%放电功率边界
legend('充电功率上界','放电功率上界')
xlabel 时间
ylabel 功率(kW)
figure(4);
hold on
plot(RT_CS3(24).Smax,'b')%SOC上界
plot(RT_CS3(24).Smin,'g')%SOC下界
legend('SOC上界','SOC下界')
xlabel 时间
ylabel 容量(kWh)
figure(5)%与日前对比
hold on
plot(Forecast_CS3(1,:),'b')%充电功率边界
plot(-Forecast_CS3(2,:),'g')%放电功率边界
plot(RT_CS3(97).Pch,'b.-')%充电功率边界
plot(-RT_CS3(97).Pdis,'g.-')%放电功率边界
legend('日前充电功率上界','日前放电功率上界','实时充电功率上界','实时放电功率上界')
xlabel 时间
ylabel 功率(kW)
figure(6);
hold on
plot(Forecast_CS3(4,:),'b')%SOC上界
plot(Forecast_CS3(3,:),'g')%SOC下界
plot(RT_CS3(97).Smin,'b.-')%SOC上界
plot(RT_CS3(97).Smax,'g.-')%SOC下界
legend('日前SOC上界','日前SOC下界')
xlabel 时间
ylabel 容量(kWh)
save('data_potential_RT','RT_CS1','RT_CS2','RT_CS3','RT_CS4');%实时可调度潜力