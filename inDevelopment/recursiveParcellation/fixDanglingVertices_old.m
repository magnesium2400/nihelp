function newRois = fixDanglingVertices_old(verts, faces, rois)

disp('old'); 

%% 0: return if no verts dangling

[~,faces,newRois] = checkVertsFacesRoisData(verts, faces, rois);
vertsDangling = findDanglingVertices(faces, newRois);
if checkParcellation(verts, faces, newRois); return; end


%% Option 1: try contracting the dangling verts
% if all of them are next to only one other candidate ROI

temp = arrayfun( @(x) getNeighborRois(x,faces,newRois) , vertsDangling, 'uni', 0);
if all(cellfun(@length, temp) == 1)
    newRois(vertsDangling) = cell2mat(temp);
end

% vertsDangling = findDanglingVertices(faces, newRois);
if checkParcellation(verts, faces, newRois); return; end


%% Option 2a: try dilating the dangling verts
% if all of their neighbors are next to only one candidate ROI

[~,faces,newRois] = checkVertsFacesRoisData(verts, faces, rois);
vertsDangling = findDanglingVertices(faces, newRois);


temp = cell(length(vertsDangling), 1);
for ii = 1:length(vertsDangling)
    temp{ii} = [getNeighbors(vertsDangling(ii), faces); vertsDangling(ii)];
    temp{ii}(:,2) = newRois(vertsDangling(ii));
end
temp = cell2mat(temp);
n = arrayfun(@(x) length(unique(temp(temp(:,1)==x,2))) , unique(temp(:,1)) );
if all(n==1)
    newRois(temp(:,1)) = temp(:,2);
end

vertsDangling = findDanglingVertices(faces, newRois);
if isempty(vertsDangling); return; end


%% Option 2b: try contracting the dilated verts
% if all of them are next to only one other candidate ROI

temp = arrayfun( @(x) getNeighborRois(x,faces,newRois) , vertsDangling, 'uni', 0);
if all(cellfun(@length, temp) == 1)
    newRois(vertsDangling) = cell2mat(temp);
end

vertsDangling = findDanglingVertices(faces, newRois);
if isempty(vertsDangling); return; end


%% Option 3: adjust verts individually

newRois = rois;
jj=0;
while jj<50
    % Check if any vertices dangling; exit if not
    vertsDangling = findDanglingVertices(faces, newRois);
    if isempty(vertsDangling);  return;
    else;                       roiFaces = newRois(faces);  end

    % Iterate over each dangling vertex
    toBeUpdated = zeros(numel(newRois), 2) + [0, NaN];
    for ii = vertsDangling(:)'
        % Find the ROIs it neighbours
        [~,m] = getRowsContaining(faces, ii);

        facesNeighbouring = faces(m,:);
        vertsNeighbouring = setdiff(unique(facesNeighbouring), ii);
        roiFacesNeighbouring = roiFaces(m,:);
        roisCandidate = setdiff(unique(roiFacesNeighbouring), newRois(ii));

        % Choose the best ROI:
        % 1) Special case where the vertex is attached to only one face
        if (nnz(m) == 1) && (numel(roisCandidate) == 1)
            toBeUpdated(facesNeighbouring(roiFacesNeighbouring~=mode(roiFacesNeighbouring)),:) = ...
                [1, mode(roiFacesNeighbouring)];
            % newRois(facesNeighbouring(roiFacesNeighbouring~=newRois(ii))) = newRois(ii);
            % vertsDangling = setdiff(vertsDangling, ii);
            % new(ii) = newRois(ii);
            continue;
        end

        % 2) general case
        % i) s.t. the largest number of the vertex's faces become homogenous
        temp1 = arrayfun(@(x) countHomogenousFaces(renumber(roiFacesNeighbouring, x, newRois(ii))), ...
            roisCandidate );
        % ii) s.t. the vertex is allocated to its most common neighboring ROI
        temp2 = arrayfun(@(x) nnz(newRois(vertsNeighbouring) == x), roisCandidate);

        temp = sortrows([temp1, temp2, roisCandidate], [], 'descend');
        toBeUpdated(ii,:) = [1, temp(1,end)];
    end
    newRois(logical(toBeUpdated(:,1))) = toBeUpdated(logical(toBeUpdated(:,1)),2);
    % newRois(vertsDangling) = new(vertsDangling);
    jj=jj+1;
end

%%
if jj >= 5
    jj
    figure;
    patchvfc(verts, faces, [], 'EdgeColor', 'k');
    axis image vis3d off; viewh('r'); colormap(lines(length(unique(newRois))));
    hold on;
    s = scat3(verts, 25, newRois, 'filled'); addScatterLabels(s);
    scat3(verts(vertsDangling,:), 90, 'k');
end

end % main


%% HELPERS
function vertsDangling = findDanglingVertices(faces, rois)
% ROI allocations for each face
roiFaces = rois(faces);

% Faces where all verts are in the same ROI
facesHomogenous = all(roiFaces==roiFaces(:,1),2);

% Vertices on those faces
vertsHomogenous = unique(faces(facesHomogenous,:),'sorted');

% Vertices where none of the faces are homogenous ie all its faces are allocated
% to multiple ROIs
vertsDangling = findMissingNaturals(vertsHomogenous, length(rois)); % returns a row matrix of vertex IDs

end

function out = countHomogenousFaces(faces)
out = nnz(all(faces == faces(:,1),2));
end

function out = getNeighbors(vert, faces)
out = setdiff(unique( getRowsContaining(faces, vert)' ),vert); % returns column
end

function out = getNeighborRois(vert, faces, rois)
out = setdiff( rois(getNeighbors(vert, faces))  , rois(vert)); % returns column
end

function out = checkParcellation(verts, faces, rois)
out = true;
if ~isempty(findDanglingVertices(faces, rois))
    out = false;
    return;
end
for ii = unique(rois(:))'
    [~,f,r] = trimExcludedRois(verts, faces, rois==ii, 'removeUnconnected', false);
    if ~isConnected(f,r)
        out = false;
        return;
    end
end
end

