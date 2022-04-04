%% label gcf(ylabel, xlabel, title)
function label(ylab, xlab, tit)
a = gca;
ylabel(a, ylab);
if nargin > 1
    xlabel(a, xlab);
end
if nargin > 2
    title(a, tit);
end
end
