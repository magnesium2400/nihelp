function out = colfunc(func, A)
try out = arrayfun( @(x) func(A(:,x)) , 1:size(A,2) );
catch; out = cell2mat(arrayfun( @(x) reshape(func(A(:,x)), [], 1) , 1:size(A,2), 'UniformOutput', false)); end
end
