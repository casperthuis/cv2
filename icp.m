function [R, t] = icp(source_file_name, target_file_name, source_type ,plotting, sampling_type)
    if plotting
        figure;
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
    iters = 30; % max iters 
    n = size(P, 2);
    m = size(Q, 2);
    R =  eye(3);
    t =  zeros(3,1);
    current_rms = inf(1);
    
    transformed_P = P;
    for itr = 1:iters
        if strcmp(sampling_type,'brute_force')
            [~, ~, Q_matches] =  matchBruteForce(transformed_P,Q);
        else 
            error('choose a valid sampling type: brute_force,')
        end    
        
        P_mean = mean(transformed_P,2);
        Q_mean = mean(Q_matches,2);
        
        R_ = calcR(transformed_P,Q_matches, P_mean,Q_mean); 
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
            disp(strcat('current error: ', num2str(current_rms,3)))
        else 
            break
        end 
    end 
end %icp 