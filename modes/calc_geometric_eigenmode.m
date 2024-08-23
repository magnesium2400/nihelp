function [surface, V, D, M, S] = calc_geometric_eigenmode(surface, k, sigma, lump, standardize)
% calc_geometric_eigenmode.m
%
% Calculate the eigenvectors (eigenmodes) and eigenvalues of the input 
% surface/volume
%
%
% Inputs: surface     : surface structure with fields
%                       'vertices' - vertex locations [Nx3], N = number of vertices
%                       'faces' - which vertices are connected [Fx3 or Fx4], F = number of faces
%         k           : number of eigenvectors to compute 
%                       [10 (default) | positive integer scalar]
%         sigma       : order of eigenvectors/eigenvalues
%                       [-0.01 (default) | scalar]
%         lump        : whether to diagonalise mass matrix 
%                       [false (default) | true]
%         standardize : whether to change modes to fit convention 
%                       [00 | 01 | 10 | 11]
%                       00 - no changes
%                       01 - flip modes' sign st first non-zero term is positive
%                       10 - fix first mode to be constant
%                       11 - 01 AND 10
%
% Outputs: surface : surface structure with fields 'evecs', 'evals', 'mass', and 'stiffness'
%          V       : eigenvectors (eigenmodes) [N x k]
%          D       : eigenvalues [k x 1]
%          M       : mass matrix [N x N]
%          S       : stiffness matrix [N x N]
%
% Original: Mehul Gajwani & Victor Barnes, Monash University, 2024


%% Prelims
if nargin < 2 || isempty(k);            k = 10;             
elseif     strcmp(k, 'all');            k = size(surface.vertices,1);   end
if nargin < 3 || isempty(sigma);        sigma = -0.01;                  end
if nargin < 4 || isempty(lump);         lump = false;                   end
if nargin < 5 || isempty(standardize);  standardize = 11;               end

if ~isfield(surface, 'mass') || ~isfield(surface, 'stiffness')
    [surface, M, S] = calc_mass_stiffness(surface, lump); 
else
    M = surface.mass; S = surface.stiffness;
end

%% Calculate modes
m = any(logical(M),2); % mask
[V, D] = eigs(S(m,m), M(m,m), k, sigma);

if mod(standardize,10) >= 1
	V = V.*arrayfun(@(ii) sign(V(find(V(:,ii),1),ii)), 1:width(V)); 
end
if mod(standardize,100) >= 10
	V(:,1) = 1/sqrt(sum(M,'all')); 
end

V = unmask(m, V, NaN); 
D = diag(D);

surface.evecs = V; 
surface.evals = D; 

end
