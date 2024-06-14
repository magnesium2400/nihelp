function tl = diffplot(X, func, labels) %#ok<INUSD>
%% DIFFPLOT Plot variable differences
%% Examples
%   figure; diffplot(magic(4)); 
%   figure; diffplot(sort(rand(100,4))); 
%   figure; diffplot(sort(rand(100,4)), @(x)scatter(1:numel(x),x,'.')); 
%   figure; diffplot({hilb(4),magic(4),pascal(4),wilkinson(4)}, @imagesc); 
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

tl = colplot(X, @bar, @(x,y) plot(x-y)); 

% % % % % % n = sz(X); 
% % % % % % 
% % % % % % if nargin < 2 || isempty(func);   func = @plot; end
% % % % % % if nargin < 3 || isempty(labels); labels = arrayfun(@(x) "var"+string(x), 1:n, 'uni', 0); end
% % % % % % 
% % % % % % tl = tiledlayout(n,n); 
% % % % % % 
% % % % % % for ii = 1:n
% % % % % %     for jj = 1:n
% % % % % %         nexttile; 
% % % % % %         if ii == jj; func(getData(X,ii));
% % % % % %         else; func(getData(X,jj) - getData(X,ii)); end
% % % % % %         if jj == 1; ylabel(labels{ii}); end
% % % % % %         if ii == n; xlabel(labels{jj}); end
% % % % % %     end
% % % % % % end
% % % % % % 
% % % % % % 
% % % % % % end
% % % % % % 
% % % % % % 
% % % % % % function s = sz(X)
% % % % % %     if iscell(X);   s = length(X);
% % % % % %     else;           s = width(X);   end
% % % % % % end
% % % % % % 
% % % % % % function g = getData(X,ii)
% % % % % %     if iscell(X);   g = X{ii};
% % % % % %     else;           g = X(:,ii);    end
% % % % % % end
% % % % % % 



