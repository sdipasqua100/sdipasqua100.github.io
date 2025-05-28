function [X_interp] = spatial_interpolation(X,Lons,Lats,lonLat, sea_ind, interp_lonLat)
    % Interpolate X array in space
    % First try bilinear interpolation and if NaN, then nearest neighbor
    % Input(s):
    % X: original vector
    % Lons: longitudes of original grid
    % Lats: latitudes of original grid
    % lonLat: (lon,lat) coordinate pairs of sea points on original grid
    % interp_lonLat: (lon,lat) coordinate pairs to interpolate onto
    % coordinate pairs to interpolate onto must be in within region described by Lons x Lats 

    % Output(s):
    % X_interp: interpolated array

    P = size(interp_lonLat,1); T = size(X,3);
    X_interp = zeros(P,T); % Initialize interpolation matrix
    sea_ind_T = repmat(sea_ind,[1,1,T]);
    P_NR = size(lonLat,1);
    X_sea = reshape(X(sea_ind_T),[P_NR,T]);

    lonInd = zeros(1,2); latInd = zeros(1,2); interp_coeff = zeros(2);
    [latGrid,lonGrid] = meshgrid(Lats,Lons);
    for p = 1:P
        x = interp_lonLat(p,1); y = interp_lonLat(p,2);

        lonInd(1) = find(Lons<x,1,"last"); latInd(1) = find(Lats<y,1,"last");
        lonInd(2) = lonInd(1) + 1; 
        latInd(2) = latInd(1) + 1; 

        x1 = Lons(lonInd(1)); x2 = Lons(lonInd(2));
        y1 = Lats(latInd(1)); y2 = Lats(latInd(2));

        dy = y2 - y1; dx = x2 -x1;  dydx = dy*dx;
        interp_coeff(1,1) = (y2 - y) * (x2 - x)/ dydx;
        interp_coeff(1,2) = (y - y1) * (x2 - x)/ dydx;
        interp_coeff(2,1) = (y2 - y) * (x - x1)/ dydx;
        interp_coeff(2,2) = (y - y1) * (x - x1)/ dydx;

        X_interp(p,:) = reshape(sum(interp_coeff.*X(lonInd,latInd,:),[1,2]),[1,T]);

        if sum(isnan(X_interp(p,:))) > 0
            [~,min_ind] = min(GC_distance(lonLat,interp_lonLat(p,:)));
            X_interp(p,:) = X_sea(min_ind,:);
        end
        if mod(p,1e3) == 0
            fprintf("Done interpolating onto point %i out of %i\n",p,P)
        end
    end
end