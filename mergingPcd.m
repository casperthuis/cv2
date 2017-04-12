function [] = mergingPcd()
    files =  dir('./data/*.pcd'); % get all pcd files, 
    total_file = size(files,1) /2 
    for idx =1:total_file
        soruce_name =  strcat('./data/','000000000', int2str(idx),'.mat');
        target_name =  strcat('./data/','000000000', int2str(idx),'.mat')
        [R, t] = icp(soruce_name, target_name, '.pcd')
        
        
        
    end 
end % loadPcdFromFile