function matrix=loadMatrixFromFile(filename)
% -------------------------------------------------------------------------
%   Description:
%      Function to load a Matrix from a source file
%
%   Input:
%       - filename : file name of the source with respect to the project
%       source folder
%
%   Output:
%       - matrix: matrix output
%
% -------------------------------------------------------------------------

    foo = load(filename);
    variables = fieldnames(foo);
    matrix = foo.(variables{1});
end % loadMatrixFromFile