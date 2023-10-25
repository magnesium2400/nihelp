function addScatterLabels(s, labels, labelName)

if nargin < 2; labels = (1:length(s.XData)); end
if nargin < 3; labelName = 'Node ID'; end

if iscell(labels)
    for ii = 1:length(labels)
        s.DataTipTemplate.DataTipRows(end+1) = ...
            dataTipTextRow(labelName{ii}, labels{ii});
    end
else
    s.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow(labelName, labels);
end

end