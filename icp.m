function [R, t] = icp(source_file_name, target_file_name, source_type ,plotting, sampling_type)
% -------------------------------------------------------------------------
%   Description:
%     Implementation of the ICP algorithm.
%
%   Input:
%       - source_file_name : file name of the source with respect to the project
%       source folder
%       - target_file_name : file name of the target with respect to the project
%       source folder
%       - source_type: type of the source file: matrix or point cloud
%       - plotting: if true, the results will be plotted
%       - sampling_type: how to subsample the data
%
%   Output:
%       - R: rotation matrix
%       - t: transformation vector
%
% -------------------------------------------------------------------------

    if plotting
        figure;
    end
    
    if ~strcmp(sampling_type, 'random') && ~strcmp(sampling_type, 'uniform') && ~strcmp(sampling_type, 'all')
        error('give a valid sampling type: all, random or uniform');
    end 
    
    if strcmp(source_type,'.mat')
        P = loadMatrixFromFile(source_file_name);  
        Q = loadMatrixFromFile(target_file_name);
    elseif strcmp(source_type,'.pcd')
        P = loadPcdFromFile(source_file_name);  
        Q = loadPcdFromFile(target_file_name);
    else 
        error('unsuported file, must be .mat or .pcd');
    end
    
    iters = 30; % max iters,  maybe this should be a input var 
    n = size(P, 2);
    m = size(Q, 2);
    R = eye(3);
    t = zeros(3,1);
    current_rms = inf(1);
    time = cputime;
    transformed_P = P;
    for itr = 1:iters
        percentage = 0.1; % maybe this should be a input var
        if ~strcmp(sampling_type, 'all')
            transformed_P = samplePoints(transformed_P, sampling_type, percentage);
        end  
        
        [~, ~, Q_matches] =  matchPoints(transformed_P,Q, 'brute_force'); 
        
        P_mean = mean(transformed_P,2);
        Q_mean = mean(Q_matches,2);
        
        R_ = calcR(transformed_P, Q_matches, P_mean,Q_mean); 
        R = R_ * R;
        
        t_ = P_mean - R * Q_mean;
        t = R_ * t + t_;
        
        
        rms = calc_error(transformed_P, Q_matches); 
        transformed_P = R * P - t;
        
        if plotting
            clf;
            hold on; 
            showPointCloud(transpose(transformed_P), 'b');
            showPointCloud(transpose(Q), 'r');
            pause(0.1);
        end
        if rms < current_rms || rms == 0 || abs(current_rms - rms < 0.01)
            current_rms =  rms;
            if  plotting
                disp(strcat('current error: ', num2str(current_rms,3)));
            end 
        else 
            break
        end 
    end
    disp(strcat('final error: ', num2str(current_rms,3)));
    disp(strcat('cpu time to iterations: ', num2str(cputime-time)))
end %icp 