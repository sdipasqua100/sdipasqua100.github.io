function [T,DT,dt] = ww3_time_info(fname)
    % Read WAVEWATCH III NETCDF file and output times of WW-III file
    % information
    % Input(s):
    % fname: input file name
    % Output(s):
    % T: Number of output times
    % DT: Date Time Values of Outputs
    % dt: time (minutes between points)

    t = ncread(fname,"time"); % time is in days since 1990-01-01 00:00:00
    t = 60*60*24*t; % convert to seconds since 1990-01-01 00:00:00
    T = length(t);
    DT = datetime(1990,1,1,0,0,t);
    dt = (t(2) - t(1))/60;
end