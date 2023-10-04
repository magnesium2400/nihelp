function out = calcVertexArea(verts, faces)
%% CALCVERTEXAREA distribute face area to the surrounding vertices

nVertsPerFace = size(faces, 2);
out = nan(length(verts), 1);

faceAreas = calcFaceArea(verts, faces);

for ii = 1:length(verts)
    out(ii) = sum(faceAreas(any(faces == ii, 2)))/nVertsPerFace;
end

end
