function out = roi2vert(rois, data)
%% roi2vert changes data from ROI level to vertex level
% rois: nVerts * 1 allocation of rois for each vertex
% data: nRois * nData data map(s) at ROI level
% out:  nVerts * nData data map(s) at vertex level
data2 = [nan(1, size(data, 2)); data];
out = data2(rois+1,:);
end
