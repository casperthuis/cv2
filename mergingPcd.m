function [ptclouds] = mergingPcd(step)
    files = dir('./data/*.pcd'); % get all pcd files, 
    % Remove the ._ files
    fnames = files(arrayfun(@(x) x.name(1), files) ~= '.');
    % Remove the normal vectors
    fnames = fnames(arrayfun(@(x) x.name(end-4), fnames) ~= 'l');
    len = length(fnames);

    ptclouds = zeros(3, 0);
    
    R_total = eye(3);
    t_total = zeros(3,1);

    for i = 1:step:(len-step)
        source_name = strcat('./data/', fnames(i).name);
        target_name = strcat('./data/', fnames(i+1).name);
        [R, t] = icp(source_name, target_name, '.pcd', false, 'uniform');

        
        R_total = R_total * R;
        t_total = t + t_total;
       
        ptCloud = loadPcdFromFile(source_name, true);
        ptCloud = R_total * ptCloud - t_total;
        
        ptclouds = [ptclouds ptCloud];
        
    end
    
    pcshow(transpose(ptclouds), 'b');

end




% loadPcdFromFile

% 2.1
% 
% step = 1 # Do experiments with 1, 2, 4, 10
% for frame_id in range(0, nframes - step, step):
%     estimate R, t from frame[frame_id] to frame[frame_id + step]
% 
% point_cloud = points from frame[0]
% 
% Ra = eye(3, 3)
% ta = zeros(3, 1)
% 
% for frame_id in range(0, frames - step, step):
%     # accumulate R, t to compute Ra, ta from frame[0] to frame[frame_id]
%     Ra = dot(R, Ra)
%     ta = dot(R, ta) + t
% 
%     merge points from frame[frame_id] with point_cloud using Ra, ta
% 
% 2.2
% 
% point_cloud = frame[0]
% 
% rotation = eye(3, 3)
% translation = zeros(3, 1)
% 
% for frame_id in range(1, nframes):
%     estimate R, t from frame[0] to frame[frame_id]
% 
%     # You can try to use a coordinate system of frame[0] or a coordinate system
%     # of another frame instead and investigate an influence of that choice.
%     # Rotation and translation are accumulated in the same way.
%     transform point_cloud to the coordinate system of points from frame[frame_id]
%     merge points from frame[frame_id] with point_cloud