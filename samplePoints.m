function [ Pcd,Pcd2 ] = samplePoints(Pcd,sampling, percentage, varargin)
% -------------------------------------------------------------------------
%   Description:
%       A function to sample datapoints from a point cloud. There are two
%       options: uniform (every n'th sample or random)
%
%   Input:
%       - Pcd : a matrix or point cloud
%       - sampling: sampling method, uniform or random
%       - percentage: percentage of the data point you want to sample
%       - varargin: variable input args, could be a second point cloud of
%       you want to point clouds with the same samping (for example P and Q)
%
%   Output:
%       - Pcd: subsampled point cloud
%       - Pcd2: optional, second point cloud with same index sampling
%
% -------------------------------------------------------------------------


    n = size(Pcd,2);
    k = round(n*percentage);
    
    if strcmp('uniform', sampling)
        idxs = floor(linspace(1,n, percentage * n));
        Pcd = Pcd(:,idxs);
        if ~isempty(varargin)
            Pcd2 = varargin{1}(:,idxs);
        end
    elseif strcmp('random', sampling)
        idxs = randi([1 n],1,k);
        Pcd = Pcd(:,idxs);
        if ~isempty(varargin)
            Pcd2 = varargin{1}(:,idxs);
        end
    else 
        error('Give a valid sampling method')
    end
end

