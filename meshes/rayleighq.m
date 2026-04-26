function out = rayleighq(data, mass, stiffness)
out = dirichlete(data, stiffness) ./ ssqw(data, mass); 
end
