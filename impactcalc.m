load LAdata.mat

%% 2013 at oceanside site 
figure; clf 
scatter(LAdata{6}.serial, LAdata{6}.measurement)
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')

%%
sites2013 = unique(LAdata{6}.site);
lat2013 = unique(LAdata{6}.lat);
lon2013 = unique(LAdata{6}.lon);

site = {}; 

for i = 1:6
    site{i}.index = find(LAdata{6}.site == sites2013(i,1));
end 

%evenly spaced hours in 2013
t1 = datetime(2013,1,1,0,0,0);
t2 = datetime(2013,12,31,24,0,0);
t = t1:hours(1):t2;
t = datenum(t);

%interp 
interpPM = interp1(LAdata{6}.serial(site{4}.index), LAdata{6}.measurement(site{4}.index),t); 

site{4}.oldmovemean = movmean(LAdata{6}.measurement(site{4}.index), 24); 
site{4}.movemean = movmean(interpPM, 24); 


%% use 2013 data 
% site 4 lat lon     33.2171    -117.3962

%PM2.5 at each site 
figure; clf 
for i = 3:6
    scatter(LAdata{6}.serial(site{i}.index), LAdata{6}.measurement(site{i}.index)) 
    hold on
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')
end

%PM2.5 at site 4 
figure; clf
hold on
scatter(LAdata{6}.serial(site{4}.index), LAdata{6}.measurement(site{4}.index)) 
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')

%moving mean without interp and with interped data 
figure; clf 
plot(LAdata{6}.serial(site{4}.index), site{4}.oldmovemean, 'LineWidth', 2)
hold on 
plot(t, site{4}.movemean);
datetick('x','mmm','keeplimits')

% interpt mean and rain events 
figure; clf
hold on 
yyaxis left 
plot(t, site{4}.movemean, 'LineWidth', 2)
ylabel('PM2.5 ug/m^3')
yyaxis right
scatter(date1, rain/10, 'filled')
datetick('x',2,'keeplimits')
% ylim([0 150])
ylabel('Precip (mm)')
datetick('x','mmm','keeplimits')

%finding rate of change, looking for negative rate of change 
site{4}.changeinpm = diff(interpPM);
site{4}.changeintime = diff(t);
rateofchange = site{4}.changeinpm./site{4}.changeintime;
site{4}.changeinpm(1,8761) = NaN;
site{4}.changeintime(1,8761) = NaN;
negrate = find(rateofchange <= 0);

%change in PM2.5 concentration
figure; clf
hold on 
yyaxis left
scatter(t, site{4}.changeinpm , 'LineWidth', 2)
yyaxis right
scatter(date1, rain/10, 'filled')
datetick('x',2,'keeplimits')
% ylim([0 150])
ylabel('Precip (mm)')
datetick('x','mmm','keeplimits')

%negative rates of change in PM2.5 concentration
figure; clf
hold on 
yyaxis left
plot(t(negrate), rateofchange(negrate), 'LineWidth', 2)
yyaxis right
scatter(date1, rain/10, 'filled')
datetick('x',2,'keeplimits')
% ylim([0 150])
ylabel('Precip (mm)')
datetick('x','mmm','keeplimits')

%%
LAdata{6}.serialround = round(LAdata{6}.serial);

%number of unique days 
serialunique = unique(LAdata{6}.serialround);

for i = 1:366 
    find(LAdata{6}.serialround == serialunique(i,1));
    %mean(LAdata{6}.measurement(site{4}.index(n:n+24)))
    
end

%%
figure; clf
bar([precip_event.start_time precip_event.end_time], precip_event.total_precip,'FaceColor','b','EdgeColor','b','barwidth',20)
set(gca, 'YDir', 'reverse')
%xlim([datenum('01-01-2013 00:00:00') datenum('02-01-2013 00:00:00')])
datetick('x','mm-dd')
xlabel('Date')
ylabel('Total Precipitation (cm)')
title('Precipitation in Los Angeles in 2013')

%%
figure ; clf
t = tiledlayout(1,1);
ax1 = axes(t);
p = scatter(ax1, time, hourly_pm_smooth);
xlabel('Date');
ylabel('PM 2.5 Concentration (ug/m^3)');
datetick('x','mmm');
xlim(ax1, [datenum('12-31-2012 23:59:59') datenum('12-31-2013 23:59:00')]);


ax2 = axes(t);
b = bar(ax2, [precip_event.start_time precip_event.end_time], precip_event.total_precip,'FaceColor','b','EdgeColor','b','barwidth',20);
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
set(ax2, 'YDir', 'reverse');
set(ax2, 'Xtick', []);
ylabel(ax2, 'Total Precipitation (cm)')
ax2.Color = 'none';
ax1.Box = 'off';
ax2.Box = 'off';
title(t, 'Precipitation and PM 2.5 Concentration in Los Angeles in 2013')
xlim(ax2, [datenum('12-31-2012 23:59:59') datenum('12-31-2013 23:59:00')]);
%%

pmchange = diff(hourly_pm); 
timechange = diff(time);
laroc = pmchange./timechange; 
laroc(8569,1) = NaN;

timereformat = datetime(time, 'ConvertFrom', 'datenum');

%rate of change
figure; clf 
yyaxis left
plot(time,laroc);
ylabel('Rate of Change (ug m^-3 hr^-^1)')
hold on 
yyaxis right 
bar(precip_event.start_time, precip_event.total_precip,'FaceColor','b','EdgeColor','b','barwidth',20);
ylabel('Precipitation')


%% finding PM2.5 values and rate of change for each precip event 
%interp PM2.5 onto minutes 
t3 = datetime(2013,1,1,0,0,0);
t4 = datetime(2013,12,31,24,0,0);
z = t3:minutes(1):t4;
x = datenum(z);


figure (1); clf
plot(time, hourly_pm)
datetick('x', 'mm-dd')

hourly_pm = pm_raw.value;
hourly_pm_smooth = movmean(hourly_pm, 24);

minutePM = interp1(time(1:8560), hourly_pm(1:8560), x); 

figure; clf
scatter(x, minutePM)


%%
%exclude events with duration of 0 
realind = find(precip_event.duration > 0); 

%%

%calculating change before and after events 
for i = 1:length(precip_event.start_time)
        ind_start_time = find(x == precip_event.start_time(i));
        ind_end_time = find(x == precip_event.end_time(i));
        meanpmduring(i,1) = mean(minutePM(ind_start_time:ind_end_time), 'omitnan');
end

for i = 1:length(precip_event.start_time)
        ind_before = find(x == precip_event.start_time(i)-6);
        ind_start_time = find(x == precip_event.start_time(i));
        meanpmbefore(i,1) = mean(minutePM(ind_before:ind_start_time), 'omitnan');
end

for i = 1:length(precip_event.start_time)
        ind_end_time = find(x == precip_event.end_time(i));
        ind_end_timelate = find(x == precip_event.end_time(i)+2);
        meanpmafter(i,1) = mean(minutePM(ind_end_time:ind_end_timelate), 'omitnan');
end

for i = 1:length(precip_event.start_time)
        ind_end_time = find(x == precip_event.end_time(i)+18);
        ind_end_timelate = find(x == precip_event.end_time(i)+24);
        meanpmdayafter(i,1) = mean(minutePM(ind_end_time:ind_end_timelate), 'omitnan');
end


%%
%figures

avchangeduring = mean(meanpmduring(realind)-meanpmbefore(realind)); 
changeduring = (meanpmduring(realind)-meanpmbefore(realind)); 
%before and during
figure; clf 
bar([meanpmbefore(realind), meanpmduring(realind)])
hold on 
legend('6 to 0 hours before', 'During event')

%before and during with index compar
figure; clf 
bar([meanpmbefore(realind), meanpmduring(realind)])
hold on 
legend('6 to 0 hours before', 'During event')

avchangeshort = nanmean(meanpmafter(realind)-meanpmbefore(realind)); 
changeshort = (meanpmafter(realind)-meanpmbefore(realind)); 
%before and after
figure; clf 
bar([meanpmbefore(realind), meanpmafter(realind)])
hold on 
legend('6 to 0 hours before','0 to 2 hours after')

avchangelong = nanmean(meanpmdayafter(realind)-meanpmbefore(realind)); 
changelong = (meanpmdayafter(realind)-meanpmbefore(realind)); 
%before and 24 hours later bar
figure; clf 
bar([meanpmbefore(realind), meanpmdayafter(realind)])
hold on 
legend('6 to 0 hours before','18 to 24 hours after')



%%
%event #
event = 1:33;
%scatter before and long after 
figure; clf 
scatter(event,meanpmbefore(realind),'filled')
hold on 
scatter(event,meanpmdayafter(realind),'filled')
legend('6 to 0 hours before','18 to 24 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')

%scatter before and short after 
figure; clf 
scatter(event,meanpmbefore(realind),'filled')
hold on 
scatter(event,meanpmafter(realind),'filled')
legend('6 to 0 hours before','0 to 2 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')


%%
figure; clf 
scatter(event, changeshort, 'filled')
hold on 
scatter(event, changelong, 'filled')
legend('0-2 hours after change', '18-24 hours after change')
xlabel('Event #')
ylabel('Change in PM2.5 (\mug/m^3)')

%%
%statistical significance 

[h,p] = ttest(changeduring)
%rejects null, p < 0.001


[h,p] = ttest(changeshort)
% does not reject null, p <0.001


[h,p] = ttest(changelong)
%does not reject null, p = 0.034

%%
%duration index 
below1 = find(precip_event.duration_type == 1 & precip_event.duration > 0); 
 
above1 = find(precip_event.duration_type > 1);

%% duration index figures
%event #
event = 1:16;
%scatter before and long after less than 1 hour of rain
figure; clf 
scatter(event,meanpmbefore(below1),'filled')
hold on 
scatter(event,meanpmdayafter(below1),'filled')
legend('6 to 0 hours before','18 to 24 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')

nanmean(meanpmdayafter(below1)-meanpmbefore(below1))


event = 1:length(above1);
%scatter before and short after greater than 1 hour of rain
figure; clf 
scatter(event,meanpmbefore(above1),'filled')
hold on 
scatter(event,meanpmdayafter(above1),'filled')
legend('6 to 0 hours before','18 to 24 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')

%% 
% comparing before and immediately after for different durations 
event = 1:16;
%scatter before and short after less than 1 hour of rain
figure; clf 
scatter(event,meanpmbefore(below1),'filled')
hold on 
scatter(event,meanpmafter(below1),'filled')
legend('6 to 0 hours before','0 to 2 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')

nanmean(meanpmafter(below1)-meanpmbefore(below1))

event = 1:length(above1);
%scatter before and short after greater than 1 hour of rain
figure; clf 
scatter(event,meanpmbefore(above1),'filled')
hold on 
scatter(event,meanpmafter(above1),'filled')
legend('6 to 0 hours before','0 to 2 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')

nanmean(meanpmafter(above1)-meanpmbefore(above1))



%%
%intensity index 

belowhalf = find(precip_event.intensity <= 0.5 & precip_event.duration > 0); 
 
abovehalf = find(precip_event.intensity > 0.5 & precip_event.duration > 0);

%% intensity figures
% comparing before and immediately after for different intensities 
event = 1:19;
%scatter before and short after less than 1 hour of rain
figure; clf 
scatter(event,meanpmbefore(belowhalf),'filled')
hold on 
scatter(event,meanpmafter(belowhalf),'filled')
legend('6 to 0 hours before','0 to 2 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')

nanmean(meanpmafter(belowhalf)-meanpmbefore(belowhalf))

event = 1:length(abovehalf);
%scatter before and short after greater than 1 hour of rain
figure; clf 
scatter(event,meanpmbefore(abovehalf),'filled')
hold on 
scatter(event,meanpmafter(abovehalf),'filled')
legend('6 to 0 hours before','0 to 2 hours after')
ylabel('PM2.5 (\mug/m^3)')
xlabel('Event #')

nanmean(meanpmafter(above1)-meanpmbefore(above1))
