load precip_all.mat;
load precip_event.mat; 

filename = 'PM25HR_DTLA_2013.csv';
pm_raw = readtable(filename);


%% Distance between PM2.5 and precipitation data collection site
lat_precip = 34.0236;
lon_precip = -118.2911; %lat & lon for dtla precip station

lat_pm = pm_raw.latitude(1);
lon_pm = pm_raw.longitude(1); % lat & lon for dtla pm2.5 monitoring site

d = sqrt( (lat_precip - lat_pm)^2 + (lon_precip - lon_pm)^2) * 111; %distance between two sites in km

%% find time in serial number and hourly 2.5 data & exploratory graph
time = datenum(pm_raw.date + hours(pm_raw.start_hour));
hourly_pm = pm_raw.value;
hourly_pm_smooth = movmean(hourly_pm, 24);

figure (1); clf
plot(time, hourly_pm)
datetick('x', 'mm-dd')

%% Janurary pm2.5 & precip data
ind_jan_pm = find(time >= datenum('2013-01-01 00:00:00') & time < datenum('2013-02-01 00:00:00'));
ind_jan_event = find(precip_event.start_time > datenum('01-01-2013 00:00:00') & precip_event.start_time < datenum('02-01-2013 00:00:00'));

figure (2); clf
t = tiledlayout(1,1);
ax1 = axes(t);
p = plot(ax1, time(ind_jan_pm),hourly_pm_smooth(ind_jan_pm),'-b');
xlabel('Date');
ylabel('PM 2.5 Concentration (ug/m^3)');
datetick('x','mmm');
xlim(ax1, [datenum('12-31-2012 23:59:59') datenum('02-01-2013 00:00:00')]);
ylim(ax1, [0 60]);
set(gca,'Fontsize', 14)

ax2 = axes(t);
b = bar(ax2, [precip_event.start_time(ind_jan_event) precip_event.end_time(ind_jan_event)], precip_event.total_precip(ind_jan_event),'FaceColor','b','EdgeColor','b','barwidth',20);
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
set(ax2, 'YDir', 'reverse');
set(ax2, 'Xtick', []);
xlim(ax2, [datenum('12-31-2012 23:59:59') datenum('02-01-2013 00:00:00')]);
ylabel(ax2, 'Total Precipitation (cm)')
ax2.Color = 'none';
ax1.Box = 'off';
ax2.Box = 'off';
title(t, 'Precipitation and PM 2.5 Concentration in Los Angeles in Janurary 2013')
set(gca,'Fontsize', 14)
%% Janurary pm2.5 & precip data
ind_jan_pm = find(time >= datenum('2013-01-01 00:00:00') & time < datenum('2013-02-01 00:00:00'));
ind_jan_event = find(precip_event.start_time > datenum('01-01-2013 00:00:00') & precip_event.start_time < datenum('02-01-2013 00:00:00'));

figure (2); clf
hold on 
t = tiledlayout(1,1);
ax1 = axes(t);
p = plot(ax1, time,hourly_pm_smooth,'-k');
ylabel('PM 2.5 Concentration (ug/m^3)');
datetick('x','mmm');
%xlim(ax1, [datenum('12-31-2012 23:59:59') datenum('02-01-2013 00:00:00')]);
ylim(ax1, [0 60]);
set(gca,'Fontsize', 14)

ax2 = axes(t);
b = bar(ax2, [precip_event.start_time precip_event.end_time], precip_event.total_precip,'FaceColor','k','EdgeColor','b','barwidth',20);
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
set(ax2, 'YDir', 'reverse');
set(ax2, 'Xtick', []);
%xlim(ax2, [datenum('12-31-2012 23:59:59') datenum('02-01-2013 00:00:00')]);
ylabel(ax2, 'Total Precipitation (cm)')
ax2.Color = 'none';
ax1.Box = 'off';
ax2.Box = 'off';
set(gca,'Fontsize', 14)
title(t, 'Total Precipitation and PM 2.5 Concentration in Los Angeles in 2013')
