function output = convertUpperTriangleToVector(inputMatrix, n)
%CONVERTUPPERTRIANGLETOVECTOR Returns upper triangle of matrix as a vector
%   Detailed explanation goes here
if nargin < 2
    n = 0;
end
output = inputMatrix( triu( true(size(inputMatrix)) , n) );
end

