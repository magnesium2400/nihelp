function [verts, faces] = circleMesh(n, seed)
%% CIRCLEMESH Generates mesh of random points inside circle
%% Examples
%   v = circleMesh;
%   [v,f] = circleMesh;
%   [v,f] = circleMesh(9); figure; trimesh(f, v(:,1), v(:,2)); axis equal tight;
%   [v,f] = circleMesh(10,10); figure; trimesh(f, v(:,1), v(:,2)); axis equal tight;
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


if nargin < 1 || isempty(n);    n = 20;     end
if nargin < 2 || isempty(seed); seed = -1;  end % regular mesh by default (incorrect seed specified)


% centre and perimeter (2*n+1) points
r = n; 
v1 = [0 0];
t = (1:2*n)' / n;
v2 = r*[cospi(t), sinpi(t)];

% internal - remaining points (n^2-2*n-1)
r = r-1;
n = n^2-2*n-1;

try
    rng(seed); 
    R = r*sqrt(rand(n,1)); 
    T = rand(n,1)*2*pi;
catch
    R = r*sqrt(linspace(1/2,n-1/2,n))'/sqrt(n-1/2);
    T = 4/(1+sqrt(5))*pi*(1:n)';
end

v3 = [R.*cos(T), R.*sin(T)];
verts = [v1; v2; v3];

if nargout < 2; return; end
faces = delaunay(verts(:,1), verts(:,2)); 

end




