function [evals, seps] = haarO(Q)
B = eig(Q);
evals = sort(angle(B));
seps = (length(evals)) / (2*pi) * diff(evals);
end
