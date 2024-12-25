function out = meshNoise(v,f,varargin)

ip = inputParser;
ip.addParameter('seed', []); 
ip.addParameter('nModes', 10); 
ip.addParameter('alpha', 2); 
ip.addParameter('time', 100); 
ip.parse(varargin{:}); 
ipr = ip.Results; 

n = noise('powerlaw1', struct('seed', ipr.seed, 'sz', [ipr.nModes, ipr.time], 'alpha', ipr.alpha));
s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f)); 
out = s.evecs * (s.evals .* n); 

end
