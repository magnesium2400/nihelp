function output = convertVectorToUpperTriangle(inputVector)
%CONVERTVECTORTOUPPERTRIANGLE Converts vector to upper triangle of matrix
%   Detailed explanation goes here

% calculate size of matrix based on length of vector
n = ( sqrt( 8*length(inputVector)+1 ) - 1 ) / 2; 

output = nan(n);
output( triu(true(n)) ) = inputVector;

end

