function [dv] = GC_distance(model_grid,obs_grid)
% Compute the distance between latitude and longitude coordinates
    eRad = 6371;
    N = size(model_grid,1); L = size(obs_grid,1);
    dv = zeros(N,L);
    for j = 1:L
        olat_rad = obs_grid(j,2)*pi/180; olon_rad = obs_grid(j,1)*pi/180;
        for k = 1:N
            mlat_rad = model_grid(k,2)*pi/180; mlon_rad = model_grid(k,1)*pi/180;
            d = sin((mlat_rad-olat_rad)/2)^2+cos(mlat_rad)*cos(olat_rad)*sin((mlon_rad-olon_rad)/2)^2;
            dv(k,j) = abs(2*eRad*asin(sqrt(d)));
        end
    end
end
