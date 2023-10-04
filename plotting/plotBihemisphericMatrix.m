function plotBihemisphericMatrix(lh, rh, matrixData, varargin)

%%
ip = inputParser;
addRequired(ip, 'lh');
addRequired(ip, 'rh');
addRequired(ip, 'matrixData');

addParameter(ip, 'matrixFunction', @(x) sum(x, 1), @(x) isa(x, 'function_handle'));
addParameter(ip, 'plotBrainOptions', {}, @iscell);

ip.parse(lh, rh, matrixData, varargin{:});
lh = ip.Results.lh;
rh = ip.Results.rh;
matrixData = ip.Results.matrixData;
matrixFunction = ip.Results.matrixFunction;

%%

lh{end+1} = reshape(matrixFunction(matrixData)  , [], 1);
rh{end+1} = reshape(matrixFunction(matrixData).', [], 1);

plotBrain('lh', lh, 'rh', rh, ip.Results.plotBrainOptions{:});

end