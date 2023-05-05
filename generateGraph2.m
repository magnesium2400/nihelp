function [G, A] = generateGraph2(faces, rois)

roiIds = unique(nonzeros(rois));
nRois = length(roiIds);
A = zeros(nRois);

roiFaces = rois(faces);

for ii = 2:nRois
    for jj = 1:(ii-1)
        A(ii, jj) = any( any(roiFaces==ii, 2) & any(roiFaces==jj, 2) );
    end
end


G = graph(A+A.');

end