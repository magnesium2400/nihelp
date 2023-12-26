function out = countNaturals(x)
out = histcounts( x , (0:max(x, [], 'all'))+0.5 );
end