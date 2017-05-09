function PVM = point_view_matrix(num_frames)
    % load the data set from disc
    images_dataset = read_images();
    % take a sample from 1 to num_frame  
    images_dataset =  images_dataset(1:num_frames);
    
    % to start get the first two images
    im1 = images_dataset{1};
    im2 = images_dataset{2};
    
    % find matches
    [matches, f1, f2, ~, ~] = find_matches(im1, im2);
    [~, ~, ~, ~, ~, best_inliers] = ransac(matches, f1, f2, 100, 1);
    
    % initialise the PVM with all the matches in img1 and img2
    PVM = [matches(1,best_inliers); matches(2,best_inliers)];
    
    % for frame 2 till num_frames -1, check of there are similar key points
    for itr = 2:(num_frames - 1)
        im1 = images_dataset{itr};
        im2 = images_dataset{itr + 1};
       
        [matches, f1, f2, ~, ~] = find_matches(im1, im2);
        [~, ~, ~, ~, ~, best_inliers] = ransac(matches, f1, f2, 100, 1);

        inliers_image1 = matches(1,best_inliers);
        inliers_image2 = matches(2,best_inliers);

        previous_inliers = PVM(size(PVM,1),:);
        next_row = [];
        
        for idx=1:size(previous_inliers, 2)
            number = previous_inliers(idx);
            if  number ~= 0
                index = find(inliers_image1 == number);
                if size(index,2) >= 1
                    next_row = [next_row, inliers_image2(index)];
                    inliers_image1(index) = 0; 
                    inliers_image2(index) = 0;
                    continue 
                end
            end
            next_row = [next_row, 0];
        end
        
        new_key_points = nonzeros(inliers_image2)';
        left_side  =[zeros(size(PVM,1)-1,length(new_key_points)); nonzeros(inliers_image1)'];
        PVM = [PVM, left_side; next_row, new_key_points];
        
    end  
    figure;
    imagesc(PVM == 0);
end


