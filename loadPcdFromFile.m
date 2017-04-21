function ptCloud=loadPcdFromFile(filename, cut)

    ptCloud = readPcd(strcat(filename));
    if cut
        ptCloud = ptCloud(ptCloud(:,3) > 10,:);
    end
    ptCloud = ptCloud(:, 1:3);
    
    
end % loadPcdFromFile