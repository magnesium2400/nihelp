function output = convertVectorToUpperTriangle(inputVector, k)
%CONVERTVECTORTOUPPERTRIANGLE Converts vector to upper triangle of matrix
%   Detailed explanation goes here
% TODO : Conside whether default k should be 0 or 1

if nargin < 2
    k = 1;
end


% calculate size of matrix based on length of vector
n = ( sqrt( 8*length(inputVector)+1 ) - 1 ) / 2; 

output = zeros(n+k);
output( triu(true(n+k), k) ) = inputVector;

end

