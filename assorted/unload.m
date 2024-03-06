function varNames = unload(dataname)

varNames = fieldnames(load(dataname)); 
for ii = 1:length(varNames)
    evalin('base', sprintf("clear('%s')", varNames{ii}));
end    
if nargout == 0; clear varNames; end

end
