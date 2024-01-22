function V = rotateVolume(V, srcOrientation, tgtOrientation)
%% ROTATEVOLUME Rotate 3-D volume in anatomical space 
%% Syntax 
%  V = rotateVolume(V, srcOrientation, tgtOrientation)
% 
% 
%% Description 
% `V = rotateVolume(V, srcOrientation, tgtOrientation)` rotates the volume V
% from the space srcOrientation to the space tgtOrientation.
% 
% 
%% Examples 
%   D = squeeze(load('mri').D); E = rotateVolume(D, 'prs', 'ras'); 
%   V = (1:10).'+(1:5)+permute(1:20,[1,3,2])-2; W = rotateVolume(V, 'als', 'pir'); 
%   D = squeeze(load('mri').D); E = rotateVolume(D, 'prs', 'ras'); figure; nexttile; plotVolume(D); nexttile; plotVolume(E);  
%   D = (loadmri+(1:128).').*logical(loadmri); figure; nexttile; plotVolume(D); nexttile; plotVolume(rotateVolume(D, 'ras', 'ipl')); 
% 
% 
%% Input Arguments 
%  V - Volume to be rotated (3-D array)
%  
%  srcOrientation - Direction of positive x,y,z coordinates in original space (string scalar | character vector) 
%  A string or character vector with three letters, where each letter represents
%  the direction of the positive x/y/z axis respectively. Use the letters
%  p,a,i,s,r,l to denote posterior, anterior, inferior, superior, right, and
%  left. For example, the data given by `squeeze(load('mri').D)` would have
%  srcOrientation 'prs'; radiological and neurological volumes would have
%  srcOrientation 'las' and 'ras'.
% 
% 
%  tgtOrientation - Direction of positive x,y,z coordinates in target space (string scalar | character vector) 
%  
% 
%% Output Arguments 
%  V - Rotated volume (3-D array)
% 
% 
%% See also 
%  PERMUTE, FLIP, PLOTVOLUME, VOLSHOW
%  Imaging conventions: https://nipy.org/nibabel/neuro_radio_conventions.html
% 
%% Authors 
% Mehul Gajwani, Monash University, 2024
% 
% 
%% ENDPUBLISH

srcOrientation = convertStringsToChars(lower(srcOrientation));
tgtOrientation = convertStringsToChars(lower(tgtOrientation));


%% Permute axes
% replace post/ant, inf/sup, right/left with coronal, transverse, sagittal
% in order to get permuting order
srcD = replace(srcOrientation, {'p','a','i','s','r','l'}, {'C','C','T','T','S','S'});
tgtD = replace(tgtOrientation, {'p','a','i','s','r','l'}, {'C','C','T','T','S','S'});

t = arrayfun(@(x) strfind(srcD, x), tgtD); % permutation order
V = permute(V, t);
pSwaps = nnz(t == [1,2,3]) == 1; % parity of number of swaps


%% Do flips as needed
f = arrayfun(@(x) ~contains(srcOrientation, x), tgtOrientation);
for ii = find(f); V = flip(V, ii); end
pFlips = mod(sum(f), 2); % parity of number of flips


if xor(pFlips, pSwaps) % if total parity of flips and swaps is odd
    warning('nihelp:rotateVolumeOdd', 'Odd number of swaps/flips'); 
end
