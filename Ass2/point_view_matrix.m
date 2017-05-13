function [PVM, D] = point_view_matrix(start_frame, end_frame)

    % load the data set from disc
    images_dataset = read_images();
    
    % take a sample from start_frame to end_frame  
    images_dataset =  images_dataset(start_frame:end_frame);
    
    % amount of frames we use
    num_frames = end_frame - start_frame;
    
    % to start get the first two images
    im1 = images_dataset{1};
    im2 = images_dataset{2};
    
    % find matches
    [matches, f1, f2, ~, ~] = find_matches(im1, im2);
    [~, ~, ~, ~, ~, best_inliers] = ransac(matches, f1, f2, 50, 1);
    
    % initialise the PVM with all the matches in img1 and img2, only use
    % the idx of the corrext inliers
    best_inlier_matches = matches(:,best_inliers);
    PVM = [best_inlier_matches(1,:); best_inlier_matches(2,:)];
    
    
    % also make the D matrix, which contain x and y coordinates of the inliers 
    D = [f1(1:2,best_inlier_matches(1,:));
         f2(1:2,best_inlier_matches(2,:))];
    
    % repeat the process for start_frame + 1 untill end_frame - 1
    for itr = 2:(num_frames - 1)
        im1 = images_dataset{itr};
        im2 = images_dataset{itr + 1};
       
        [matches, f1, f2, ~, ~] = find_matches(im1, im2);
        [~, ~, ~, ~, ~, best_inliers] = ransac(matches, f1, f2, 100, 1);

        inliers_image1 = matches(1,best_inliers);
        inliers_image2 = matches(2,best_inliers);
        
        
        % take the previous row of the PVM, containing the inliers of the privous frame 
        
        previous_inliers = PVM(size(PVM,1),:);
        next_row = []; % make the next row empty
       
        
        for idx=1:size(previous_inliers, 2) % loop over all previous inliers
            number = previous_inliers(idx); % get matching number
            if  number ~= 0 
                index = find(inliers_image1 == number);
                if size(index,2) >= 1 % if key point is in both images add it to the next row
                    next_row = [next_row, inliers_image2(index)];
                    inliers_image1(index) = 0; 
                    inliers_image2(index) = 0;
                    continue 
                end
            end
            % else add a 0
            next_row = [next_row, 0];
        end
        
        
        new_key_points = nonzeros(inliers_image2)'; % key found keypoints
        zero_block = [zeros(size(PVM,1)-1,length(new_key_points))]; % add zeros to early rows
        left_side  =[zero_block; nonzeros(inliers_image1)']; % new left side of the matrix are the new points and zeros
        new_row = [next_row, new_key_points]; % make new row
        
        PVM = [PVM, left_side; new_row];
        
        % now we have our new row in the PVM, now we need the X and Y
        % coordinates for that key points for matrix d
        non_zeros = nonzeros(new_row);
        non_zero_idx = [new_row ~= 0];
        
        new_row_x = zeros(1, size(new_row, 2));
        new_row_y = zeros(1, size(new_row, 2));
        
        new_row_x(non_zero_idx) = f2(1,non_zeros);
        new_row_y(non_zero_idx) = f2(2,non_zeros);      
        
        new_d_row = [new_row_x;new_row_y];
        zero_block = zeros((size(PVM,1) - 2) * 2, size(left_side,2));
        
        left_side = [zero_block ; [f1(1, nonzeros(inliers_image1));f1(2, nonzeros(inliers_image1)) ]];
        D = [D, left_side;new_d_row ];
        
        
    end 
    
    % plot the PVM, get make a boolean matrix to plot
    figure;
    imagesc(PVM == 0);

    % for testing, to see of the dense matirx is the same as the PVM matrix

    %figure;
    %imagesc(D(1:2:size(D,1),:) == 0);
end