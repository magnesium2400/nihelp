function faces = tetrahedra2triangulation(cells)

v = @(idx) reshape(cells(:, idx), [], 1); % vectorise columns in different order
faces = [v([1,2,3,4]), v([2,1,4,3]), v([3,4,1,2])];
% faces = [reshape(cells, [], 1), reshape(cells(:, [2 1 4 3]), [], 1), reshape(cells(:, [3 4 1 2]), [], 1)];
% faces = [v(cells), v(cells(:, [2 1 4 3])), v(cells(:, [3 4 1 2]))];


end



