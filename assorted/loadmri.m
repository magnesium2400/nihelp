function [D, map] = loadmri() %#ok<STOUT>
%% LOADMRI Generates dummy head MRI data as a 3-D array in RAS orientation
%% Examples
%   tmp = loadmri; whos tmp
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


load mri; %#ok<LOAD>
D = rotateVolume(squeeze(double(D)), 'prs', 'ras'); %#ok<NODEF>
end