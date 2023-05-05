function output = convertUpperTriangleToVector(inputMatrix, k)
%CONVERTUPPERTRIANGLETOVECTOR Returns upper triangle of matrix as a vector
%   Detailed explanation goes here
if nargin < 2
    k = 0;
end
output = inputMatrix( triu( true(size(inputMatrix)) , k) );
end

