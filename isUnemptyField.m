function out = isUnemptyField(structIn, fieldName)
%ISUNEMPTYFIELD returns true iff field is present and not empty
out = isfield(structIn, fieldName) && ~isempty(structIn.(fieldName));
end
