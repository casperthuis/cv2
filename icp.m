
function [R_total, t_total, transformed_P] = icp(source_file_name, target_file_name, source_type ,plotting, sampling_type, ass22)
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
%       - ass22: when doing assignment 2.2, use the source_file_name, which
%       is a matrix in this case, as input. Do not load the file
%
%   Output:
%       - R: rotation matrix
%       - t: transformation vector
%
% -------------------------------------------------------------------------

    if plotting
        figure;
    end
    
    if ~strcmp(sampling_type, 'random') && ~strcmp(sampling_type, 'uniform') && ~strcmp(sampling_type, 'all') && ~strcmp(sampling_type, 'informative')
        error('give a valid sampling type: all, random or uniform');
    end 
    
    if strcmp(source_type,'.mat')
        if ~ass22
            P = loadMatrixFromFile(source_file_name);
        else 
            P = source_file_name
        end 
        Q = loadMatrixFromFile(target_file_name);
    elseif strcmp(source_type,'.pcd')
<<<<<<< HEAD
        P = loadPcdFromFile(source_file_name, true);  
=======
       if ~ass22
            P = loadPcdFromFile(source_file_name, true);
        else 
            P = source_file_name;
       end  
>>>>>>> d365287a3c9a04519dc832fd510d5455f121d5f8
        Q = loadPcdFromFile(target_file_name, true);
    else 
        error('unsuported file, must be .mat or .pcd');
    end
    
    n = size(P, 2);
    m = size(Q, 2);
    
    R = eye(3);
    t = zeros(3,1);
    current_rms = inf(1);
    time = cputime;
    
    transformed_Q = Q;
    
    R_total = R;
    t_total = t;
    P_all = P; % copy of P to sample using for sampling
    
    itr = 0;
    
    while true
        itr = itr + 1;
        percentage = 0.1; 
        
        if ~strcmp(sampling_type, 'all')
            P = samplePoints(P_all, sampling_type, percentage);
        end
        
        [~, mindist, Q_matches] = matchPoints(P ,transformed_Q, 'kd_tree');
        
        rms = calc_error(P, Q_matches); 
        
        if plotting
            clf;
            hold on; 
            %plot3(transformed_P(  ))
            pcshow(transpose(P_all), 'b');
            pcshow(transpose(transformed_Q), 'r');
            pause(0.1);
        end
        if abs(rms - current_rms) > 10^(-6) 
            current_rms =  rms;
            
            if  plotting
                disp(strcat('current error: ', num2str(current_rms,3)));
            end
            
            P_mean = mean(P,2);
            Q_mean = mean(Q_matches,2);

            R = calcR(P, Q_matches, P_mean,Q_mean); 
            t = P_mean - R * Q_mean;

            transformed_Q = R * transformed_Q + t;

            R_total = R * R_total;
            t_total = R * t_total + t;
        else 
            break
        end 
    end
    disp(itr);
    disp(strcat('final error: ', num2str(current_rms,3)));
    disp(strcat('cpu time to iterations: ', num2str(cputime-time)))
end %icp 