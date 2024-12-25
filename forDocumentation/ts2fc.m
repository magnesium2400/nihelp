function out = ts2fc(ts)

out = 1-squareform(pdist(ts, 'correlation')); 
out(out>1) = 1; 
out(out<-1) = -1; 

end
