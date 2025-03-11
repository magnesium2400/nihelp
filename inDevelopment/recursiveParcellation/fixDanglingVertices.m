function newRois = fixDanglingVertices(verts, faces, rois)

%#ok<*ASGLU>
%% Initial check : if all connected, return
[result, dodgyRegions, nIncorrect, incorrectMask] = isParcellationConnected(verts, faces, rois); 
if result; newRois = rois; return; end


%% Fix vertices that are only on one face : that face must be homogenous
incorrectVerts = find(incorrectMask); 
nFaces = arrayfun(@(x) height(getRowsContaining(faces, x)), incorrectVerts); 
for ii = find(nFaces(:)'==1)
    f = getRowsContaining(faces, incorrectVerts(ii));
    rois(f) = mode(rois(f)); 
end

[result, dodgyRegions, nIncorrect, incorrectMask] = isParcellationConnected(verts, faces, rois);
if result; newRois = rois; return; end


%% Close regions that don't have dangling vertices
% this should reduce the number of dangling vertices from other regions
for ii = setxor(dodgyRegions(:)', unique(rois(:)'))
    rois = closeMeshRegion(verts, faces, rois, ii, 1); 
end

[result, dodgyRegions, nIncorrect, incorrectMask] = isParcellationConnected(verts, faces, rois);
if result; newRois = rois; return; end


%%

idx = invsort(nIncorrect);
nIncorrect = nIncorrect(idx);
dodgyRegions = dodgyRegions(idx);

newRois = rois;
while ~isempty(dodgyRegions)

    for counter = 1:10
        temp = openMeshRegion(verts, faces, newRois, dodgyRegions(1), counter);
        
        if isRegionConnected(verts, faces, temp, dodgyRegions(1))
            newRois = temp;
            [a,b] = isParcellationConnected(verts, faces, newRois);
            % disp(counter);
            if a
                return;
            else
                dodgyRegions = [dodgyRegions(2:end), setdiff(b, dodgyRegions)];
                break;
            end
        end

        % roisDilated = dilateMeshRegion(verts, faces, newRois, dodgyRegions, counter);
        % newRois = erodeMeshRegion(verts, faces, roisDilated, dodgyRegions, counter);
        % if isParcellationConnected(verts, faces, newRois); return; end

    end

end

disp('oldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldold');
newRois = fixDanglingVertices_old(verts, faces, rois);
return;



end



