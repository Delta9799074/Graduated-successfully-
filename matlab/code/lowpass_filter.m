time2 = [];
time2(1) = subcnt(1)*0.0025;
for i =  2:1:length(subcnt)
    time2(i) = time2(i - 1) + subcnt(i)*0.0025;
end

% LPF
% hpf1 = highpass(subcnt,250,1000);
lpf1 = lowpass(subcnt,215,1000);
re_smp = resample(lpf1,250,1000);
%lpf2 = lowpass(lpf1,10,500);
%plot
figure(1)
plot(time2,subcnt);
hold on;
xlabel('Time(us)');
ylabel('Counter');
%legend('no LPF','LPF');
grid on;

figure(2)
plot(time2,lpf1);
hold on;
xlabel('Time(us)');
ylabel('Counter');
%legend('no LPF','LPF');
grid on;

% figure(3)
% plot(time2,hpf1);
% hold on;
% xlabel('Time(us)');
% ylabel('Counter');
% %legend('no LPF','LPF');
% grid on;
