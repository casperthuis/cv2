% first random intialize R is the identity matrix and t is zeroies

function [R, t] = icp(source_file_name, target_file_name, source_type)
    figure;
    iters = 30; % max iters 
    
    if strcmp(source_type,'.mat')
        P = loadMatrixFromFile(source_file_name);  
        Q = loadMatrixFromFile(target_file_name);
    elseif strcmp(source_type,'.pcd')
        P = loadPcdFromFile(source_file_name);  
        Q = loadPcdFromFile(target_file_name);
    else 
        %error('unsuported file, must be .mat or .pcd');
    end
    
    n = size(P, 2);
    m = size(Q, 2);
    R =  eye(3);
    t =  zeros(3,1);
    current_error = inf(1);
    
    transformed_P = P;
    for itr = 1:iters
        [~, ~, Q_matches] =  matchBruteForce(transformed_P,Q); % miss moeten we hier maar een sample functie van maken ofzo
        
        P_mean = mean(transformed_P,2);
        Q_mean = mean(Q_matches,2);
        
        %mindist is unused for now
        R_ = calcR(transformed_P,Q_matches, P_mean,Q_mean); 
        R = R_ * R;
        
        t_ = P_mean - R * Q_mean;
        t = R_ * t + t_;
        
        error = calc_error(transformed_P, Q_matches); 
        transformed_P = R * P - t;
        
        clf;
        hold on; 
        showPointCloud(transpose(transformed_P), 'b');
        showPointCloud(transpose(Q), 'r');
        pause(0.1);
        
        if error < current_error || error == 0 || abs(current_error -error < 0.01)
            current_error =  error;
            disp(strcat('current error: ', num2str(current_error,3)))
        else 
            break
        end 
    end 
end %icp 