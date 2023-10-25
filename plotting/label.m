function label(ylab, xlab, tit)
%% LABEL apply labels to current axes
ylabel(gca, ylab);
if nargin > 1; xlabel(gca, xlab); end
if nargin > 2; title(gca, tit);   end
end
