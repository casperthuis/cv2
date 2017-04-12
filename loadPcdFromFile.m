function ptCloud=loadPcdFromFile(filename)

    ptCloud = pcread(filename);
    ptCloud = ptCloud.Location.';
end % loadPcdFromFile