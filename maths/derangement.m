function out = derangement(n, seed)
%% DERANGEMENT Returns a permutation where no element is in original position
%% Examples
%   derangement(10)
%   derangement(10,10)
%   out = cell2mat(arrayfun(@(x) derangement(4,x), (1:1000)', 'Uni', 0)); [C,~,ic] = unique(out, 'rows'); figure; histogram(ic, (0:height(C))+0.5);
% 
% 
%% TODO
% * docs
% 
% 
%% See Also
% Martínez, Conrado, Alois Panholzer, and Helmut Prodinger. "Generating Random
% Derangements." ANALCO. 2008
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

%% Prelims
if nargin > 1 && ~isempty(seed); rng(seed); end
D = @(n) floor( (factorial(n)+1)/exp(1) ); % subfactorial

out = 1:n;
mark = false(1,n); 


%% Algorithm as described in paper
ii = n; u = n;                                          % start at end of list
while u >= 2
    if ~mark(ii)                                        % if current element unmarked
        jj = datasample(setdiff(1:ii-1,find(mark)),1);  % choose another unmarked, earlier element
        [out(ii), out(jj)] = deal(out(jj), out(ii));    % swap those two elements
        p = rand < (u-1)*D(u-2)/D(u);
        mark(jj) = p;                                   % prevent further swaps with specified probability
        u = u - 1 - p;
    end
    ii = ii-1;                                          % keep reversing through list
end


end

