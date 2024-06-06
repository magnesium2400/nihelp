%% CUBICHARMONICS Shows eigenmodes on surface of cube
%% Input Arguments
% `edgeLength - edge of cube (positive integer scalar)`
% 
% `nModes - number of modes (positive integer scalar)`
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%

%%% User inputs
edgeLength = 40; 
nModes = 25; 

%%% Calc modes
[v,f] = cuboidSurface(edgeLength);
s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), nModes);

%%% Plot
figure;
for ii = 1:width(s.evecs) 
    nexttile;  
    patch('vertices', v, 'faces', f, 'FaceVertexCData', s.evecs(:,ii), 'EdgeColor', 'interp', 'FaceColor', 'none'); 
    axis equal tight off; view(3); 
end
