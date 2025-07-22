function out = processMask(V, mask)
%% Syntax
%  out = processMask(V); % Volume must be numeric or logical
%  out = processMask(mask); % mask mask be numeric or logical
%  out = processMask(V, mask); % Volume must be numeric/logical, mask mask be function handle/numeric/logical
%
%

assert(isnumeric(V) || islogical(V));

if nargin==1
    out = logical(V);
end

if nargin==2
    if      isa(mask, 'function_handle');   out = mask(V);
    elseif  isnumeric(mask);                out = logical(mask);
    elseif  islogical(mask);                out = mask;
    else;   error('Supplied mask must be logical matrix, numeric matrix, or function handle+volume');
    end
end


end
