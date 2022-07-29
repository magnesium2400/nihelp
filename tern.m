function out = tern(condition, trueResult, falseResult)
%TERN Ternary operator
out = falseResult;
if condition; out = trueResult; end
end

