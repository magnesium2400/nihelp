function out = multi_cmap(initial, color1, middle, color2, final)

cmap1 = make_cmap(color1, 250*(middle-initial)/(final-initial), 30,0);
cmap2 = make_cmap(color2, 250*(final-middle)  /(final-initial), 30,0);

out = [(cmap1); flipud(cmap2)];
end
