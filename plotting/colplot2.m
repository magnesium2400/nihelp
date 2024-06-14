function tl = colplot2(A, B, func)
%% COLPLOT2 Plot data for each pair of columns of an input matrix
%% Examples
%   figure; colplot2((2:2:100)'+[0 10], (1:50)'); 
%   figure; colplot2(gallery('integerdata',99,[99,4],1),(1:99)'.*((0:4)-2)); 
%   figure; colplot2(gallery('integerdata',99,[99,4],1),(1:99)'.*((0:4)-2),@(x,y)plot(x+y)); 
%   figure; colplot2(gallery('integerdata',99,[99,4],1),(1:99)'.*((0:4)-2),@(x,y)plot(x+y)); 
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


m = sz(A);
n = sz(B); 

if nargin < 3 || isempty(func); func = @(x,y) scatter(x,y); end

tl = tiledlayout(m,n); 

for ii = 1:m
    for jj = 1:n
        nexttile; 
        func(getData(B,jj), getData(A,ii));
        % if jj == 1; ylabel(labels{ii}); end
        % if ii == n; xlabel(labels{jj}); end
        % if ii ~= n; xticks([]); end
        % if jj ~= 1; yticks([]); end
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

