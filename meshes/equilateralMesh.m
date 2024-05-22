function [verts, faces] = equilateralMesh(nFaces)
%% EQUILATERALMESH Surface mesh from one of the 8 strictly convex deltahedra
%% Examples
%   [verts, faces] = equilateralMesh(4); 
%   n=setdiff(4:2:20,18); figure; for ii=n; nexttile; [v,f]=equilateralMesh(ii); trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; end     
%   n=setdiff(4:2:20,18); figure; for ii=n; nexttile; [v,f]=equilateralMesh(ii); trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; nexttile; bar(calcFaceArea(v,f)); end     
%   
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 






s = @sqrt; ss = @(x) s(s(x)); 
switch nFaces
    case 4 % tetrahedron
        verts = [0 0 3; 0 s(8) -1; -s(6) -s(2) -1; s(6) -s(2) -1]/s(24);
        faces = [1 2 3; 2 1 4; 1 3 4; 2 4 3];
    case 6 % triangular bipyramid
        verts = [0 0 4; 0 s(8) 0; -s(6) -s(2) 0; s(6) -s(2) 0; 0 0 -4]/s(24);
        faces = [1 2 3; 2 1 4; 1 3 4; 5 3 2; 4 5 2; 5 4 3];
    case 8 % octahedron
        verts = [0 0 s(2); 1 1 0; -1 1 0; -1 -1 0; 1 -1 0; 0 0 -s(2)]/2;
        faces = [1 2 3; 1 3 4; 1 4 5; 1 5 2; 6 3 2; 6 4 3; 6 5 4; 6 2 5];
    case 10 % pentagonal bipyramid
        t = [5 9 13 17 1]'/10; 
        verts = s((5+s(5))/10)*[0,0,(s(5)-1)/2; [cospi(t), sinpi(t), 0*t]; 0,0,(1-s(5))/2];
        faces = [1 2 3; 1 3 4; 1 4 5; 1 5 6; 1 6 2; 7 3 2; 7 4 3; 7 5 4; 7 6 5; 7 2 6];
    case 12 % snub disphenoid
        % https://en.wikipedia.org/wiki/Snub_disphenoid
        syms p; p = vpasolve(2*p^3+11*p^2+4*p-1); q = double(p(3)); a = s(q); b = s((1-q)/(2*q)); c = s(2-2*q); 
        verts = [0 b 1; 0 b -1; -c a 0; c a 0; 0 -a c; 0 -a -c; -1 -b 0; 1 -b 0]/2;
        faces = [1 2 3; 1 4 2; 1 3 5; 1 5 4; 2 6 3; 2 4 6; 3 7 5; 4 5 8; 5 7 8; 3 6 7; 4 8 6; 6 8 7];
    case 14 % triaugmented triangular prism
        t = 1 + s(6); 
        verts = [0 s(8) s(6); -s(6) -s(2) s(6); s(6) -s(2) s(6); s(1.5)*t s(.5)*t 0; -s(1.5)*t s(.5)*t 0; 0 -s(2)*t 0; 0 s(8) -s(6); -s(6) -s(2) -s(6); s(6) -s(2) -s(6)]/s(24);
        faces = [1 2 3; 1 3 4; 1 5 2; 3 2 6; 1 4 7; 2 5 8; 3 6 9; 4 3 9; 5 1 7; 6 2 8; 4 9 7; 5 7 8; 6 8 9; 9 8 7];
    case 16 % gyroelongated octahedron
        verts = [0 0 s(2)+ss(1/2); 1 1 ss(1/2); -1 1 ss(1/2); -1 -1 ss(1/2); 1 -1 ss(1/2); s(2) 0 -ss(1/2); 0 s(2) -ss(1/2); -s(2) 0 -ss(1/2); 0 -s(2) -ss(1/2); 0 0 -s(2)-ss(1/2)]/2;
        faces = [1 2 3; 1 3 4; 1 4 5; 1 5 2; 2 7 3; 3 8 4; 4 9 5; 5 6 2; 7 2 6; 8 3 7; 9 4 8; 6 5 9; 6 10 7; 7 10 8; 8 10 9; 9 10 6];   
    case 20 % icosahedron
        t = [5 9 13 17 1]'/10; 
        verts = [0,0,s((5+s(5))/40)]+s((5+s(5))/10)*[0,0,(s(5)-1)/2; [cospi(t), sinpi(t), 0*t]];
        verts = [verts; [0,0,-s((5+s(5))/40)]+s((5+s(5))/10)*[[cospi(t-.2), sinpi(t-.2), 0*t]; 0,0,(1-s(5))/2]];
        faces = [1 2 3; 1 3 4; 1 4 5; 1 5 6; 1 6 2; 8 3 2; 9 4 3; 10 5 4; 11 6 5; 7 2 6; 3 8 9; 4 9 10; 5 10 11; 6 11 7; 2 7 8; 7 12 8; 8 12 9; 9 12 10; 10 12 11; 11 12 7];
end


end