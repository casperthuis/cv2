function [rms] = calc_error(source, target)
% -------------------------------------------------------------------------
%   Description:
%       Function that returns rms error between two point clouds
%
%   Input:
%       - source : source cloud
%       - target : target cloud 
%
%   Output:
%       - rms: error value
%
% -------------------------------------------------------------------------
    rms = sum(power((source - target), 2));
    rms = sqrt(mean(rms));
end %calc_error 