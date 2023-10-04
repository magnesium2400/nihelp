function label(ylab, xlab, tit)
%% LABEL apply labels to current axes
ylabel(gca, ylab);
if nargin > 1; xlabel(a, xlab); end
if nargin > 2; title(a, tit);   end
end
