%2008-2013
filename = 'newprecipdata.csv';
precip = readtable(filename);

date = datetime(precip.DATE, 'inputformat','yyyyMMdd');
date = datenum(date);
%station = precip.STATION_NAME;
elevation =precip.ELEVATION;
lat = precip.LATITUDE;
lon = precip.LONGITUDE;
% qpcp = precip.QPCP;
% qgag = precip.QGAG;
rain = precip.PRCP; %unit 1/10 mm 

scatter(date, rain);

% precipitation = [date, elevation, lat, lon, rain];
% precipitation = sortrows(precipitation, 1);
% 
% %QGAG most likely in tenth of millimeters
% %%
% ind = find(precipitation(:,5) == -9999 | precipitation(:,5)>1000); 
% %remove data with null value or unusable data points
% 
% precipitation(ind,5) = NaN;
% 
% %%
% figure (1); clf
% scatter(precipitation(:,1),precipitation(:,5))
% datetick('x','yyyy-MM-dd')
