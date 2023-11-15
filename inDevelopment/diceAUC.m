function [out, topPercentIdx, auc] = diceAUC(y, fx, thresholds)

if nargin < 3; thresholds = 0.99:-0.01:0; end

y = y(:).'; 
fx = fx(:).';

yQuant = quantile(y, thresholds);
fxQuant = quantile(fx, thresholds);

out = [];

for ii = 1:length(thresholds)
    out(ii) = 1-pdist2(double(y>=yQuant(ii)), double(fx>=fxQuant(ii)), ...
        'jaccard'); %#ok<AGROW> 
end

topPercentIdx = 1-thresholds;

auc = trapz(topPercentIdx, out - topPercentIdx);

end
