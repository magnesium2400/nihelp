function leg = raincloud_legend(labels, legendOptions)

if nargin < 2; legendOptions = {}; end

newLeg = repmat({''}, 5, length(labels));
newLeg(2,:) = labels;

leg = legend(newLeg{:}, legendOptions{:});

end
