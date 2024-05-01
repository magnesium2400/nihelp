function modeStrap = eigenstrap(modeData, mask)
%% EIGENSTRAP applies the eigenstrapping of Koussis & Breakspear to mode data
%% Inputs
%  modeData - eigenmodes (nPoints x nModes matrix)
%  mask (optional) - mask to be applied to mode (nPoints x 1 logical vector)
%
%
%% Outputs
%  modeStrap - modes with each group rotated in eigenspace (nPoints x nModes matrix)
%  Note that any points not specifeid by `mask` will retain their original
%  values. 
%
%
%% See also
% eigenstrapSubgroup, sorthogonal
%
%
%% Authors
% Mehul Gajwani, Monash University, 2023


%% Prelims
if nargin < 2;  mask = true(size(modeData,1), 1); 
else;           mask = logical(mask); end

nModes = size(modeData, 2);
nGroups = ceil(sqrt(nModes));

%% Calculations
modeStrap = modeData; % so that unmasked areas remain unchanged

modeStrap(mask, 1) = modeData(mask, 1); % first mode can't be rotated in eigenspace 

% rotate each group in eigenspace and allocate to `modeStrap`
for ii = 2:(nGroups)
    currIdx = getEigengroupIdx(ii);
    if ii == nGroups; currIdx = currIdx(currIdx <= nModes); end % in case last group is incomplete 
    modeStrap(mask, currIdx) = eigenstrapSubgroup(modeData(mask, currIdx));
end


end
