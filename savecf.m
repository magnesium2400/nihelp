function savecf(title, versions)
if nargin < 2
    versions = [".fig", ".svg", ".png"];
end

currentFolder = pwd;

for ii = 1:length(versions)
    saveas(gcf, currentFolder + "\" +  title + versions(ii));
end

end