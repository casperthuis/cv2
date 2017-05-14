To run the code make sure vlfeat-0.9.20 is installed on your machine. Also this implementation 
makes use of the Computer Vision System Toolbox. 

Run startup to make sure vlfeat is working properly
    - assumes that /vlfeat-0.9.20/toolbox/vl_setup is in the project dir

To test part 1) Fundamental Matrix run: epipolar(im_path1, im_path2);
    - when no input params are given, the first two images will be used

To test part 2) Chaining
    - run point_view_matrix(1, 5) to get the PVM for the first 5 frames
    - run point_view_matrix(1, 25); to get the PVM for the first 25 frames
    - run point_view_matrix(1, 49); to get the PVM on all frames


To test part 3) Structure from Motion 
    - structure_from_motion(5,10) to get the  structure from motion for frame 5 to 10 
    - structure_from_motion(start_frame, end_frame) to test any start and end frame 