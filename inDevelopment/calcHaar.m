
function [evals, seps] = calcHaar(randomMatrix)
[~, B] = eig(randomMatrix);
evals = diag(B);
seps = (length(randomMatrix)-1) / (2*pi) * abs(diff(sort(evals)));
end
