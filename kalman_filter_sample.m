clc; 
clear;
N=200; 

for t=1:N  %真实值
    truth(t) = 25+cos(t);
    if t>40 
        truth(t)=10+sin(t)
    end
    if t > 120
        truth(t)=30+cos(t)
    end

end
for t=1:N     
    z(t)=truth(t)+3*randn;     %测量值 
end 
R=std(z)^2             %测量噪声  
V=0.1*randn(1,N); 

Q=3 %std(V)^2             %模型噪声 
p(1)=10;
x(1)=0; 

for t=2:N   
    x1(t)=x(t-1);                      %预测状态   
    p1(t)=p(t-1)+Q;                 %预测估计协方差         
    k(t)=p1(t)/(p1(t)+R);           %最优卡尔曼增益     
    x(t)=x1(t)+k(t)*(z(t)-x1(t));   %更新状态估计     
    p(t)=(1-k(t))*p1(t);                %更新协方差估计 
end  
t=1:N; 
plot(t,truth,'g',t,z,'b',t,x,'r'); 
legend('真实值','测量值','估计值');
