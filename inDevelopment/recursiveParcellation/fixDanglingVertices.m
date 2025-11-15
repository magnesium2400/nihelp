function [newRois, rad] = fixDanglingVertices(verts, faces, rois, maxRadius)

%#ok<*ASGLU>
%% Initial check : if all connected, return
rad = 0; 
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
if result
    newRois = rois; 
    return;
end


%% Repeated opening/closing of regions as required
regionsToOpen  = dodgyRegions(:)';
regionsToClose = setxor(dodgyRegions(:)', unique(rois(:)'));

for rad=1:maxRadius

    %%% Close regions that don't have dangling vertices
    if ~isempty(regionsToClose)
        temp = rois; 
        for ii = regionsToClose
            temp = closeMeshRegion(verts, faces, temp, ii, rad);
        end

        if isParcellationConnected(verts, faces, temp)
            newRois = temp;
            return;
        end
    end

    %%% Open regions that DO have dangling vertices
    if ~isempty(regionsToOpen)
        temp = rois; 
        for ii = regionsToOpen
            temp = openMeshRegion(verts, faces, temp, ii, rad);
        end

        if isParcellationConnected(verts, faces, temp)
            newRois = temp;
            return;
        end
    end

end

warning('nihelp:fixDanglingVertices:unfixed', 'Unable to fix dangling vertices');
newRois = rois; 
rad = Inf; 

end




% % % % % Old code

% % % % % % %% Fix vertices that are only on one face : that face must be homogenous
% % % % % % incorrectVerts = find(incorrectMask);
% % % % % % nFaces = arrayfun(@(x) height(getRowsContaining(faces, x)), incorrectVerts);
% % % % % % for ii = find(nFaces(:)'==1)
% % % % % %     f = getRowsContaining(faces, incorrectVerts(ii));
% % % % % %     rois(f) = mode(rois(f));
% % % % % % end
% % % % % %
% % % % % % [result, dodgyRegions, nIncorrect, incorrectMask] = isParcellationConnected(verts, faces, rois);
% % % % % % if result;
% % % % % %     newRois = rois; return;
% % % % % % end

% % % % % idx = invsort(nIncorrect);
% % % % % nIncorrect = nIncorrect(idx);
% % % % % dodgyRegions = dodgyRegions(idx);
% % % % %
% % % % % newRois = rois;
% % % % % while ~isempty(dodgyRegions)
% % % % %
% % % % %     for counter = 1:10
% % % % %         temp = openMeshRegion(verts, faces, newRois, dodgyRegions(1), counter);
% % % % %
% % % % %         if isRegionConnected(verts, faces, temp, dodgyRegions(1))
% % % % %             newRois = temp;
% % % % %             [a,b] = isParcellationConnected(verts, faces, newRois);
% % % % %             % disp(counter);
% % % % %             if a
% % % % %                 return;
% % % % %             else
% % % % %                 dodgyRegions = [dodgyRegions(2:end), setdiff(b, dodgyRegions)];
% % % % %                 break;
% % % % %             end
% % % % %         end
% % % % %
% % % % %         % roisDilated = dilateMeshRegion(verts, faces, newRois, dodgyRegions, counter);
% % % % %         % newRois = erodeMeshRegion(verts, faces, roisDilated, dodgyRegions, counter);
% % % % %         % if isParcellationConnected(verts, faces, newRois); return; end
% % % % %
% % % % %     end
% % % % %
% % % % % end
% % % % %
% % % % % disp('oldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldoldold');
% % % % % newRois = fixDanglingVertices_old(verts, faces, rois);
% % % % % return;


