
function [evals, seps] = calcHaar(randomMatrix)
[~, B] = eig(randomMatrix);
evals = cart2pol(real(diag(B)), imag(diag(B)));
seps = (length(randomMatrix)-1) / (2*pi) * abs(diff(sort(evals)));
end
