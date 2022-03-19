[num] = readtable('E:\bishe\data\python_data\add.xls');
array = table2cell(num);
for i = 1:1:100
    y = array(1:end,i);
    y_ = cell2mat(y);
    y__ = y_(~isnan(y_));

    time = [];
    time(1) = y__(1)*0.0025;
    for j = 2:1:length(y__)
        time(j) = time(j-1) + y__(j)*0.0025;
    end
    
    ylpf = lowpass(y__,120,1000);
    plot(time,ylpf);
    hold on;
    xlabel('Time(us)');
    ylabel('Counter(LPF)');
    grid on;
end