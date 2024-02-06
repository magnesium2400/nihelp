function out = existAll(cellOfNames, searchType)
out = all(cellfun(@(x) evalin("base", ['exist("',x,'", "',searchType,'")']), cellOfNames));
end
