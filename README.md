# Effect of Intensity and Duration of Precipitation on PM2.5 Concentrations in Los Angeles, California in 2013
This repository contains the data processing and analyses materials for "Investigating the Effect of Precipitation on PM2.5 Pollution in Los Angeles, CA, USA" completed as a final project for Boston College EESC4464/EESC6664 Environmental Data Exploration and Analysis in Spring 2021. Code included is for calculating the druation and intensity of precipitation events and comparing the change in PM2.5 based on different characteristics of precipitaton events. The analysis process can be replicated for future studies. Code from failed intial attempt was also kept for future reference and demonstration of work involved in the process. 

## Data Availability Statement
The hourly precipitation data analyzed in the project is extracted from the Local Climatological Data from NOAA at the monitoring station LA Downtown USC (34.0236° N, 118.2911° W). URL: https://www.ncdc.noaa.gov/cdo-web/datatools/lcd.

Hourly PM2.5 data is obtained from the monitoring station North Main Street—Los Angeles (34.0665° N, 118.2268° W) available from California Air Resources Board. URL: https://www.arb.ca.gov/aqmis2/pickdl_hrly.php?year=2013&param=PM25HR&units=001&site=2899&o3switch=new&hours=all&ptype=aqd&mon=&day=&report=PICKDATA&statistic=DAVG&order=&btnsubmit=Update+Display&qselect=All&start_mon=1&start_day=1&mon=12&day=31&submit2=Only+if+Checked&rcheck0=2899&rows=1.

## Analysis
_Code for Analysis_
* `precip_usc_load.m` This script was used to define precipitation events based on hourly precipitation data and calculates the duration and intensity of each events.
  * `precip_all.mat` This table is a product of the function (defined as `precip` in script) and contains the time stamps in serial number, precipitation measurements in cm, and corresponding duration type based on the rule 1 = less than 1hr; 2 =  >=1hr & <2hr; 3 = >=2hr & <3hr; 4 = >=3hr
  * `precip_event.mat`This table is a product of the function (defined as `precip_event` in script) and contains the start time and end time of each precipitation event (in serial number and in string), duration of precipitation events in hours, total precipitation in cm, intensity in cm/hr, and duration type.
  
  * Developed by Mingyue (Cynthia) Ma

* `pm_usc_load.m` This script was used to import hourly PM2.5 and created exploratory graphs that compares total precipitation and PM2.5
  * Developed by Mingyue (Cynthia) Ma
  
* `impactcalc.m` This script was used to conduct t-test on the mean PM2.5 concentration before, during, and after rainfall events and produce figures that compares the change in PM2.5 between precipitation events of different duration and intensity.
The load scripts need to be run before this script. 
  * Developed by Meg Yoder
  
_Code for Initial Attempt_
* `precip_data_load.m` & `meg_precipdataload.m` Intial attempts to extract hourly precipitation data in Los Angeles county from NOAA Precipitation Hourly dataset
* `loadpm25.m` Initial attempt to extract PM2.5 data in Los Angeles county in 2013 from EPA Pre-generated data file PM2.5 FRM/FEM Mass (88101)

## Copying/Running this repository
### Local
* Make sure you have Git installed on your machine. For downloads/instructions for Windows/Mac/Linux, check out the Git website.
* In command line, navigate to where you would like the cloned directory, and run the following in your command line:

`git clone https://github.com/mingyuema730/final-project-cynthia-fengyao-meg.git`
