function out = trimVolume(V, mask, buffer)
%% TRIMVOLUME Trim volumetric data e.g. to its bounding box (with optional buffer)
%% Examples
%   V = zeros(4,4,4); V([22,23,26,27,38,39,42,43]) = 1; figure; nexttile; plotVolume(V); nexttile; plotVolume(trimVolume(V));
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


if nargin < 2 || isempty(mask);     mask = logical(V);  end
if nargin < 3 || isempty(buffer);   buffer = 0;         end

xyz = vol2xyz(mask, logical(mask)); 

mn = max([ min(xyz)-buffer ;  1,1,1  ]);
mx = min([ max(xyz)+buffer ; size(V) ]); 

out = V(mn(1):mx(1), mn(2):mx(2), mn(3):mx(3)); 

end
