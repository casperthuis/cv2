function main()

source = load('source.mat');
target = load('target.mat');
matches = zeros(3, length(source.source));

for i = 1:length(source.source)
    min_distance = Inf;
    for j = 1:length(target.target)
        distance = norm(source.source(:,i) - target.target(:,j));
        
        if min_distance > distance
           min_distance  = distance;
           matches(:,i) = target.target(:,j);
        end
        
    end
    
end
matches

svd()
end

