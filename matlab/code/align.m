time1 = [];
time2 = [];
time3 = [];
time4 = [];
time5 = [];

time1(1) = cnt1(1)*0.0025;
time2(1) = cnt2(1)*0.0025;
time3(1) = cnt3(1)*0.0025;
time4(1) = cnt4(1)*0.0025;
time5(1) = cnt5(1)*0.0025;

for i =  2:1:length(cnt1)
    time1(i) = time1(i - 1) + cnt1(i)*0.0025;
end
for j =  2:1:length(cnt2)
    time2(j) = time2(j - 1) + cnt2(j)*0.0025;
end
for k =  2:1:length(cnt3)
    time3(k) = time3(k - 1) + cnt3(k)*0.0025;
end
for m =  2:1:length(cnt4)
    time4(m) = time4(m - 1) + cnt4(m)*0.0025;
end
for n =  2:1:length(cnt5)
    time5(n) = time5(n - 1) + cnt5(n)*0.0025;
end

% time5 = time5 + 50;

time1_ = time1 + 78;
time2_ = time2 - 71;
time3_ = time3 - 95;
time4_ = time4 - 75;
time5_ = time5 + 164;
%cnt1_ = cnt1 - 1000;

% TO CTRL + R/T
% plot(time1,cnt1);
% hold on;
% plot(time2,cnt2);
% hold on;
% plot(time3,cnt3);
% hold on;
% plot(time4,cnt4);
% hold on;
% plot(time5,cnt5);
% hold on;

% TO CTRL + R/T
plot(time1_,cnt1);
hold on;
plot(time2_,cnt2);
hold on;
plot(time3_,cnt3);
hold on;
plot(time4_,cnt4);
hold on;
plot(time5_,cnt5);
hold on;


xlabel('Time(us)');
ylabel('Counter');
legend('test1','test2','test3','test4','test5');
grid on;
