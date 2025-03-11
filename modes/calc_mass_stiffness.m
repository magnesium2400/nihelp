function [surface, M, S] = calc_mass_stiffness(surface, lump)
% calc_mass_stiffness.m
%
% Calculate the mass and stiffness matrices of the input surface/volume
%
% Inputs: surface : surface structure with fields
%                   'vertices' - vertex locations [Nx3], N = number of vertices
%                   'faces' - which vertices are connected [Fx3 or Fx4], F = number of faces
%         lump    : whether to diagonalise mass matrix 
%                   [false (default) | true]
%
% Outputs: surface : surface structure with fields 'mass' and 'stiffness'
%          M : mass matrix [NxN]
%          S : stiffness matrix [NxN]
%
% Original: Mehul Gajwani & Victor Barnes, Monash University, 2024


if nargin < 2 || isempty(lump); lump = false; end

if     size(surface.faces, 2) == 3; [M,S] = cms3(surface, lump);
elseif size(surface.faces, 2) == 4; [M,S] = cms4(surface, lump); 
else;  error('Incorrect faces specified'); 
end

% If matrices are not symmetric (due to machine error) - which they should
% be - eigenvectors will not be normalised
if ~issymmetric(M); assert(allclose(M, M')); M = (M+M')/2; end
if ~issymmetric(S); assert(allclose(S, S', 1e-4)); S = (S+S')/2; end

surface.mass = M; surface.stiffness = S;

end


%% Triangulated mesh 

function [M,S] = cms3(surface, lump)
% Copied from LaPy
t1 = surface.faces(:,1);
t2 = surface.faces(:,2);
t3 = surface.faces(:,3);

v1 = surface.vertices(t1,:);
v2 = surface.vertices(t2,:);
v3 = surface.vertices(t3,:);

v2mv1 = v2 - v1;
v3mv2 = v3 - v2;
v1mv3 = v1 - v3;

cr = cross(v3mv2, v1mv3);
vol = 2 * vecnorm(cr, 2, 2); % vol = 2*sqrt(sum(cr .* cr, 2));
% vol(vol < eps) = mean(vol)/10000;

ii = [t1; t2; t2; t3; t3; t1; t1; t2; t3];
jj = [t2; t1; t3; t2; t1; t3; t1; t2; t3];

% Calculate stiffness matrix (S)
a12 = sum(v3mv2 .* v1mv3, 2) ./ vol;
a23 = sum(v1mv3 .* v2mv1, 2) ./ vol;
a31 = sum(v2mv1 .* v3mv2, 2) ./ vol;

a11 = -a12 - a31;
a22 = -a12 - a23;
a33 = -a31 - a23;

local_a = [a12; a12; a23; a23; a31; a31; a11; a22; a33];

S = sparse(ii,jj,double(local_a));

% Calculate mass matrix (M)
if ~lump
    b_ii = vol / 24;
    b_ij = vol / 48;
    local_b = [repmat(b_ij, 6, 1); repmat(b_ii, 3, 1)];
    M = sparse(ii, jj, double(local_b));
else
    b_ii = vol / 12;
    local_b = repmat(b_ii,3,1);
    ii = [t1; t2; t3];
    M = sparse(ii,ii,double(local_b));
end

end


%% Tetrahedral mesh

function [M,S] = cms4(surface, lump)
% Copied from LaPy
t1 = surface.faces(:,1);
t2 = surface.faces(:,2);
t3 = surface.faces(:,3);
t4 = surface.faces(:,4);

v1 = surface.vertices(t1,:);
v2 = surface.vertices(t2,:);
v3 = surface.vertices(t3,:);
v4 = surface.vertices(t4,:);

e1 = v2 - v1;
e2 = v3 - v2;
e3 = v1 - v3;
e4 = v4 - v1;
e5 = v4 - v2;
e6 = v4 - v3;

cr = cross(e1, e3);
vol = abs(sum(e4 .* cr, 2));
% vol(vol < eps) = mean(vol)/10000;

% Calculate stiffness matrix (S)
e11 = sum(e1 .* e1, 2);
e22 = sum(e2 .* e2, 2);
e33 = sum(e3 .* e3, 2);
e44 = sum(e4 .* e4, 2);
e55 = sum(e5 .* e5, 2);
e66 = sum(e6 .* e6, 2);
e12 = sum(e1 .* e2, 2);
e13 = sum(e1 .* e3, 2);
e14 = sum(e1 .* e4, 2);
e15 = sum(e1 .* e5, 2);
e23 = sum(e2 .* e3, 2);
e25 = sum(e2 .* e5, 2);
e26 = sum(e2 .* e6, 2);
e34 = sum(e3 .* e4, 2);
e36 = sum(e3 .* e6, 2);

a12 = (-e36 .* e26 + e23 .* e66) ./ vol;
a13 = (-e15 .* e25 + e12 .* e55) ./ vol;
a14 = ( e23 .* e26 - e36 .* e22) ./ vol;
a23 = (-e14 .* e34 + e13 .* e44) ./ vol;
a24 = ( e13 .* e34 - e14 .* e33) ./ vol;
a34 = (-e14 .* e13 + e11 .* e34) ./ vol;

a11 = -a12 - a13 - a14;
a22 = -a12 - a23 - a24;
a33 = -a13 - a23 - a34;
a44 = -a14 - a24 - a34;

local_a = [a12; a12; a23; a23; a13; a13; a14; a14; a24; a24; a34; a34; a11; a22; a33; a44]/6;

ii = [t1; t2; t2; t3; t3; t1; t1; t4; t2; t4; t3; t4; t1; t2; t3; t4];
jj = [t2; t1; t3; t2; t1; t3; t4; t1; t4; t2; t4; t3; t1; t2; t3; t4];

S = sparse(ii,jj,double(local_a));

% Calculate mass matrix (M)
if ~lump
    b_ii = vol / 60;
    b_ij = vol / 120;
    local_b = [repmat(b_ij, 12, 1); repmat(b_ii, 4, 1)];
    M = sparse(ii, jj, double(local_b));
else
    b_ii = vol / 24;
    local_b = repmat(b_ii,4,1);
    ii = [t1; t2; t3; t4];
    M = sparse(ii, ii, double(local_b));
end

end

