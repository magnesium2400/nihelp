function out = processMask(V, mask)
% Converts a numeric or logical volume into a logical array,
% or apply a mask to the volume.
%
% Inputs:
%   V     - A numeric or logical array representing the volume.
%   mask  - (Optional) A numeric or logical array or a function handle 
%           that defines the mask to be applied to the volume.
%
% Outputs:
%   out   - A logical array resulting from the processing of the volume 
%           and mask.
%


assert(isnumeric(V) || islogical(V));

if nargin==1
    out = logical(V);
end

if nargin==2
    if isempty(mask)
        out = logical(V);
    elseif isa(mask, 'function_handle')
        out = mask(V);
    elseif isnumeric(mask)
        out = logical(mask);
    elseif islogical(mask)
        out = mask;
    else
        error('Supplied mask must be logical matrix, numeric matrix, or function handle+volume');
    end
end


end
