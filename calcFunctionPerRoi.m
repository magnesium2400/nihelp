function out = calcFunctionPerRoi(data, rois, func)
%% CALCHETEROGENEITY calculates function at a roi level given vertex level data
% Inputs: data: vertex level data to be evaluated
%         rois: ROI allocation of eavh vertex (rois == 0 are excluded)
%         func: function used to compute result
% Outputs: out: vector of score for each ROI

assert(length(data) == length(rois));
assert(size(data, 2) == 1);
assert(size(rois, 2) == 1);

out = nan(max(rois), 1);
for ii = 1:max(rois)
    out(ii) = func(data(rois==ii));
end
