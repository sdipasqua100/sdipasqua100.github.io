function [lons, lats, MAPSTA, sea_ind, sea_lon_lat] = ww3_spatial_grid_info(fname)
    % Read WAVEWATCH III NETCDF file and output WW-III rectangular spatial
    % grid information
    % information
    % Input(s):
    % fname: input file name
    % Output(s):
    % lons: longitude values
    % lats: latitude values
    % MAPSTA: Sea (1) /Land (0) /Boundary (8)
    % sea_ind: logical array of sea points
    % sea_lon_lat: (lon,lat) coordinates of sea points

    lats = double(ncread(fname,"latitude")); lons = double(ncread(fname,"longitude"));
    [latGrid,lonGrid] = meshgrid(lats,lons);
    MAPSTA = ncread(fname,"MAPSTA");     
    sea_ind = MAPSTA == 1;
    sea_lon_lat = [lonGrid(sea_ind), latGrid(sea_ind)];

end