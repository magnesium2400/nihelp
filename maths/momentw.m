function M = momentw(A, w, order)

if order == 1 % CENTRALIZED --> 0
    M = zeros(1, width(A));
elseif order == 2 % just variance
    M = varw(A, w);
else % Approximate by lumping
    [w, sa] = weights2spmat(w, height(A));
    B = demeanw(A, w);
    M = sum(sum(w, 2) .* (B.^order), 1) / sa;
end

end
