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

for i = 1:6
    site{i}.movemean = movmean(LAdata{6}.measurement(site{i}.index), 24); 
end 

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

figure; clf 
plot(LAdata{6}.serial(site{4}.index), site{4}.movemean, 'LineWidth', 2)
datetick('x','mmm','keeplimits')


figure; clf
hold on 
plot(LAdata{6}.serial(site{4}.index), site{4}.movemean, 'LineWidth', 2)
scatter(date, rain, 'filled')
datetick('x',2,'keeplimits')
% ylim([0 150])
ylabel('PM2.5 ug/m^3 precip')
datetick('x','mmm','keeplimits')

site{4}.changeinpm = diff(site{4}.movemean);
site{4}.changeinpm(8163,1) = NaN;

LAdata{6}.serialround = round(LAdata{6}.serial);

figure; clf
hold on 
plot(LAdata{6}.serial(site{4}.index), site{4}.changeinpm, 'LineWidth', 2)
scatter(date, rain, 'filled')
datetick('x',2,'keeplimits')
% ylim([0 150])
ylabel('PM2.5 ug/m^3 precip')
datetick('x','mmm','keeplimits')

serialunique = unique(LAdata{6}.serialround);

for i = 1:366 
    find(LAdata{6}.serialround == serialunique(i,1));
    %mean(LAdata{6}.measurement(site{4}.index(n:n+24)))
    
end

