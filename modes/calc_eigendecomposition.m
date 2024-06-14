function coeffs = calc_eigendecomposition(data, eigenvectors, method, params)
% calc_eigendecomposition.m
%
% Decompose data using eigenvectors and calculate the coefficient of 
% contribution of each vector
%
% Inputs: data         : data [MxP]
%                        M = number of points, P = number of independent data
%         eigenvectors : eigenvectors [MxN]
%                        M = number of points, N = number of eigenvectors
%         method       : type of calculation
%                        'orthogonal', 'matrix', 'matrix_separate', 'regression'
%         params       : further data required for decomposition
%                        for the 'orthogonal' method, this should be the mass matrix (M) or a struct with a field 'mass'  
% Output: coeffs       : coefficient values [NxP]
%
% Original: James Pang, Monash University, 2022
% Revised: Mehul Gajwani, Monash University, 2024


%% Prelims
[~,P] = size(data);

if isa(eigenvectors, 'struct'); eigenvectors = eigenvectors.evecs; end
if  nargin<3 || isempty(method); method = 'matrix'; end
if (nargin<4 || isempty(params)) && strcmp(method, 'orthogonal')
    error('BrainEigenmodes:Eigendecomposition:NoMassMatrix', 'Must supply mass matrix if using orthogonal method'); 
end 

%%% WARN IF `eigenvectors` DOES NOT CONTAIN A COLUMN OF CONSTANTS %%%
if ~strcmp(method, 'orthogonal') && ~any(all(eigenvectors == eigenvectors(1,:),1),2)
    warning('BrainEigenmodes:Eigendecomposition:NoCostantEigenvector', ...
        '`eigenvectors` should contain a constant eigenvector');
end


%% Calculations
switch method
    case 'orthogonal'
        if isa(params, 'struct'); coeffs = eigenvectors.' * params.mass * data;
        else;                     coeffs = eigenvectors.' * params * data; end
    case 'matrix'
        coeffs = (eigenvectors.'*eigenvectors)\(eigenvectors.'*data);
    case 'matrix_separate'
        coeffs = zeros(size(eigenvectors, 2),P);
        
        for p = 1:P
            coeffs(:,p) = (eigenvectors.'*eigenvectors)\(eigenvectors.'*data(:,p));
        end
    case 'regression'
        coeffs = zeros(size(eigenvectors, 2),P);
        
        for p = 1:P
            coeffs(:,p) = regress(data(:,p), eigenvectors);
        end
end
    
end
