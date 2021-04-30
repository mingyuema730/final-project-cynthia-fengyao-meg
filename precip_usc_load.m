filename = 'DTLA_USC.csv';
a = readtable(filename);

lat = 34.0236;
lon = -118.2911;

%%
date = datetime(a.DATE, 'inputformat','yyyy-MM-dd''T''HH:mm:ss');
date = datenum(date);

%%
hourly_precip = a.HourlyPrecipitation; %inches to hundreds

% remove zero value
ind = find(hourly_precip == 0);
hourly_precip(ind) = NaN;



%%

figure(1); clf
scatter(date, hourly_precip)
datetick('x','mm/dd/yy')
