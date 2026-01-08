function [X,mask] = zero2nan(X)
%% Examples
%   zero2nan(1:4)
%   zero2nan(0:4)
%   zero2nan([1:4, NaN])
%   
%   zero2nan(pascal(4)-1)+1
%   zero2nan(mod(magic(4), 2))
%
%

%% Main
% Can't directly use `logical` as that fails if input has any NaNs
mask = ~isnan(X);                        % First find the non-nan values
mask(logical(mask)) = ~logical(X(mask)); % Find which of these are zero
X(mask) = NaN; 
end
