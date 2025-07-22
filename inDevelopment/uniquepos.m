function [C,ia,ic] = uniquepos(A, setOrder)
if nargin<2 || isempty(setOrder); setOrder = 'sorted'; end
[C,~,ic] = unique(A, setOrder); 
ia = splitapply(@(x) {x}, reshape(1:numel(A), size(ic)), ic); 
% ia = arrayfun(@(x) find(ic==x), 1:max(ic), 'Uni', 0); 
end
