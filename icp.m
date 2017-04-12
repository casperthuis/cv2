% first random intialize R is the identity matrix and t is zeroies

function icp(target_file_name, source_file_name)
    
    iters = 30; % lets hardcoded the iterations on 1000 for now, or set a trashold
    
    P = loadMatrixFromFile(target_file_name); % TODO: refactor data folder and repo folder a bit. This should be the input variables 
    Q = loadMatrixFromFile(source_file_name);
    
    n = size(P, 2);
    m = size(Q, 2);
    R =  eye(3);
    t =  zeros(3,1);
   
    current_error = inf(1);
    transformed_P = R * P + t;
    for itr = 1:iters
        transformed_P = R * P + t;
        [~, ~, Q_matches] =  matchBruteForce(transformed_P,Q);
        P_mean = mean(transformed_P,2);
        Q_mean = mean(Q_matches,2);
        
         %mindist is unused for now
        R_ = calcR(transformed_P,Q_matches, P_mean,Q_mean); % not implemented func
        R = R_ * R;
        t_ = P_mean - R * Q_mean; % not implemented func
        t = R_ * t + t_;
        error = calc_error(transformed_P, Q_matches); 
        
        if error < current_error || error == 0 || abs(current_error -error < 0.01)
            current_error =  error;
            disp(strcat('current error: ', int2str(current_error)))
        else 
            break
        end 
    end 
    
    % TODO: plot resutls 

end