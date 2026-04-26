function out = dirichlete(data, stiffness)
out = dot(data, stiffness * data, 1); 
end
