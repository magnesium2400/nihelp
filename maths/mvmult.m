function out = mvmult(mat, vec, n, printInfo)
%% MVMULT Repeatedly multiplies a vector by a matrix
%% Examples
%   mvmult(magic(3), [1;2;3], 1)
%   mvmult(magic(3), [1;2;3], 2)
%   mvmult(magic(3), [1;2;3], 10)
%   mvmult(magic(30), (1:30)', 10, 1);
% 
%   m = magic(3); b = randi(20,3,1); n = randsample(5:10,1); assert(isequal( m^n*b, mvmult(m,b,n) ))
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


if nargin < 4 || isempty(printInfo); printInfo = false; end

if printInfo; t1 = tic; end

out = vec; 
for ii = 1:n
    out = mat * out; 
end

if printInfo
    t1 = toc(t1); 
    t2 = tic; mn = mat^n; out = mn*vec; t2 = toc(t2); 
    fprintf('Repeated matrix multiplication took %f seconds.\n', t1); 
    fprintf('Matrix power evaluation took %f seconds.\n', t2); 
end
