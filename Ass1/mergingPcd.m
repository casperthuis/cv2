function [ptclouds, rms_list] = mergingPcd(step, sample_step, assignment)
% -------------------------------------------------------------------------
%   Description:
%     Function two merging different Point clouds to one, ex 2.1
%
%   Input:
%       - step : step between scenes
%       - sample_step: how many of the total pointcloud you want to plot?
%       - assignment: 1 or 2, depending if we are doing ass 2.1 or 2.2
%
%   Output:
%       - ptclouds: merged pcd
%
% -------------------------------------------------------------------------
 
    files = dir('./data/*.pcd'); % get all pcd files, 
    % Remove the ._ files
    fnames = files(arrayfun(@(x) x.name(1), files) ~= '.');
    % Remove the normal vectors
    fnames = fnames(arrayfun(@(x) x.name(end-4), fnames) ~= 'l');
    len = length(fnames);

   
    R_total = eye(3);
    t_total = zeros(3,1);
    ptclouds = zeros(3, 0);
    rms_list = [];
    if assignment == 1
        for i = 1:step:(len-step)
            disp(i);
            source_name = strcat('./data/', fnames(i).name);
            target_name = strcat('./data/', fnames(i+step).name);

            [R, t, rms] = icp(source_name, target_name, '.pcd', false, 'uniform', false);
            rms_list = [rms_list rms];

            R_total = R * R_total;
            t_total = R * t_total + t;

            ptCloud = loadPcdFromFile(target_name, true);
            ptCloud = R_total * ptCloud + t_total;

            ptclouds = [ptclouds ptCloud];

        end
    elseif assignment == 2
        ptclouds = loadPcdFromFile(strcat('./data/', fnames(1).name), true);
        for i = 1:step:(len-step)
            disp(i);
            target_name = strcat('./data/', fnames(i+1).name);
            [R, t, rms] = icp(ptclouds, target_name, '.pcd', false, 'uniform', true);
            rms_list = [rms_list rms];
            R_total = R * R_total;
            t_total = R * t_total + t;

            ptCloud = loadPcdFromFile(target_name, true);
            ptCloud = R * ptCloud + t;
            ptclouds = [ptclouds ptCloud];

        end
    else
        error('give  a valid assigment number 1 or 2')
    end
   
    sample = ptclouds(:,1:sample_step:size(ptclouds,2));
    pcshow(transpose(sample));
end
