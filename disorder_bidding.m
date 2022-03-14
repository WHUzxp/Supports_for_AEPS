%%%无序充电投标
clear
clc
load data_disorder
Pch=[Pch_CS1_disorder;Pch_CS2_disorder;Pch_CS3_disorder;Pch_CS4_disorder];%充电站充电功率
%市场出清问题
Link=zeros(24,96);%时段换算矩阵(日前1h换算为实时15min)
for i=1:24
    Link(i,4*i-3:4*i)=1;
end
Loadcurve=[0.955391944564747,0.978345604157644,1,0.995019488956258,0.972932005197055,0.970333477695972,0.930489389346037,0.890428757037679,0.902771762667822,0.941966219142486,0.911000433087917,0.862061498484192,0.840190558683413,0.831095712429623,0.756604590731919,0.671719359029883,0.611520138588133,0.582936336076224,0.572542226071893,0.574707665656128,0.587267215244695,0.644218276310091,0.755521870939801,0.884798614118666];
Loadcurve=Loadcurve*Link;%换成96个时段
PL_base=[5.704;5.705;5.631;6.518;4.890;5.705;5.847]*1000;%负荷分布
PL=PL_base*Loadcurve;%基础负荷(负荷曲线从08:00开始算起，即第9个时段)
Pf=sdpvar(7,96);%馈线功率
Pf(1,:)=PL(1,:)+Pch(1,:);Pf(2,:)=PL(2,:);Pf(3,:)=PL(3,:);Pf(4,:)=PL(4,:)+Pch(2,:);Pf(5,:)=PL(5,:)+Pch(3,:);Pf(6,:)=PL(6,:);Pf(7,:)=PL(7,:)+Pch(4,:);%馈线功率组成
Pg=sdpvar(10,96);%发电商分段电量
Pg_step=1000*[20,5,3,2,2,2,2,2,2,inf]';%报价区间
Price_DSO=[3:12]'*0.1;%分段电价
Obj=0.25*sum(sum((Price_DSO*ones(1,96)).*Pg));%目标为用电费用最小
Constraint=[0<=Pg<=Pg_step*ones(1,96),sum(Pg)==sum(Pf)];%约束条件
solvesdp(Constraint,Obj);%求解线性规划问题
Pg=double(Pg);%发电机功率
Pf=double(Pf);%馈线功率
isPg=(Pg>0);%为了计算出清电价，计算发电机分段选择情况
DLMP=sum(isPg)/10+0.2;%出清电价计算
%绘图
figure(7)%节点边际电价
stairs(DLMP);
xlabel 时间
ylabel 电价(元/kWh)
ylim([0.3,1.3])
figure(8)%负荷曲线
hold on
plot(sum(PL)/1000);
plot(sum(Pf)/1000,'r.-');
xlabel 时间
ylabel 负荷(MW)
legend('基础负荷','无序充电负荷')
Cost=sum(sum(Pch).*DLMP);%总用电费用
result_disorder.Cost=Cost;result_disorder.DLMP=DLMP;result_disorder.Pf=Pf;result_disorder.Pg=Pg;%结果保存
save('result_disorder','result_disorder');
