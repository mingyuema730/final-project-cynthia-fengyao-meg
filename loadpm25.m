%% not used, for data set not used in final analysis
%this takes a while, so just do it once and then save the data file and reload that later 
%just load LAdata.mat file (better to not run)
readtable('hourly_88101_2008.csv');
data.countycode = table2array(ans(:,2));
data.lat = table2array(ans(:,6));
data.lon = table2array(ans(:,7));
data.dategmt = table2array(ans(:,12));
data.timegmt = table2array(ans(:,13));
data.measurement = table2array(ans(:,14)); %'Micrograms/cubic meter (LC)'
data.state = table2array(ans(:,22));
data.county = table2array(ans(:,23));
data.site = table2array(ans(:,3));
%data is too big to save, have to index LA first and then save LAdata 

%indexing just LA data 

LAdata{1}.index = find(data.countycode == 73); 
LAdata{1}.lat = data.lat(LAdata{1}.index);
LAdata{1}.lon = data.lon(LAdata{1}.index);
LAdata{1}.dategmt = data.dategmt(LAdata{1}.index);
LAdata{1}.timegmt = data.timegmt(LAdata{1}.index);
LAdata{1}.measurement = data.measurement(LAdata{1}.index);
LAdata{1}.site = data.site(LAdata{1}.index);


%2009
readtable('hourly_88101_2009.csv');
data.countycode = table2array(ans(:,2));
data.lat = table2array(ans(:,6));
data.lon = table2array(ans(:,7));
data.dategmt = table2array(ans(:,12));
data.timegmt = table2array(ans(:,13));
data.measurement = table2array(ans(:,14)); %'Micrograms/cubic meter (LC)'
data.state = table2array(ans(:,22));
data.county = table2array(ans(:,23));
data.site = table2array(ans(:,3));


LAdata{2}.index = (data.countycode == 73); 
LAdata{2}.lat = data.lat(LAdata{2}.index);
LAdata{2}.lon = data.lon(LAdata{2}.index);
LAdata{2}.dategmt = data.dategmt(LAdata{2}.index);
LAdata{2}.timegmt = data.timegmt(LAdata{2}.index);
LAdata{2}.measurement = data.measurement(LAdata{2}.index);
LAdata{2}.site = data.site(LAdata{2}.index);


%2010
readtable('hourly_88101_2010.csv');
data.countycode = table2array(ans(:,2));
data.lat = table2array(ans(:,6));
data.lon = table2array(ans(:,7));
data.dategmt = table2array(ans(:,12));
data.timegmt = table2array(ans(:,13));
data.measurement = table2array(ans(:,14)); %'Micrograms/cubic meter (LC)'
data.state = table2array(ans(:,22));
data.county = table2array(ans(:,23));
data.site = table2array(ans(:,3));

LAdata{3}.index = (data.countycode == 73); 
LAdata{3}.lat = data.lat(LAdata{3}.index);
LAdata{3}.lon = data.lon(LAdata{3}.index);
LAdata{3}.dategmt = data.dategmt(LAdata{3}.index);
LAdata{3}.timegmt = data.timegmt(LAdata{3}.index);
LAdata{3}.measurement = data.measurement(LAdata{3}.index);
LAdata{3}.site = data.site(LAdata{3}.index);


%2011
readtable('hourly_88101_2011.csv');
data.countycode = table2array(ans(:,2));
data.lat = table2array(ans(:,6));
data.lon = table2array(ans(:,7));
data.dategmt = table2array(ans(:,12));
data.timegmt = table2array(ans(:,13));
data.measurement = table2array(ans(:,14)); %'Micrograms/cubic meter (LC)'
data.state = table2array(ans(:,22));
data.county = table2array(ans(:,23));
data.site = table2array(ans(:,3));


LAdata{4}.index = (data.countycode == 73); 
LAdata{4}.lat = data.lat(LAdata{4}.index);
LAdata{4}.lon = data.lon(LAdata{4}.index);
LAdata{4}.dategmt = data.dategmt(LAdata{4}.index);
LAdata{4}.timegmt = data.timegmt(LAdata{4}.index);
LAdata{4}.measurement = data.measurement(LAdata{4}.index);
LAdata{4}.site = data.site(LAdata{4}.index);


%2012
readtable('hourly_88101_2012.csv');
data.countycode = table2array(ans(:,2));
data.lat = table2array(ans(:,6));
data.lon = table2array(ans(:,7));
data.dategmt = table2array(ans(:,12));
data.timegmt = table2array(ans(:,13));
data.measurement = table2array(ans(:,14)); %'Micrograms/cubic meter (LC)'
data.state = table2array(ans(:,22));
data.county = table2array(ans(:,23));
data.site = table2array(ans(:,3));


LAdata{5}.index = (data.countycode == 73); 
LAdata{5}.lat = data.lat(LAdata{5}.index);
LAdata{5}.lon = data.lon(LAdata{5}.index);
LAdata{5}.dategmt = data.dategmt(LAdata{5}.index);
LAdata{5}.timegmt = data.timegmt(LAdata{5}.index);
LAdata{5}.measurement = data.measurement(LAdata{5}.index);
LAdata{5}.site = data.site(LAdata{5}.index);


%2013
readtable('hourly_88101_2013.csv');
data.countycode = table2array(ans(:,2));
data.lat = table2array(ans(:,6));
data.lon = table2array(ans(:,7));
data.dategmt = table2array(ans(:,12));
data.timegmt = table2array(ans(:,13));
data.measurement = table2array(ans(:,14)); %'Micrograms/cubic meter (LC)'
data.state = table2array(ans(:,22));
data.county = table2array(ans(:,23));
data.site = table2array(ans(:,3));

LAdata{6}.index = (data.countycode == 73); 
LAdata{6}.lat = data.lat(LAdata{6}.index);
LAdata{6}.lon = data.lon(LAdata{6}.index);
LAdata{6}.dategmt = data.dategmt(LAdata{6}.index);
LAdata{6}.timegmt = data.timegmt(LAdata{6}.index);
LAdata{6}.measurement = data.measurement(LAdata{6}.index);
LAdata{6}.site = data.site(LAdata{6}.index);


%2014
readtable('hourly_88101_2014.csv');
data.countycode = table2array(ans(:,2));
data.lat = table2array(ans(:,6));
data.lon = table2array(ans(:,7));
data.dategmt = table2array(ans(:,12));
data.timegmt = table2array(ans(:,13));
data.measurement = table2array(ans(:,14)); %'Micrograms/cubic meter (LC)'
data.state = table2array(ans(:,22));
data.county = table2array(ans(:,23));
data.site = table2array(ans(:,3));

LAdata{7}.index = (data.countycode == 73); 
LAdata{7}.lat = data.lat(LAdata{7}.index);
LAdata{7}.lon = data.lon(LAdata{7}.index);
LAdata{7}.dategmt = data.dategmt(LAdata{7}.index);
LAdata{7}.timegmt = data.timegmt(LAdata{7}.index);
LAdata{7}.measurement = data.measurement(LAdata{7}.index);
LAdata{7}.site = data.site(LAdata{7}.index);


for i = 1:6 
    LAdata{i}.serial = datenum(LAdata{i}.dategmt) + datenum(LAdata{i}.timegmt) - datenum('00:00','HH:MM'); 
end 

LAdata{6}.serial = datenum(LAdata{6}.dategmt) + datenum(LAdata{6}.timegmt) - datenum('00:00','HH:MM'); 
save('LAdata'); 



