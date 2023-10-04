%% matching index test/examples

%% prelims
n = 200; 

rng('default'); 

%% make dummy data
temp = reshape(randperm(n^2), [n, n]) < (n*(n-1))/2;
A = (temp|temp') .* ~eye(size(temp));
fprintf('simulated binary adj matrix, density %f\n', density_und(A))
imagesc(A)

disp('simulated graph')
G = graph(A)
plot(G)

%% using BCT
addpath(genpath("/fs03/kg98/mehul/REPOS_OFFLINE/BCT"));
% need to add your BCT to path
% this uses their implementation
mi1 = matching_ind_und(A);

%% using custom function

% using custom function to get num and denom
% custom function which also returns numerator and denominator
[mi, num, denom] = getMatchingIndex_bin(A);
imagesc(mi); title('matching index');

fprintf('Are algorithms equal? %d\n', isequal(mi,mi1));


%% compare times
tBCT =  timeit(@() matching_ind_und(A));
tMG = timeit(@() getMatchingIndex_bin(A));

fprintf('BCT time %f\n', tBCT);
fprintf('MG time %f\n', tMG);
fprintf('MG is %f times as fast as BCT\n', tBCT/tMG);
