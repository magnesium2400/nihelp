function [out, filepath, filename] = getCurrentMd5sum(varargin)

ip = inputParser;
ip.addParameter('filename', []);
ip.addParameter('saveFile', false);
ip.parse(varargin{:});

if isempty(ip.Results.filename)
    temp = dbstack();
    filename = temp(end).file;
else
    filename = ip.Results.filename;
end

fprintf("Returning checksum for file %s\n", filename);

filepath = which(filename, '-all');
if length(filepath) > 1; warning('more than 1 file with current name found: '); disp(filepath); end
out = md5sum(filepath{1});

if ip.Results.saveFile
    writelines(readlines(filepath{1}), sprintf('%s_%s', filepath{1}, out));
    fprintf('Saved copy at %s_%s\n', filepath{1}, out);
end


end