function [verts, W] = vol2verts(V_rois, zeroMidline)
%% VOL2VERTS Finds center (mean) of each ROI in a volumetric parcellation
%% Input Arguments
%  V_rois - data to be parcellated (3 dimensional matrix)
%  3D matrix where the values at each point are the ROI ID of the voxel at
%  that point. Use 0 to indicate voxels to be excluded.
% 
%  zeroMidline - flag for setting x-coordinates to be centred at 0 (false (default) | true)
% 
% 
%% Output Arguments
%  verts - ROI centers (three column matrix)
%  
%  W - adjacency matrix of connections between ROIs
%  W_{ij} is the number of vertices in region j that are adjacent to a
%  vertex in region j

%% ENDPUBLISH

if nargin < 2; zeroMidline = false; end

nRois = max(V_rois, [], 'all');
verts = zeros(nRois, 3);
counter = zeros(nRois, 1);

if nargout == 1
    %% iterate over each voxel: faster than 1 ROI at a time or splitapply
    for ii = 1:numel(V_rois)
        r = V_rois(ii);
        if r
            counter(r) = counter(r) + 1;
            [x,y,z] = ind2sub(size(V_rois), ii);
            verts(r,:) = verts(r,:) + [x,y,z];
        end
    end
    verts = verts./counter;

else
    %% dilate each ROI and find neighbours
    
    kernel = zeros(3,3,3);
    kernel([5 11 13 14 15 17 23]) = 1; % orthogonal only
    % figure; plotVolume(kernel)

    W = nan(nRois, nRois);
    % iterate over each ROI
    for ii = 1:nRois
        mask = V_rois == ii;
        if ~any(mask, 'all'); continue; end
        [x,y,z] = ind2sub(size(V_rois), find(mask));
        verts(ii,:) = mean([x,y,z],1);

        maskDilated = imdilate(mask, kernel);
        temp = V_rois(maskDilated);
        W(:, ii) = splitapply0(@numel, temp, temp, nRois);
    end



end



if zeroMidline; verts(:,1) = verts(:,1)-size(V_rois,1)/2; end

end
