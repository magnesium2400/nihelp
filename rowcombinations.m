function out = rowcombinations(varargin)
%% Examples
% Show functions
%   rowcombinations([1;2], [1;2;3])
%   rowcombinations([1;2], [1,2,3])
%   rowcombinations([1,2], [1;2;3])
%   rowcombinations([1,2], [1,2,3])
%
%   rowcombinations([1 2; 3 4], [5], [6 7 8 9])
%   rowcombinations([1 2; 3 4], [5], [6 7; 8 9])
%   rowcombinations([1 2; 3 4], [5; 6], [7; 8; 9])
%
% Show functions with names
%   a = [1;2]; b = [1;2;3]; rowcombinations(a, b)
%   a = [1;2]; b = [1,2,3]; rowcombinations(a, b)
%   a = [1,2]; b = [1;2;3]; rowcombinations(a, b)
%   a = [1,2]; b = [1,2,3]; rowcombinations(a, b)
%
% More name examples
%   b = [1;2;3]; rowcombinations([1;2], b)
%   b = [1;2;3]; rowcombinations([1,2], b)
%   a = [1;2;3]; rowcombinations(a, [1;2])
%   a = [1;2;3]; rowcombinations(a, [1,2])
%   a = [1;2;3]; rowcombinations(a, 1, 2)
%
%

%% Prelims
assert(all( cellfun(@ismatrix, varargin) ));
h = cellfun(@height, varargin);
w = cellfun(@width, varargin);

%% Calculate combinations for dummy row indices
n = arrayfun(@(n) (1:n)', h, 'Uni', 0);
c = combinations(n{:});

%% Use c to get data
mat = nan(prod(h), sum(w));
idx = [0,cumsum(w)];
for ii = 1:length(w)
    mat(:, idx(ii)+1:idx(ii+1)) = varargin{ii}(c{:,ii},:);
end

%% Generate variable names
varNames = cell(1, width(mat));
for ii = 1:nargin
    currName = inputname(ii);
    if isempty(currName); currName = sprintf('Var%i', ii); end
    if w(ii) == 1
        varNames{idx(ii)+1:idx(ii+1)} = currName;
    else%if w(ii) ~= 1
        currName = arrayfun(@(n) sprintf('%s_%i', currName,n), 1:w(ii), 'Uni', 0);
        varNames(idx(ii)+1:idx(ii+1)) = currName;
    end
end
out = array2table(mat, 'VariableNames', varNames);


end
