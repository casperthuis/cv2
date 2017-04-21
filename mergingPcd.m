function [] = mergingPcd(size)
    files =  dir('./data/*.pcd'); % get all pcd files, 
    total_file = size(files,1) /2 
    for idx =1:size:total_file
        soruce_name =  strcat('./data/','000000000', int2str(idx),'.mat');
        target_name =  strcat('./data/','000000000', int2str(idx),'.mat');
        [R, t] = icp(soruce_name, target_name, '.pcd', false, 'uniform')
    end 
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