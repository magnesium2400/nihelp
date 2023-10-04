function out = colfunc(func, data)
out = arrayfun( @(x) func(data(:,x)) , 1:size(data,2) );
end
