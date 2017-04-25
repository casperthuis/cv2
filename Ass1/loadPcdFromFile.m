function ptCloud=loadPcdFromFile(filename, cut)
% -------------------------------------------------------------------------
%   Description:
%      Function to load a Point Cloud from a source file
%
%   Input:
%       - filename : file name of the source with respect to the project
%       source folder
%       - cut: remove 4th dimension from data, filter outliers
%
%   Output:
%       - ptCloud: subsampled point cloud
%
% -------------------------------------------------------------------------
    ptCloud = readPcd(strcat(filename));
    if cut
        ptCloud = ptCloud(ptCloud(:,3) < 1.6,:);
    end
    ptCloud = ptCloud(:, 1:3)';
end % loadPcdFromFile