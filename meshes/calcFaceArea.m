function out = calcFaceArea(verts, faces)
%% CALCFACEAREA gets area of each face in a surface patch object
assert(size(verts, 2) == 3);
assert(size(faces, 2) == 3);
assert(max(faces(:)) == length(verts));


temp = zeros( length(faces), 3, 3 );

for ii = 1:length(faces)
    temp(ii,:,:) = verts(faces(ii,:),:)';
end
temp2 = cross(temp(:,:,2) - temp(:,:,1), temp(:,:,3) - temp(:,:,1));

out = 0.5 * sqrt(sum(temp2.*temp2, 2));

end


