function [s1,s2] = imagesc2(C1, C2, offset)
%% IMAGESC2 Plots two matrices similar to IMAGESC (upper and lower triangles)
%% Examples
%   figure; imagesc2(1./pascal(5), hilb(5)        ); 
%   figure; imagesc2(1./pascal(5), hilb(5),  2    ); 
%   figure; imagesc2(1./pascal(5), hilb(5), [2 0] ); 
%   figure; imagesc2(1./pascal(5), hilb(5), [2 -1]); 
%
%

if ~issymmetric(C1);            warning('First matrix is not symmetric');   end
if ~issymmetric(C2);            warning('Second matrix is not symmetric');  end
if ~all(size(C1)==size(C2));    warning('Matrices are not the same size');  end
if nargin < 3 || isempty(offset); offset = 0; end

s1 = surfsc(C1, 'mask', tril(true(size(C1)),-1), 'XData', 1-offset(1));
hold on; 
s2 = surfsc(C2, 'mask', triu(true(size(C2)),+1), 'YData', 1-offset(end));

end

