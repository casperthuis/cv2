% Student Names: Casper Thuis and Maurits Bleeker
% Student Numbers: 10341943 and 
% Function: ransac; Takes a random set of P matches, gets the matched points
% from frames1 and frames2 (the SIFT coordinates from two images), and uses
% these points to create a transformation matrix. This is repeated N times,
% counting the number of inliers every transformation matrix produces when
% transforming the points from frames1 compared with the actual coordinates 
% in frames2.

function [transformation, final_sample, high_score] = ransac(frames1, frames2, matches, N, P)

    % Variables to be found by RANSAC
    transformation = [];
    high_score = 0;

    
    
    % RANSAC
    for i = 1:N
        index = randsample(1:length(matches), P);
        selection = matches(:,index);
        
        % Get pixel locations of matches SIFT descriptors
        xysample1 = frames1(1:2, selection(:,1))'
        xysample2 = frames2(1:2, selection(:,2))'
       
        % Construct matrix A
        A = [];
        OddRows = [xysample1, repmat([0, 0, 1, 0], P, 1)];
        EvenRows = [repmat([0, 0], P, 1), xysample1, repmat([0, 1], P, 1)];
        A(1:2:2*P,:) = OddRows;
        A(2:2:2*P,:) = EvenRows;
        
        % Construct vector b
        b = [];
        b(1:2:2*P,:) = xysample2(:,1);
        b(2:2:2*P,:) = xysample2(:,2);
        
        % Compute affine transformation x
        x =  pinv(A)*b;
        
        % Transfrom points from first image with affine transformation x
        xy1 = frames1(1:2,matches(:,1)')';
        xy2 = frames2(1:2,matches(:,2)')';
        OddRows = [xy1, repmat([0, 0, 1, 0], size(xy1,1), 1)];
        EvenRows = [repmat([0, 0], size(xy1,1), 1), xy1, repmat([0, 1], size(xy1,1), 1)];
        A(1:2:2*size(xy1,1),:) = OddRows;
        A(2:2:2*size(xy1,1),:) = EvenRows;
        xy2trans_temp = A * x;
        xy2trans = [];
        xy2trans(:,1) = xy2trans_temp(1:2:2*size(xy1,1),:);
        xy2trans(:,2) = xy2trans_temp(2:2:2*size(xy1,1),:);

        % Compare points in the second image after transformation to actual found points
        diff = xy2 - xy2trans;
        squared = diff .^ 2;
        sum = squared(:,1) + squared(:,2);
        distance = sqrt(sum);
        score = nnz(distance < 10);  
     
        % Save scores 
        if score > high_score
            high_score = score;
            transformation = x;
            final_sample = [xysample1, xysample2]; 
        end     
    end
    
end