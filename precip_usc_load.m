%% read data
filename = 'DTLA_USC_2013.csv';
data_table = readtable(filename);

lat = 34.0236;
lon = -118.2911;

ind_sum = find(strcmp(data_table.REPORT_TYPE, 'SOD  ') == 1 | strcmp(data_table.REPORT_TYPE, 'SOM  ') == 1);
data_table(ind_sum, :) = [];
% remove daily and monthly summary data

%% define variables date, hourly_precip
date = datetime(data_table.DATE,'inputformat','yyyy-MM-dd''T''HH:mm:ss');
date = datenum(date); %changed date from string to number
hourly_precip = data_table.HourlyPrecipitation; %inches to hundredths

ind_zero_precip = hourly_precip == 0;
hourly_precip(ind_zero_precip) = NaN; %remove zero value


%% find start and end time of each percipitation event
%precip = table(datestr(date), hourly_precip); %table with date in string
%form and hourly precip data for easier understanding, doesn't have any
%real value for analysis

ind_precip = find(~isnan(hourly_precip));  % find the index of nonzero percipitation data

precip_event = table(0,0,'VariableNames',{'start_time','end_time'}); 
% generate a table that will store the start and end time of the
% precipitation event

precip_event.start_time(1) = date(ind_precip(1)); 
%identify the starting time and date of the first precipitation event

%% THIS FOR LOOP CAN ONLY BE RAN ONCE, MUST DROP VARIABLE BEFORE ANOTHER RUN 
%find the start and end time of each precipitation event

for i= 2:length(ind_precip)
    if ind_precip(i)- 1 == ind_precip(i-1)
        continue;
    else %ind_precip(i)-1 < ind_precip(i-1)
        precip_event.end_time(end) = date(ind_precip(i-1)); 
        % the end time must be assigned before the starttime because table
        % size will be changed after assigning start time
        precip_event.start_time(end+1) = date(ind_precip(i));        
    end
end
precip_event.end_time(end) = date(ind_precip(end)); 
 %logic of the for loop: looking at the index of all nonzero percipitation
 %data point in all hourly percipitation data, if there is a nonzero
 %measurement directly before, the data point might be a during-event
 %measurement; if there is no nonzero measurement directly before, the time
 %of this nonzero measurement is the starttime of a percipitation event
 %while the time of last non-zero measurement is the end time of a
 %percipitation event.
 
 % the result of the table should be 51*2, meaning there are 51
 % percipitation events recorded at the station
 
%% store starttime and end time as a string for easier understanding
precip_event.start_time_string = datestr(precip_event.start_time, 'mm/dd/yyyy HH:MM:SS');
precip_event.end_time_string = datestr(precip_event.end_time, 'mm/dd/yyyy HH:MM:SS');

%% categorize precipitation event based on duration 
% 1 = less than 1hr; 2 =  >=1hr & <2hr; 3 = >=2hr & <3hr; 4 = >=3hr

duration = (precip_event.end_time - precip_event.start_time) *24;
precip_event.duration = duration;

precip = table(date,hourly_precip, NaN(length(date),1),'VariableNames',{'date','precip','duration_type'}); %create a matrix to store date, 


for i = 1:length(duration)
    if duration(i) < 1 % less than an hour
        precip_event.duration_type(i) = 1;
        ind_start_time = find(precip.date == precip_event.start_time(i));
        ind_end_time = find(precip.date == precip_event.end_time(i));
        precip.duration_type(ind_start_time:ind_end_time) = 1;
    elseif duration(i) >=1 && duration(i) <2 % between 1-2 hours
        precip_event.duration_type(i) = 2;
        ind_start_time = find(precip.date == precip_event.start_time(i));
        ind_end_time = find(precip.date == precip_event.end_time(i));
        precip.duration_type(ind_start_time:ind_end_time) = 2;
    elseif duration(i) >=2 && duration(i) <3 % between 2-3 hours
        precip_event.duration_type(i) = 3;
        ind_start_time = find(precip.date == precip_event.start_time(i));
        ind_end_time = find(precip.date == precip_event.end_time(i));
        precip.duration_type(ind_start_time:ind_end_time) = 3;
    else % greater than 3 hours
        precip_event.duration_type(i) = 4;
        ind_start_time = find(precip.date == precip_event.start_time(i));
        ind_end_time = find(precip.date == precip_event.end_time(i));
        precip.duration_type(ind_start_time:ind_end_time) = 4;
    end
end

%% Create time-series scatter grouped by duration type
XTick = [datenum('12-01-2012 12:00') datenum('06-01-2013 12:00') datenum('01-01-2014 12:00')];

figure (1); clf
color = lines(4);% generate colors
gscatter(precip.date, precip.precip, precip.duration_type,color(1:4,:),'.',[6 8 10 12])
set(gca,'xtick',XTick)
datetick('x','mm-dd HH:MM','keepticks')
legend({'<1 hr','1hr <= t < 2hr','2hr <= t <3hr','>3hr'})

% %% example of the longest precipitation event in DTLA in 2013 
% ind_dur_max = find(duration == max(duration));
% ind_max_start = find(precip.date == precip_time_range.start_time(ind_dur_max));
% ind_max_end = find(precip.date == precip_time_range.end_time(ind_dur_max));
% 
% event1 = precip(ind_max_start:ind_max_end,:);
% 
% %exploratory graph
% figure(2); clf
% plot(event1.date,event1.precip,'-o')
% datetick('x','HH:MM','keepticks')
% title('Precipitation Event from Jan 23 to 24, 2013 in Downtown LA')

%% find total volumn and intensity of each precipitation event
for i = 1:length(duration)
    ind_start_time = find(precip.date == precip_event.start_time(i));
    ind_end_time = find(precip.date == precip_event.end_time(i));
    precip_event.total_precip(i) = sum(precip.precip(ind_start_time:ind_end_time));
    
    if duration(i) == 0
    precip_event.intensity(i) = precip_event.total_precip(i);
    else
    precip_event.intensity(i) = precip_event.total_precip(i) ./ precip_event.duration(i);
    end
    
end

%% Total Precipitation in 2013 in DTLA
figure (3); clf
bar([precip_event.start_time precip_event.end_time], precip_event.total_precip,'FaceColor','b','EdgeColor','b')
datetick('x','mm-dd')


%% all precipitation events (started) in January 2013 in DTLA
ind_jan_event = find(precip_event.start_time > datenum('01-01-2013 00:00:00') & precip_event.start_time < datenum('02-01-2013 00:00:00'));

figure(4); clf
bar([precip_event.start_time(ind_jan_event) precip_event.end_time(ind_jan_event)], precip_event.total_precip(ind_jan_event),'FaceColor','b','EdgeColor','b','barwidth',20)
%h1 = axes
set(gca, 'YDir', 'reverse')
xlim([datenum('01-01-2013 00:00:00') datenum('02-01-2013 00:00:00')])
datetick('x','mm-dd')
