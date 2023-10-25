function [p,m] = plotLargestComponent(g)

[bin, binsz] = conncomp(g);
[m,ii] = max(binsz);
p = plot(subgraph(g, find(bin == ii)), 'NodeLabel', find(bin == ii));

end