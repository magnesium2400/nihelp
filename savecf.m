function savecf(title, versions)
% TODO : add ability to save in a subfolder generate the paths and use
% FILEPARTS

if nargin < 2
    versions = [".fig", ".svg", ".png"];
end

currentFolder = pwd;

for ii = 1:length(versions)
    saveas(gcf, "" + currentFolder + filesep +  title + versions(ii));
end

end