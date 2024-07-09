function [giftiModes, s] = calc_gifti_eigenmode(giftipath, k, sigma, lump)
%% CALC_GIFTI_EIGENMODE Calculate surface eigenmodes
%% Dependencies
% GIfTI Library found here: github.com/gllmflndn/gifti (download and add to path)
% 
%
%% Inputs
%  `giftipath - path to gifti (string | char array)`
%
%  `k - number of eigenmodes (positive integer scalar)`
%
%  `sigma - approximation of first eigenvalue (scalar)`
%
%  `lump - flag to lump mass matrix (false (default) | true)`
% 
% 
%% Outputs
%  `giftiModes - array of eigenmodes (matrix)`
%
%  `s - struct containing eigenmodes, mass matrix, verts, etc. (struct)`
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


if nargin < 2 || isempty(k);        k = 6;          end
if nargin < 3 || isempty(sigma);    sigma = -0.01;  end
if nargin < 4 || isempty(lump);     lump = false;   end

g = gifti(convertStringsToChars(giftipath)); 

s = calc_geometric_eigenmode(...
    struct('vertices', g.vertices, 'faces', g.faces), ...
    k, sigma, lump); 

giftiModes = s.evecs; 

end

