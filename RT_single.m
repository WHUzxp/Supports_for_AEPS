%%%充电站独立投标%%%
%%%实时市场%%%
clear
clc
load result_DA_clearing
Pch_last=Pch_DA_clearing;
Pdis_last=Pdis_DA_clearing;
price_balance=0.1;
DLMP=zeros(4,96);
for l=1:96
    for i=1:10
        Set_CS_bid=1;
        result_RT_single_CS1=RT_single_Callback(l,Set_CS_bid,Pch_last,Pdis_last,price_balance);
        Pch_last(Set_CS_bid,l)=result_RT_single_CS1.Pch(Set_CS_bid,l);
        Pdis_last(Set_CS_bid,l)=result_RT_single_CS1.Pdis(Set_CS_bid,l);
        CS1_iteration(i).delta_Pg(l)=result_RT_single_CS1.delta_Pg;CS1_iteration(i).Pch(l)=result_RT_single_CS1.Pch(Set_CS_bid,l);CS1_iteration(i).Pdis(l)=result_RT_single_CS1.Pdis(Set_CS_bid,l);CS1_iteration(i).DLMP(l)=result_RT_single_CS1.DLMP(1);        
        Set_CS_bid=2;
        result_RT_single_CS2=RT_single_Callback(l,Set_CS_bid,Pch_last,Pdis_last,price_balance);
        Pch_last(Set_CS_bid,l)=result_RT_single_CS2.Pch(Set_CS_bid,l);
        Pdis_last(Set_CS_bid,l)=result_RT_single_CS2.Pdis(Set_CS_bid,l);
        CS2_iteration(i).delta_Pg(l)=result_RT_single_CS2.delta_Pg;CS2_iteration(i).Pch(l)=result_RT_single_CS2.Pch(Set_CS_bid,l);CS2_iteration(i).Pdis(l)=result_RT_single_CS2.Pdis(Set_CS_bid,l);CS2_iteration(i).DLMP(l)=result_RT_single_CS2.DLMP(1);        
        Set_CS_bid=3;
        result_RT_single_CS3=RT_single_Callback(l,Set_CS_bid,Pch_last,Pdis_last,price_balance);
        Pch_last(Set_CS_bid,l)=result_RT_single_CS3.Pch(Set_CS_bid,l);
        Pdis_last(Set_CS_bid,l)=result_RT_single_CS3.Pdis(Set_CS_bid,l);
        CS3_iteration(i).delta_Pg(l)=result_RT_single_CS3.delta_Pg;CS3_iteration(i).Pch(l)=result_RT_single_CS3.Pch(Set_CS_bid,l);CS3_iteration(i).Pdis(l)=result_RT_single_CS3.Pdis(Set_CS_bid,l);CS3_iteration(i).DLMP(l)=result_RT_single_CS3.DLMP(1);        
        Set_CS_bid=4;
        result_RT_single_CS4=RT_single_Callback(l,Set_CS_bid,Pch_last,Pdis_last,price_balance);
        Pch_last(Set_CS_bid,l)=result_RT_single_CS4.Pch(Set_CS_bid,l);
        Pdis_last(Set_CS_bid,l)=result_RT_single_CS4.Pdis(Set_CS_bid,l);
        CS4_iteration(i).delta_Pg(l)=result_RT_single_CS4.delta_Pg;CS4_iteration(i).Pch(l)=result_RT_single_CS4.Pch(Set_CS_bid,l);CS4_iteration(i).Pdis(l)=result_RT_single_CS4.Pdis(Set_CS_bid,l);CS4_iteration(i).DLMP(l)=result_RT_single_CS4.DLMP(1);        
        DLMP(:,l)=[result_RT_single_CS1.DLMP(1);result_RT_single_CS2.DLMP(1);result_RT_single_CS3.DLMP(1);result_RT_single_CS4.DLMP(1)];
    end
end
save('result_RT_single','CS1_iteration','CS2_iteration','CS3_iteration','CS4_iteration');