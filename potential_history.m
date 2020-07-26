%%%历史可调度潜力计算%%%
%%%根据历史停靠数据评估电动汽车可调度潜力%%%
clear
clc
load data_EV
for i=1:1000
    %充电站1
    data_CS1(i).X=zeros(length(data_CS1(i).S0),97);%生成停泊状态矩阵
    for j=1:length(data_CS1(i).S0)
        data_CS1(i).X(j,data_CS1(i).Ta(j):data_CS1(i).Tl(j))=1;
    end
    data_CS1(i).Pch=6.6*sum(data_CS1(i).X);%广义储能的充电功率
    data_CS1(i).Pdis=6.6*sum(data_CS1(i).X);%广义储能的放电功率
    data_CS1(i).Smin=32*0.15*sum(data_CS1(i).X);%广义储能的最小容量
    data_CS1(i).Smax=32*0.9*sum(data_CS1(i).X);%广义储能的最大容量
    data_CS1(i).dS=zeros(1,97);%广义储能的容量变化量
    data_CS1(i).dS(1,1)=data_CS1(i).S0*data_CS1(i).X(:,1);
    data_CS1(i).dS(1,2:97)=data_CS1(i).S0*(data_CS1(i).X(:,2:97).*(data_CS1(i).X(:,2:97)-data_CS1(i).X(:,1:96)))-32*0.9*sum(data_CS1(i).X(:,1:96).*(data_CS1(i).X(:,1:96)-data_CS1(i).X(:,2:97)));
    %充电站2
    data_CS2(i).X=zeros(length(data_CS2(i).S0),97);%生成停泊状态矩阵
    for j=1:length(data_CS2(i).S0)
        data_CS2(i).X(j,data_CS2(i).Ta(j):data_CS2(i).Tl(j))=1;
    end
    data_CS2(i).Pch=6.6*sum(data_CS2(i).X);%广义储能的充电功率
    data_CS2(i).Pdis=6.6*sum(data_CS2(i).X);%广义储能的放电功率
    data_CS2(i).Smin=32*0.15*sum(data_CS2(i).X);%广义储能的最小容量
    data_CS2(i).Smax=32*0.9*sum(data_CS2(i).X);%广义储能的最大容量
    data_CS2(i).dS=zeros(1,97);%广义储能的容量变化量
    data_CS2(i).dS(1,1)=data_CS2(i).S0*data_CS2(i).X(:,1);
    data_CS2(i).dS(1,2:97)=data_CS2(i).S0*(data_CS2(i).X(:,2:97).*(data_CS2(i).X(:,2:97)-data_CS2(i).X(:,1:96)))-32*0.9*sum(data_CS2(i).X(:,1:96).*(data_CS2(i).X(:,1:96)-data_CS2(i).X(:,2:97)));
    %充电站3
    data_CS3(i).X=zeros(length(data_CS3(i).S0),97);%生成停泊状态矩阵
    for j=1:length(data_CS3(i).S0)
        data_CS3(i).X(j,data_CS3(i).Ta(j):data_CS3(i).Tl(j))=1;
    end
    data_CS3(i).Pch=6.6*sum(data_CS3(i).X);%广义储能的充电功率
    data_CS3(i).Pdis=6.6*sum(data_CS3(i).X);%广义储能的放电功率
    data_CS3(i).Smin=32*0.15*sum(data_CS3(i).X);%广义储能的最小容量
    data_CS3(i).Smax=32*0.9*sum(data_CS3(i).X);%广义储能的最大容量
    data_CS3(i).dS=zeros(1,97);%广义储能的容量变化量
    data_CS3(i).dS(1,1)=data_CS3(i).S0*data_CS3(i).X(:,1);
    data_CS3(i).dS(1,2:97)=data_CS3(i).S0*(data_CS3(i).X(:,2:97).*(data_CS3(i).X(:,2:97)-data_CS3(i).X(:,1:96)))-32*0.9*sum(data_CS3(i).X(:,1:96).*(data_CS3(i).X(:,1:96)-data_CS3(i).X(:,2:97)));
    %充电站4
    data_CS4(i).X=zeros(length(data_CS4(i).S0),97);%生成停泊状态矩阵
    for j=1:length(data_CS4(i).S0)
        data_CS4(i).X(j,data_CS4(i).Ta(j):data_CS4(i).Tl(j))=1;
    end
    data_CS4(i).Pch=6.6*sum(data_CS4(i).X);%广义储能的充电功率
    data_CS4(i).Pdis=6.6*sum(data_CS4(i).X);%广义储能的放电功率
    data_CS4(i).Smin=32*0.15*sum(data_CS4(i).X);%广义储能的最小容量
    data_CS4(i).Smax=32*0.9*sum(data_CS4(i).X);%广义储能的最大容量
    data_CS4(i).dS=zeros(1,97);%广义储能的容量变化量
    data_CS4(i).dS(1,1)=data_CS4(i).S0*data_CS4(i).X(:,1);
    data_CS4(i).dS(1,2:97)=data_CS4(i).S0*(data_CS4(i).X(:,2:97).*(data_CS4(i).X(:,2:97)-data_CS4(i).X(:,1:96)))-32*0.9*sum(data_CS4(i).X(:,1:96).*(data_CS4(i).X(:,1:96)-data_CS4(i).X(:,2:97)));
end
save('data_potential_history','data_CS1','data_CS2','data_CS3','data_CS4');%电动汽车抽样数据