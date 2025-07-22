function sliceExample(V, n)

nDims = ndims(V);
if nargin < 2; n = 3; end

figure; 
tiledlayout(n, nDims, 'TileIndexing','columnmajor');

for ii = 1:nDims

    for jj = 1:n

        sliceID = round(jj*size(V, ii)/(n+1));
        currentSlice = sliceDim(V, ii, sliceID);

        imagesc(nexttile(), currentSlice); 
        axis image; clim(minmax(V,[],'all')); 
        subtitle(sprintf('Slice %i/%i', sliceID, size(V, ii)));

        if jj == 1; title(sprintf('Dimension %i', ii)); end

    end

end


end
