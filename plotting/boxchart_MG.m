function [b,p] = boxchart_MG(xgroupdata, ydata, linesOn)

if isempty(xgroupdata); xgroupdata = reshape(repmat(1:width(ydata),height(ydata),1),[],1); end
if nargin < 3; linesOn = true; end

%% separate
[groupIds, groupNames] = findgroups(xgroupdata);

%% draw lines between adjacent sets of data
p = []; 
if ( (linesOn) && (max(groupIds) > 1) )
    try % if data are not matched, continue without trying to plot lines
        splitData = [];
        for ii = 1:max(groupIds)
            splitData = [splitData, ydata(groupIds == ii)]; %#ok<AGROW>
        end
        hold on;
        p = plot(splitData', 'Color', [0.85 0.85 0.85]);
    catch
    end
end


%% plot boxchart
for ii = 1:max(groupIds)
    b(ii) = boxchart(ii*ones(height(ydata),1), ydata(groupIds==ii), 'BoxFaceColor', int2color(ii)); 
end

% b = boxchart(groupIds, ydata(:));

%% format x labels
% xticklabels(groupNames);
xt = xticks;
xt(xt == 0) = [];
xt(xt > length(groupNames)) = [];
xt(mod(xt, 1) ~= 0) = [];
xticks(xt);
xticklabels(groupNames(xt));



end
