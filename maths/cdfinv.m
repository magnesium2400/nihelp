function out = cdfinv(xi, cdfx, yq, useSmallest)
%% Examples
%   cdfinv([1 2 3], [0 0.5 1], 0.8)
%   cdfinv([10 20 30], [0 0.5 1], 0.8)
%
%   cdfinv([1 2 3 4 5], [0 0 0.5 1 1], 0:0.25:1)
%   cdfinv([1 2 3 4 5], [0 0 0.5 1 1], 0:0.25:1, true)
%   cdfinv([1 2 3 4 5], [0 0 0.5 1 1], 0:0.25:1, false)
%
%
%
%
%


%% Prelims
assert(issorted(xi, 'strictascend'), 'x terms must be strictly increasing');
assert(issorted(cdfx, 'ascend'), 'cdf terms must be non-descreasing');
assert(all(cdfx>=0), 'cdf terms must be >= 0');
assert(all(cdfx<=1), 'cdf terms must be <= 1');

% By default, x is the smallest value s.t. f(x) >= p
% $F^{-1}(p) = \inf \{ x \in \mathbb{R} : F(x) \geq p \}, \forall p \in [0,1]$
% as per https://en.wikipedia.org/wiki/Cumulative_distribution_function
if nargin<4 || isempty(useSmallest); useSmallest = true; end
% This can/should(?) be changed if finding the inverse of 0 ie. what is the
% last zero value/first non-zero value

out = nan(size(yq), 'like', xi); 


%% Main
% Lots of room to improvement performance here if needed :)
for ii = 1:length(yq)
    li = find(cdfx<=yq(ii), 1, 'last' );
    ui = find(cdfx>=yq(ii), 1, 'first');

    if isempty(ui) || isempty(li)
        out(ii) = NaN;
    elseif cdfx(ui) ~= cdfx(li)
        out(ii) = interp1(cdfx([li,ui]), xi([li,ui]), yq(ii));
    elseif useSmallest
        out(ii) = xi(ui);
    else
        out(ii) = xi(li); 
    end
end


end
