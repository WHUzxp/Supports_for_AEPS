%%%完全竞争市场%%%
%%%价格接受者%%%
%%%实时调度，价格采用联合(独立)报价模式下的出清价格%%%
clear
clc
%基本参数
load result_RT_cooperation
price_RT=result_RT_cooperation.Price_DLMP(1,:);%实时节点边际电价
load Bid_reference
price_DA=pi_DA_reference(1,:);%日前节点边际电价
Pch_last=zeros(4,96);%之前的充电调度决策(首次使用)
Pdis_last=zeros(4,96);%之前的放电调度决策(首次使用)
load data_potential_RT
%滚动优化
for l=1:96
    Pchmax=[RT_CS1(l).Pch(1:96);RT_CS2(l).Pch(1:96);RT_CS3(l).Pch(1:96);RT_CS4(l).Pch(1:96)];%充电站充电报量上限
    Pdismax=[RT_CS1(l).Pdis(1:96);RT_CS2(l).Pdis(1:96);RT_CS3(l).Pdis(1:96);RT_CS4(l).Pdis(1:96)];%充电站放电报量上限
    Smin=[RT_CS1(l).Smin(1:96);RT_CS2(l).Smin(1:96);RT_CS3(l).Smin(1:96);RT_CS4(l).Smin(1:96)];%充电站电量下限;
    Smax=[RT_CS1(l).Smax(1:96);RT_CS2(l).Smax(1:96);RT_CS3(l).Smax(1:96);RT_CS4(l).Smax(1:96)];%充电站电量上限;
    deltaS=[RT_CS1(l).dS(1:96);RT_CS2(l).dS(1:96);RT_CS3(l).dS(1:96);RT_CS4(l).dS(1:96)];%充电站电量变化量;
    lastS=[RT_CS1(l).dS(97);RT_CS2(l).dS(97);RT_CS3(l).dS(97);RT_CS4(l).dS(97)];%第96个时段必须完成的充电量
    Pch=sdpvar(4,96);%各充电站充电电量
    Pch(:,1:l-1)=Pch_last(:,1:l-1);%赋初值
    Pdis=sdpvar(4,96);%各充电站放电电量
    Pdis(:,1:l-1)=Pdis_last(:,1:l-1);%赋初值
    S=sdpvar(4,96);%广义储能设备电量
    %约束条件
    Constraints=[0<=Pch<=Pchmax,0<=Pdis<=Pdismax,Smin<=S<=Smax,S(:,1)==0.25*0.95*Pch(:,1)-0.25*Pdis(:,1)/0.95+deltaS(:,1),
        S(:,2:96)==S(:,1:95)+0.25*0.95*Pch(:,2:96)-0.25*Pdis(:,2:96)/0.95+deltaS(:,2:96),
        0==S(:,96)+lastS];%充电站约束
    %目标函数
    Obj=sum(sum((ones(4,1)*price_RT(1:l)).*(Pch(:,1:l)-Pdis(:,1:l))))+sum(sum((ones(4,1)*price_RT(l+1:96)).*(Pch(:,l+1:96)-Pdis(:,l+1:96))));%充电站各自目标
    %求解模型
    ops=sdpsettings('solver','gurobi','gurobi.OptimalityTol',1e-8,'gurobi.FeasibilityTol',1e-8,'gurobi.IntFeasTol',1e-8);
    ops.gurobi.MIPGap=1e-8;
    solvesdp(Constraints,Obj,ops);
    Pch_last(:,l)=double(Pch(:,l));%更新状态
    Pdis_last(:,l)=double(Pdis(:,l));%更新状态
end
result_RT_pricetaken.Pch=double(Pch);
result_RT_pricetaken.Pdis=double(Pdis);
result_RT_pricetaken.S=double(S);
save('result_RT_pricetaken','result_RT_pricetaken');