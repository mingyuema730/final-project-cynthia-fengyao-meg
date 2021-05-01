load precipitation.mat
%load LAdata.mat

precip_loc = unique(precipitation(:,2:4), 'rows'); %elevation, latitude, longitude of precipitation data site


%% map of collection sites for precipitation data 
figure(1); clf
usamap([33.5 35],[-120 -117])
geoshow('landareas.shp','FaceColor','#CDC5C4')
%contourf('LARIAC_Contours_250ft.shp')
geoshow('County_Boundary.shp','FaceColor','#BCF1A8')
h1 = geoshow(precip_loc(:,2), precip_loc(:,3), 'DisplayType', 'Point', 'Marker', 'o', 'Color', 'red','MarkerSize',8);
legend(h1,'Precipitation Station')

%%
latlim = [44.1645 44.4216];
lonlim = [-71.4608 -71.2267];
nasaLayers = wmsfind('nasa*elev', 'SearchField', 'Los Angeles');
ned = refine(nasaLayers, 'usgs_ned');
[Z, refmatZ] = wmsread(ned, 'Latlim', latlim, 'Lonlim', lonlim);
Z = double(Z);
%%
Contour map
% Use the data from NASA to build a contour map
%
% Build figure, map, and contour
figure
usamap(latlim, lonlim)
contourm(Z, refmatZ, 20, 'Color', 'k')