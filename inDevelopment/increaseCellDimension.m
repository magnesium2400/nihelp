function [cells, cellsDone] = increaseCellDimension(faces, strictNeighbors)
%% TRIANGULATION2TETRAHEDRA Calculates 3d tetrahedral mesh from 2d triangular mesh
%% Examples
% See Test 1 (and test 2) in `triangulation2tetrahedra_test.m`.
%
%
%% TODO
% * docs
%
%
%% Usage Notes
% Performance is seemingly quadratic in the number of triangular faces that are input:
% - nFaces: 2124; time (s): 0.4887580
% - nFaces: 4700; time (s): 1.4828590
% - nFaces: 7296; time (s): 2.8274130
% - nFaces: 9848; time (s): 4.7260640
% - nFaces: 12588; time (s): 7.1412160
% - nFaces: 15220; time (s): 9.3517590
% - nFaces: 18032; time (s): 13.9446850
% - nFaces: 20376; time (s): 17.5116650
% - nFaces: 23368; time (s): 22.0455410
% - nFaces: 25812; time (s): 25.9077710
% - nFaces: 28484; time (s): 30.7160020
% - nFaces: 31160; time (s): 34.2569690
% - nFaces: 34000; time (s): 40.3304530
% - nFaces: 36412; time (s): 45.9877560
% - nFaces: 39284; time (s): 53.4754090
%
%
%% See also
%   sortmat = @(x) sortrows(sort(x,2));
%   matrixRowsSubset = @(x,y) all(arrayfun( @(ii) any( all(ismember(y,x(ii,:)),2) )  , 1:height(x) ))
%   matrixRowsEqual =  @(x,y) all(arrayfun( @(ii) any( all(ismember(y,x(ii,:)),2) )  , 1:height(x) )) &&  all(arrayfun( @(ii) any( all(ismember(x,y(ii,:)),2) )  , 1:height(y) ));
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%

if nargin < 2; strictNeighbors = 1; end

%% get first face
for currentFaceId = 1:height(faces)
    currentFace = faces(currentFaceId,:);
    currentNeighbours = getNeighbours(faces, currentFace);
    if length(currentNeighbours) == 2
        cells = [currentFace, currentNeighbours(1)];
        cellsDone = 0;
        break
    end
end



%% get all faces
while any(~cellsDone)
    currentCellId = find(~cellsDone,1);
    currentCell = cells(currentCellId,:);
    currentCellFlag = 1;

    for ii = width(cells):-1:1 % loop over all faces of current cell
        currentFace = currentCell(setdiff(1:width(cells),ii));
        n = setdiff(getNeighbours(faces, currentFace), currentCell(ii));

        if length(n) == 0 %#ok<*ISMT>
            currentCellFlag = -1; % -1 for bad/border, +1 for good
        elseif length(n) == 1
            newCell = [currentFace, n];
            if ~any(all(ismember(cells,newCell),2)) % check it is not already present with different permutataion
                cells = [cells; newCell]; %#ok<AGROW>
                cellsDone = [cellsDone; 0]; %#ok<AGROW>
            end
        elseif ~strictNeighbors
            for jj = 1:length(n)
                newCell = [currentFace, n(jj)];
                if ~any(all(ismember(cells,newCell),2)) % check it is not already present with different permutataion
                    cells = [cells; newCell]; %#ok<AGROW>
                    cellsDone = [cellsDone; 0]; %#ok<AGROW>
                end
            end
        else %error('more than 2 neighbours');
        end

    end

    cellsDone(currentCellId) = currentCellFlag; %#ok<AGROW>
end




end


%% HELPERS

function currentNeighbours = getNeighbours(faces, currentFace)
currentFaces = faces( sum(ismember(faces, currentFace),2) == width(faces)-1   ,:);
currentNeighbours = setdiff(currentFaces, currentFace);
for ii = length(currentNeighbours):-1:1
    for jj = 1:width(faces)
        a = currentFace(setdiff(1:width(faces),jj));
        if ~any(all(ismember(currentFaces,[a,currentNeighbours(ii)]),2))
            currentNeighbours(ii) = []; break;
        end
    end
end
end

