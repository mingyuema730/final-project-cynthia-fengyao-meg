%% not used, for data set not used in final analysis
%2013
filename = 'newprecipdata.csv';
precip = readtable(filename);

date1 = precip.DATE + years(2000);
date1 = datenum(date1);
%station = precip.STATION_NAME;
elevation =precip.ELEVATION;
lat = precip.LATITUDE;
lon = precip.LONGITUDE;
% qpcp = precip.QPCP;
% qgag = precip.QGAG;
rain = precip.PRCP; %unit 1/10 mm 

%2013 index
jan2013 = datenum(2013,1,1);
jan2014 = datenum(2014,1,1);
index2013 = find( date >= jan2013 & date <= jan2014); 
rainindex = find(rain == 0);
rain(rainindex) = NaN;

figure; clf 
scatter(date1, rain, 'filled');
datetick('x','mmm','keeplimits')
ylabel('tenth of mm')

