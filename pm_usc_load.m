load precip_all.mat;
load precip_event.mat; 

filename = 'PM25HR_DTLA_2013.csv';
pm_raw = readtable(filename);


%% Distance between PM2.5 and precipitation data collection site
lat_precip = 34.0236;
lon_precip = -118.2911; %lat & lon for dtla precip station

lat_pm = pm_raw.latitude(1);
lon_pm = pm_raw.longitude(1); % lat & lon for dtla pm2.5 monitoring site

d = sqrt( (lat_precip - lat_pm)^2 + (lon_precip - lon_pm)^2) * 111 %distance between two sites in km

