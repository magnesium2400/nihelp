function out = spyc(S, MarkerSize)
%% Examples
%   figure; spyc((1:9) + (1:3)');
%   figure; spyc((1:50).*(magic(50)>1500));
%   figure; nexttile; spy(magic(30)); nexttile; spyc(magic(30),'.');
%   figure; nexttile; spy(magic(30),20); nexttile; spyc(magic(30),20);

[h,w] = size(S);

if nargin < 2 || isempty(MarkerSize)
    MarkerSize = get(gcf,'defaultlinemarkersize'); % plot vs scatter marker size
elseif strcmp(MarkerSize,".")
    maxSize = max(h+1, w+1);
    MarkerSize = round(8*(log10(2500./maxSize)));
    MarkerSize = max(4, min(14, MarkerSize));
end

m = logical(S);
[y,x] = find(m);

out = scatter(x, y, MarkerSize, S(m), 'filled'); % plot vs scatter marker size

% plot(x, y, 'Marker', 'o', 'MarkerSize', MarkerSize, 'LineStyle','none', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'none');

set(gca, 'YDir', 'reverse');
xlabel(sprintf('nz = %d', nnz(m)));
axis equal; box on; xlim([0, w+1]); ylim([0, h+1]);

end
