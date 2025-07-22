function out = niftitform(path)
out = niftiinfo(path).Transform.T; 
end