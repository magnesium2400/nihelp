function [out,f2] = meshDelineate0(f, data)

sgns = sign(data(f)); 
mask = any(~sgns, 2) | any(diff(sgns,1,2),2); 

f2 = f(~mask,:);
e2 = [f2(:), reshape(f2(:,[2 3 1]),[],1)];
g = graph(e2(:,1), e2(:,2)); 

out = conncomp(g)'; 

end
