function out = findDependencies(filename)
out = reshape( matlab.codetools.requiredFilesAndProducts(filename) ,[],1);
end
