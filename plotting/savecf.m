function savecf(title, versions, resolution)
% TODO : add ability to save in a subfolder generate the paths and use
% FILEPARTS

if nargin < 2
    versions = [".fig", ".svg", ".png"];
end

if nargin < 3
    resolution = 1200; 
end

currentFolder = pwd;

for ii = versions(:)'
    
    str = "" + currentFolder + filesep +  title + (ii);
    
    if strcmp(ii, '.fig')
        savefig(gcf, str, 'compact');
        continue; 
    end

    if strcmp(ii, '.svg')
        print(gcf, '-vector', '-dsvg', str)
        continue;
    end

    try
        exportgraphics(gcf, str, 'Resolution', resolution);
    catch
        saveas(gcf, str);
    end

end

end