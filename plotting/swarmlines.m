function out = swarmlines(varargin)
%% Examples
%   figure; swarmlines(repmat(1:2,1000,1),randn(1000,2)+(1:2)); 
%   figure; swarmlines(repmat(1:5,100,1),randn(100,5)+(1:5)); 
%   figure; swarmlines(repmat(1:5,100,1),randn(100,5)+(1:5), 30, 'r', '.'); 
%
%
%


%% Plot original swarm chart
s = swarmchart(varargin{:}); 
out = gobjects(1,length(s)*2-1); 
out(1:2:end) = s; 


%% Convert to struct data in order to get the locations of the jittered points
% Requires some warnings to be turned off
wstructs = arrayfun(@(x) warning('query', x), ...
    ["MATLAB:hg:EraseModeIgnored", "MATLAB:structOnObject"]); 

arrayfun(@(x) warning('off', x.identifier), wstructs); 
d = arrayfun(@struct, s); 
arrayfun(@(x) warning(x), wstructs); 


%% Plot the lines
ax = s(1).Parent; 
ih = ishold(ax); 
hold(ax,'on');
for ii = 1:length(d)-1
    src = [d(ii).XData(:), d(ii).YData(:)]+d(ii).XYZJitter(:,1:2);
    tgt = [d(ii+1).XData(:), d(ii+1).YData(:)]+d(ii+1).XYZJitter(:,1:2);
    x = [src(:,1), tgt(:,1), nan(height(src),1)].'; 
    y = [src(:,2), tgt(:,2), nan(height(src),1)].'; 
    out(2*ii) = plot(x(:), y(:), 'Color', [0 0 0 0.1]);
end
if ~ih; hold(ax,'off'); end


end

