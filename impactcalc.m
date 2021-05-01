load LAdata.mat

%%
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

site{4}.oldmovemean = movmean(LAdata{6}.measurement(site{4}.index), 24); 
site{4}.movemean = movmean(interpPM, 24); 


%% use 2013 data 
% site 4 lat lon     33.2171    -117.3962

figure; clf 
for i = 3:6
    scatter(LAdata{6}.serial(site{i}.index), LAdata{6}.measurement(site{i}.index)) 
    hold on
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')
end

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

figure; clf
hold on 
plot(t, site{4}.movemean, 'LineWidth', 2)
scatter(date, rain, 'filled')
datetick('x',2,'keeplimits')
% ylim([0 150])
ylabel('PM2.5 ug/m^3 precip')
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
scatter(date, rain/10, 'filled')
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
scatter(date, rain/10, 'filled')
datetick('x',2,'keeplimits')
% ylim([0 150])
ylabel('Precip (mm)')
datetick('x','mmm','keeplimits')


LAdata{6}.serialround = round(LAdata{6}.serial);

%number of unique days 
serialunique = unique(LAdata{6}.serialround);

for i = 1:366 
    find(LAdata{6}.serialround == serialunique(i,1));
    %mean(LAdata{6}.measurement(site{4}.index(n:n+24)))
    
end

