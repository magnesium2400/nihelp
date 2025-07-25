function out = processMask(V, mask)
%% Syntax
%  out = processMask(V); % Volume must be numeric or logical
%  out = processMask(mask); % mask mask be numeric or logical
%  out = processMask(V, mask); % Volume must be numeric/logical, mask mask be function handle/numeric/logical
%
%

assert(isnumeric(V) || islogical(V));

if      nargin==1 || isempty(mask);     out = logical(V); % default to non zero values in V
elseif  isa(mask, 'function_handle');   out = mask(V);
elseif  islogical(mask);                out = mask;
elseif  isnumeric(mask);                out = logical(mask); 
    if ~isequal(logical(V),logical(mask)); warning('supplied volume and mask differ'); end
else;   error('Supplied mask must be logical matrix, numeric matrix, or function handle+volume');
end


end
