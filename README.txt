How to test the code
1.1 
    - icp('./source.mat', './target.mat', '.mat', false, 'uniform', false) # get results without plotting animation
    - icp('./source.mat', './target.mat', '.mat', true, 'uniform', false) # get results with plotting animation

2.1
    - [ptclouds, rms] = mergingPcd(1, 10, 1);
    - [ptclouds, rms] = mergingPcd(1, 10, 2); # running this on all frames if too slow