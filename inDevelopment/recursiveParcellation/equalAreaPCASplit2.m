function out = equalAreaPCASplit2(verts, faces, sphere, nregions, vertAreas)
%% takes a brain surface and makes one set of parallel, equal area cuts

[~, scores] = pca(sphere, 'NumComponents', 1);

[scoresOrdered,idx] = sort(scores, 'ascend');

areasOrdered = cumsum(vertAreas(idx));


THR = interp1(areasOrdered, scoresOrdered, ...
    areasOrdered(end) * (1:nregions-1)/nregions);
THR = [scoresOrdered(1), THR, scoresOrdered(end)];
thr = THR;


[~,~,bin] = histcounts(scores, thr);
OUT = bin;      % correct for off-by-one error at the end
out = OUT;

getIdx = @(x) argout(@() histcounts(scores, x), 3);
getRowsContaining = @(mat, tgt) mat(any(ismember(mat,tgt),2),:);
isConn = @(mask) nnz(mask) == height(trimExcludedRois(sphere, faces, mask));
allConn = @(rois) all(arrayfun( @(ii) isConn(rois==ii) , unique(rois) ));
nextThr = @(x) min(scoresOrdered(scoresOrdered>x)); 
prevThr = @(x) max(scoresOrdered(scoresOrdered<x)); 

if allConn(out)
    out = out - 1;
    return;
end


% check if reallocating a few verts helps
paren = @(a,b) a(b); roiFaces = out(faces); %#ok<NASGU>
disconnVerts = cell(nregions, 1); 
for ii = 1:nregions % first get the disconnected verts in each ROI
    ic(ii) = isConn(out==ii); %#ok<AGROW>
    if ic(ii); continue; end

    currMask = out==ii;
    [~,~,~,mask2] = trimExcludedRois(sphere, faces, currMask);
    disconnVerts{ii} = find(currMask & ~mask2);
end
disconnVerts = cell2mat(disconnVerts); 
for ii = 1:length(disconnVerts)
    disconnNeighbors = unique(getRowsContaining(faces, disconnVerts(ii)));
    oldRoi = out(disconnVerts(ii)); 
    newRoi = mode(nonzeros(OUT(disconnNeighbors)-oldRoi))+oldRoi;
    out(disconnVerts(ii)) = newRoi;
end
if allConn(out)
    out = out-1; return; 
end
for ii = 1:length(disconnVerts)
    disconnNeighbors = unique(getRowsContaining(faces, disconnVerts(ii)));
    oldRoi = out(disconnVerts(ii)); 
    % newRoi = mode(nonzeros(OUT(disconnNeighbors)-oldRoi))+oldRoi;
    out(disconnNeighbors) = oldRoi;
end
if allConn(out)
    out = out-1; return; 
end



% wiggle thresholds in order to keep rois connected
paren = @(a,b) a(b); roiFaces = out(faces); %#ok<NASGU>
for ii = 1:nregions
    OUT = out; 
    ic(ii) = isConn(out==ii);
    if ic(ii); continue; end

    % check if reallocating a few verts helps
    temp = isConn(out==ii-1 | out==ii | out==ii+1);
    if ~temp; warning('Disconnected region found, may be especially diffiult to fix'); end

    currMask = out==ii;
    [~,~,~,mask2] = trimExcludedRois(sphere, faces, currMask);
    disconnVerts = find(currMask & ~mask2);
    disconnNeighbors = unique(getRowsContaining(faces, disconnVerts));
    % try changing current vert to neighbors' ROI
    out(disconnVerts) = mode(nonzeros(OUT(disconnNeighbors)-ii))+ii;
    if allConn(out); out = out-1; return; 
    % elseif isConn(out==ii); continue; 
    end
    % try changing neighors to current ROI
    out(disconnNeighbors) = ii; 
    if allConn(out); out = out-1; return; 
    % elseif isConn(out==ii); continue; 
    end
    out = OUT; 

    % check to see if combining with prev region helps
    if ii > 1
        temp = isConn(out==ii-1 | out==ii);
        % delt = (thr(ii)-thr(ii-1))*0.01;
        while temp
            % thr(ii) = thr(ii)-delt;
            thr(ii) = prevThr(thr(ii)); 
            out = getIdx(thr);
            a = isConn(out==ii);
            if a; continue; end
        end
    end

    % check to see if combining with next region helps
    if ii < nregions
        temp = isConn(out==ii | out==ii+1);
        % delt = (thr(ii+2)-thr(ii+1))*0.01;
        while temp
            % thr(ii+1) = thr(ii+1)+delt;
            thr(ii+1) = nextThr(thr(ii+1)); 
            out = getIdx(thr);
            a = isConn(out==ii);
            if a; continue; end
        end
    end

    % check to see if combining with prev and next regions helps
    if ii > 1 && ii < nregions
        temp = isConn(out==ii-1 | out==ii | out==ii+1);
        % delt = (thr(ii+2)-thr(ii-1))*0.01/3;
        while temp
            % thr(ii) = thr(ii)-delt;
            % thr(ii+1) = thr(ii+1)+delt;
            thr(ii) = prevThr(thr(ii));
            thr(ii+1) = nextThr(thr(ii+1));
            out = getIdx(thr);
            a = isConn(out==ii);
            if a; continue; end
        end
    end




end


out = out-1;


end

