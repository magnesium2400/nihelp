function out = annotation2rois(filename)
%% ANNOTATION2ROIS Converts a freesurfer '.annot' file to vector of ROI allocations (parcellation)
%% Usage Notes
% `out` indexes parcels based on the raw data from the annot file.
% Therefore, values of 0 correspond to missing values in the colortable
% (and values of 1 probably to masked areas e.g. medial wall). You probably
% want to use `out-1` as the actual parcellation vector.
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


[~, label, ct] = read_annotation(filename);
[~, out] = ismember(label, ct.table(:,5));
end
