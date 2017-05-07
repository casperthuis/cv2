function images = read_images()
    DATA_DIR = 'House/';
    files = dir(DATA_DIR);
    files = files(arrayfun(@(x) x.name(end), files) == 'g');
    images = cell(1,size(files,1));
    for i=1:size(files,1)
        img_path = strcat(DATA_DIR, files(i).name);
        
        if exist(img_path,'file') ~= 2
            disp('Image path incorrect: check read_image.m.');
            return;
        end    
        images{i} = imread(img_path);
    end    
end