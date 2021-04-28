%2008-2013
filename = '2008_2013_la_county_precip.csv';
precip = readtable(filename);
%%
date = datetime(precip.DATE, 'inputformat','yyyyMMdd HH:mm');
serialdate = datenum(date);
elevation = precip.ELEVATION;
lat = precip.LATITUDE;
lon = precip.LONGITUDE;
qpcp = precip.QPCP;
qgag = precip.QGAG;
unit = precip.Units_1;
station = precip.STATION_NAME;


precipitation = [serialdate, elevation, lat, lon, qgag];
precipitation = sortrows(precipitation, 1);

%convert into metric units

%%
% uses only data without null or negative values
indqgag = find(qgag >= 0 & qgag < 1000); 
indqpcp = find(qpcp >= 0 & qpcp < 1000); 


cleanqgag = qgag(indqgag);
cleanqpcp = qpcp(indqpcp);
cleanserialdateqgag = serialdate(indqgag);
cleandateqgag = date(indqgag);
cleanserialdateqpcp = serialdate(indqpcp);
cleandateqpcp = date(indqpcp);


pqgag = [cleanserialdateqgag, lat(indqgag), lon(indqgag), cleanqgag];
pqgag = sortrows(pqgag, 1);


%%
latgrid = unique(lat);
longrid = unique(lon);

latindex1qgag = find(lat(indqgag) == latgrid(1,1));
latindex2qgag = find(lat(indqgag) == latgrid(2,1));
latindex3qgag = find(lat(indqgag) == latgrid(3,1));
latindex4qgag = find(lat(indqgag) == latgrid(4,1));
latindex5qgag = find(lat(indqgag) == latgrid(5,1));
latindex6qgag = find(lat(indqgag) == latgrid(6,1));

%find time difference between measurements and precip difference 
precip15 = diff(pqgag(:,4));
precip15(1535,1) = 0;
timeinterval = diff(pqgag(:,1));
timeinterval(1535,1) = 0;

% clean qgag timeseries 
figure;
hold on
scatter(cleanserialdateqgag(latindex1qgag),cleanqgag(latindex1qgag))
scatter(cleanserialdateqgag(latindex2qgag),cleanqgag(latindex2qgag))
scatter(cleanserialdateqgag(latindex3qgag),cleanqgag(latindex3qgag))
scatter(cleanserialdateqgag(latindex4qgag),cleanqgag(latindex4qgag))
scatter(cleanserialdateqgag(latindex5qgag),cleanqgag(latindex5qgag))
scatter(cleanserialdateqgag(latindex6qgag),cleanqgag(latindex6qgag))
datetick

% change in precip timeseries
figure;
hold on
scatter(cleanserialdateqgag(latindex1qgag),precip15(latindex1qgag))
scatter(cleanserialdateqgag(latindex2qgag),precip15(latindex2qgag))
scatter(cleanserialdateqgag(latindex3qgag),precip15(latindex3qgag))
scatter(cleanserialdateqgag(latindex4qgag),precip15(latindex4qgag))
scatter(cleanserialdateqgag(latindex5qgag),precip15(latindex5qgag))
scatter(cleanserialdateqgag(latindex6qgag),precip15(latindex6qgag))
datetick
ylim([0 1])

%
timeintervaldt = datetime(abs(timeinterval),'ConvertFrom','datenum');
%
figure;
hold on
scatter(cleandateqgag,timeintervaldt)
%datetick('y','HH:MM:SS','keepticks')




figure;
hold on
scatter(cleanserialdateqpcp,cleanqpcp)

%diff(






