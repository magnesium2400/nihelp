function example(A,dist,hemiid,nbins)

W = mean(A > 0,3);  % consistency matrix

[G,Gc] = fcn_group_bins(A,dist,hemiid,nbins);   % run thresholding procedure

% G = distance dependent
% Gc = uniform

[N,~,NSub] = size(A);   % get dimensions
distbins = linspace(min(nonzeros(dist)),max(nonzeros(dist)),nbins + 1); % distance bins

% get histogram of connection lengths for all subjects
h = zeros(NSub + 1,nbins + 1);
for iSub = 1:NSub
    h(iSub,:) = hist(dist(triu(A(:,:,iSub) > 0)),distbins);
    h(iSub,:) = h(iSub,:)/sum(h(iSub,:));
end

% also for uniform consistency
h(NSub + 1,:) = hist(dist(triu(Gc > 0)),distbins);
h(NSub + 1,:) = h(NSub + 1,:)/sum(h(NSub + 1,:));

% also for distance-dependent
h(NSub + 2,:) = hist(dist(triu(G > 0)),distbins);
h(NSub + 2,:) = h(NSub + 2,:)/sum(h(NSub + 2,:));

% make figure
f = figure('units','inches','position',[2,2,4,2]);
ax = axes;
hold(ax,'on');

% plot histograms
ph = plot(distbins,h','color',ones(1,3)*0.75);
set(ph(NSub + 1),'color','b','linewidth',2);
set(ph(NSub + 2),'color','r','linewidth',2);

% add labels and change some axis properties
xlabel('distance (mm)');
ylabel('probability');
leg = legend(ph(end - 1:end),{'uniform','distance'});
set(gca,...
    'xlim',[min(distbins) - 0.1*range(distbins),max(distbins) + 0.1*range(distbins)],...
    'ylim',[0 - 0.1*max(h(:)),max(h(:)) + 0.1*range(h(:))]);
end