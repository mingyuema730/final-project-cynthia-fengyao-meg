load LAdata.mat

%%
figure; clf 
for i = 1:7
    scatter(LAdata{i}.serial, LAdata{i}.measurement)
    hold on
end
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')

%%
sites2014 = unique(LAdata{7}.site);

ind = find(LAdata{7}.site == sites2014(1,1));

%%

figure; clf
scatter(LAdata{7}.serial(ind), LAdata{7}.measurement(ind)) 
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')

mm2014site1 = movmean(LAdata{7}.measurement(ind), 24);

figure; clf
plot(LAdata{7}.serial(ind), mm2014site1, 'Linewidth', 3) 
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')

figure; clf
hold on 
plot(LAdata{7}.serial(ind), mm2014site1, 'Linewidth', 1) 
scatter(date, rain, 'filled')
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3 precip')
datetick('x',2,'keeplimits')




% 
% % date1 = (datetime(2014,1,1,1,0,0):hours(1):datetime(2015,1,1,0,0,0))';
% TT = timetable(LAdata{7}.serial,LAdata{7}.measurement);
% TT_out = retime(TT,'daily','mean');


