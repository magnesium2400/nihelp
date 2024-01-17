function [D, map] = loadmri() %#ok<STOUT>
load mri; %#ok<LOAD>
D = rotateVolume(squeeze(double(D)), 'prs', 'ras'); %#ok<NODEF>
end