function V = rotateVolumetric(V, srcOrientation, tgtOrientation)
%% ROTATEVOLUMETRIC Rotate volumetric coordinates in anatomical space
%% Examples
%   D = randn(10000,3); E = rotateVolumetric(D, 'prs', 'ras'); 
%   D = randn(10000,3); E = rotateVolumetric(D, 'prs', 'spr'); assert(isequal(D,E(:,[2,3,1]))); 
%   D = randn(10000,3); E = rotateVolumetric(D, 'prs', 'als'); assert(isequal(D,E.*[-1,-1,1])); 
%   D = randn(10000,3); assert(isequal(D, rotateVolumetric(rotateVolumetric(D,'pir','ras'),'ras','pir')));
% 
%   D = squeeze(load('mri').D); [D,C] = vol2xyz(D+uint8(1:128),logical(D)); figure; nexttile; scat3(D,[],C,'.'); nexttile; scat3(rotateVolumetric(D, 'prs', 'ras'),[],C,'.'); 
% 
% 
%% TODO
% * docs
% 
% 
%% See also 
%  VOL2XYZ, ROTATEVOLUME, PLOTVOLUME
%  Imaging conventions: https://nipy.org/nibabel/neuro_radio_conventions.html
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


srcOrientation = convertStringsToChars(lower(srcOrientation));
tgtOrientation = convertStringsToChars(lower(tgtOrientation));


%% Permute axes
% replace post/ant, inf/sup, right/left with coronal, transverse, sagittal
% in order to get permuting order
srcD = replace(srcOrientation, {'p','a','i','s','r','l'}, {'C','C','T','T','S','S'});
tgtD = replace(tgtOrientation, {'p','a','i','s','r','l'}, {'C','C','T','T','S','S'});

t = arrayfun(@(x) strfind(srcD, x), tgtD); % permutation order
V = V(:, t); 
pSwaps = nnz(t == [1,2,3]) == 1; % parity of number of swaps


%% Do flips as needed
f = arrayfun(@(x) ~contains(srcOrientation, x), tgtOrientation);
for ii = find(f); V(:,ii) = -V(:,ii); end
pFlips = mod(sum(f), 2); % parity of number of flips


if xor(pFlips, pSwaps) % if total parity of flips and swaps is odd
    warning('nihelp:rotateVolumeOdd', 'Odd number of swaps/flips'); 
end

end
