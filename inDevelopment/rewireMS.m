function out = rewireMS(R, n)

% R = triu(rand(10)>0.5).*rand(10); R = (R + R');

%%

out = R;

for ii = 1:n

    
[X,Y] = find( tril(out) & ~eye(size(out)) );    % list of current edges
e1 = randi([1, length(X)], 1, 1);           % choose edge 1
x = X(e1); y = Y(e1);                       % x and y coords of e1

% generate a list of possible choices for e2
% note that e1 and e2 cannot share any end vertices
% therefore, any edge that shares a vertex with e1 can be ruled out
% ~currentRow and ~currentCol rule these out
R_bin = out | eye(size(out));
currentRow = repmat( R_bin(x, :) , size(R_bin, 1),1 );
currentCol = repmat( R_bin(:, y) , 1,size(R_bin, 2) );
e2options = R_bin & ~currentRow & ~currentCol & ~eye(size(R_bin));

[P,Q] = find(e2options);                    % final list of options
e2 = randi([1, length(P)], 1, 1);           % choose edge 2
p = P(e2); q = Q(e2);

% assert( out(x,y) & out(p,q) & ~out(x,q) & ~out(p,y) );

if rand(1) > 0.5                            % choose how weights are assigned
    out(x, q) = out(x, y);
    out(p, y) = out(p, q);
else 
    out(x, q) = out(p, q);
    out(p, y) = out(x, y);
end

out(q, x) = out(x, q);                      % set trasponse edges
out(y, p) = out(p, y);
out(x, y) = 0; out(y, x) = 0;               % remove old edges
out(p, q) = 0; out(q, p) = 0;

end

% figure; subplot(2, 2, 1); imagesc(R_bin); hold on; 
% xline(y); yline(x);
% subplot(2, 2, 2); imagesc(currentRow);
% subplot(2, 2, 3); imagesc(currentCol);
% subplot(2, 2, 4); imagesc((e2options));
% subplot(2, 2, 1); xline(q); yline(p);
% subplot(2, 2, 4); imagesc(R-out);

end
