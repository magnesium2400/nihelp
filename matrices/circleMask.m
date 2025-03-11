function out = circleMask(radius, sz, thickness)
%% CIRCLEMASK Generate an ellipsoidal mask of given axes lengths and thickness
%% Examples
%   circleMask(1)
%   circleMask(2)
%   circleMask(2,7)
%   circleMask(2,7,2)
%   circleMask([2,3])
%   circleMask([2,3],[7,9])
%   circleMask(0,5)
%   circleMask(0,5,-2)
%   figure; imagesc(circleMask(99)); axis('image'); 
%   figure; imagesc(circleMask([99,199],[],10)); axis('image'); 
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

if nargin < 2 || isempty(sz);           sz = radius*2+1;    end
if nargin < 3 || isempty(thickness);    thickness = 1;      end

out = diskMask(radius,sz) - diskMask(radius-thickness,sz); 
end
