load LAdata.mat

%%
figure; clf 
for i = 1:7
    scatter(LAdata{i}.serial, LAdata{i}.measurement)
    hold on
end
datetick('x',2,'keeplimits')
ylim([0 150])
ylabel('PM2.5 ug/m^3')

