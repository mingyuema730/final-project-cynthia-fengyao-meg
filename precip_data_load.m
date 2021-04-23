%2008-2013
filename = '2008_2013_la_county_qpcp.csv';
precip = readtable(filename);

date = datetime(precip.DATE, 'inputformat','yyyyMMdd HH:mm');
date = datenum(date);
elevation =precip.ELEVATION;
lat = precip.LATITUDE;
lon = precip.LONGITUDE;
%qpcp = precip.QPCP;
qgag = precip.QGAG;

precipitation = [date, elevation, lat, lon, qgag];
precipitation = sortrows(precipitation, 1);

%convert into metric units

%%
ind = find(precipitation(:,5) == -9999 | precipitation(:,5)>1000); 
%remove data with null value or unusable data points???

precipitation(ind,5) = NaN


%%
figure (1); clf
scatter(precipitation(:,1),precipitation(:,5))
datetick('x','yyyy-MM-dd')