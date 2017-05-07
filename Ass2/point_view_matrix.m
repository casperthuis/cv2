function point_view_matrix()

    images1 = read_images();
    images2 = circshift(images1,-1);
    
    im1 = images1{1};
    im2 = images2{1};
    
    [matches, f1, f2, ~, ~] = find_matches(im1, im2);
    %ransac
    [F, T1, T2, p1_norm, p2_norm] = ransac(matches, f1, f2, 100, 1);
    
    p1 = denormalisation(T1, p1_norm);
    p2 = denormalisation(T2, p2_norm);
    
    PVM = zeros(length(images1)*2, size(p1_norm,1));
    PVM(1:2,:) = round(p1)';
    
    for i = 1:size(p2,1)
        x = round(p2(i,1));
        y = round(p2(i,2));
        index = find((PVM(1, :) == x & PVM(2, :) == y));
        if any(index) == 1
            PVM(3,index) = x;
            PVM(4,index) = y;
        else
            col = zeros(length(images1)*2, 1);
            col(3) = x;
            col(4) = y;
            PVM(:,end+1) = col;
        end  
    end
    
    
    for i = 2:size(images1,2)-1
        im1 = images1{i};
        im2 = images2{i};
        
        [matches, f1, f2, ~, ~] = find_matches(im1, im2);
        
        %ransac
        [F, T1, T2, p1_norm, p2_norm] = ransac(matches, f1, f2, 100, 1);
    
        %p1 = denormalisation(T1, p1_norm);
        p2 = denormalisation(T2, p2_norm);
        
        xrows = 1:2:size(PVM,1);
        yrows = 2:2:size(PVM,1);
        
        for j = 1:size(p2,1)
            x = round(p2(j,1));
            y = round(p2(j,2));
            % I tihnk that this works
            [~,index] = find(PVM(xrows,:) == x & PVM(yrows,:) == y);
            %index = find((PVM((i-1)*2, :) == x & PVM(((i-1)*2)+1, :) == y));
            if any(index)
                PVM((i*2)+1,index) = x;
                PVM((i*2)+2,index) = y;
            else
                col = zeros(length(images1)*2, 1);
                col((i*2)+1) = x;
                col((i*2)+2) = y;
                PVM(:,end+1) = col;
            end  
        end
    end    
    
    size(PVM)
    x = PVM > 1;
    imshow(x)
end

