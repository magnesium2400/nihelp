function out = meshNoise(v,f,varargin)
%% MESHNOISE Generates random, smooth, dynamic noise on a mesh
%% Examples
%   [v,f] = torusMesh(); d = meshNoise(v,f); 
%   [v,f] = torusMesh(50); d = meshNoise(v,f,'nModes',100); videofigs(100, @(n) cla(), @(n) patchvfc(v,f,d(:,n)), @(n) axis('image','vis3d'), @(n) clim(minmax(d(:))), @(n) view(3));
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

ip = inputParser;
ip.addParameter('seed', []); 
ip.addParameter('nModes', 10); 
ip.addParameter('alpha', 2); 
ip.addParameter('time', 100); 
ip.parse(varargin{:}); 
ipr = ip.Results; 

n = noise('powerlaw1', struct('seed', ipr.seed, 'sz', [ipr.nModes, ipr.time], 'alpha', ipr.alpha));
s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), ipr.nModes); 
out = s.evecs * (s.evals .* n); 

end
