function tl = colplot(X, func1, func2)
%% COLPLOT Plot data for each pair of columns of an input matrix
%% Examples
%   figure; colplot(sort(gallery('integerdata',99,[99,5],1))-(0:25:100));
%   figure; colplot(sort(gallery('integerdata',99,[99,5],1))-(0:25:100), @bar);
%   figure; colplot(sort(gallery('integerdata',99,[99,5],1))-(0:25:100), @bar, @(x,y) plot(x-y));
%   figure; colplot({hilb(4),magic(4),pascal(4),wilkinson(4)}, @imagesc, @(x,y) imagesc(x-y)); 
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


n = sz(X); 

if nargin < 2 || isempty(func1); func1 = @(x)   histogram(x);       end
if nargin < 3 || isempty(func2); func2 = @(x,y) scatter(x,y,'.');   end

tl = tiledlayout(n,n); 

for ii = 1:n
    for jj = 1:n
        nexttile; 
        if ii == jj; func1(getData(X,ii));
        else; func2(getData(X,jj), getData(X,ii)); end
        % if jj == 1; ylabel(labels{ii}); end
        % if ii == n; xlabel(labels{jj}); end
    end
end


end


function s = sz(X)
    if iscell(X);   s = length(X);
    else;           s = width(X);   end
end

function g = getData(X,ii)
    if iscell(X);   g = X{ii};
    else;           g = X(:,ii);    end
end

