function [ww3_ens] = ww3_read_ensemble(fprefix,var,dim,sea_ind)
    % Given variable of interest, read ensemble of WAVEWATCH III files and 
    % output the values in an array
    % Input(s):
    % fprefix: Prefix of file name
    % var: String of variable of interest
    % dim: Dimensions of output array: (# of sea points, time points,
    % ensemble members)
    % sea_ind: logical array of sea points (1 = sea point)

    % Output(s):
    % ww3_ens: output array of ww3 values

    ww3_ens = zeros(dim); % Initialize array
    M = dim(3); % Number of ensemble members
    T = dim(2); % Time points
    seaPoints = dim(1); % Number of sea points
    sea_ind_T = repmat(sea_ind,[1,1,T]);

    for m = 1:M
        fname = fprefix + m + "_" + var + ".nc";
        ww3_tmp = ncread(fname,var); 
        ww3_ens(:,:,m) = reshape(ww3_tmp(sea_ind_T),[seaPoints,T]);
        % fprintf("Done loading ensemble member %i out of %i\n",m,M)
    end
end