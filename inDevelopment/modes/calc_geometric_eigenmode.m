function [surface, V, D, M, S] = calc_geometric_eigenmode(surface, k, sigma, lump)
% calc_geometric_eigenmode.m
%
% Calculate the eigenvectors (eigenmodes) and eigenvalues of the input 
% surface/volume
%
%
% Inputs: surface : surface structure with fields
%                   'vertices' - vertex locations [Nx3], N = number of vertices
%                   'faces' - which vertices are connected [Fx3 or Fx4], F = number of faces
%         k       : number of eigenvectors to compute 
%                   [10 (default) | positive integer scalar]
%         sigma   : order of eigenvectors/eigenvalues
%                   [-0.01 (default) | scalar]
%         lump    : whether to diagonalise mass matrix 
%                   [false (default) | true]
%
% Outputs: surface : surface structure with fields 'evecs', 'evals', 'mass', and 'stiffness'
%          V       : eigenvectors (eigenmodes) [N x k]
%          D       : eigenvalues [k x 1]
%          M       : mass matrix [N x N]
%          S       : stiffness matrix [N x N]
%
% Original: Mehul Gajwani & Victor Barnes, Monash University, 2024


%% Prelims
if nargin < 2 || isempty(k);        k = 10;         end
if nargin < 3 || isempty(sigma);    sigma = -0.01;  end
if nargin < 4 || isempty(lump);     lump = false;   end


if ~isfield(surface, 'mass') || ~isfield(surface, 'stiffness')
    [surface, M, S] = calc_mass_stiffness(surface, lump); 
end

[V, D] = eigs(surface.stiffness, surface.mass, k, sigma);
D = diag(D);

surface.evecs = V; 
surface.evals = D; 


end
