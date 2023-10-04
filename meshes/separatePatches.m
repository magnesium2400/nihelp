function varargout = separatePatches(data, varargin)
%SEPARATEPATCHES Separates verts and faces into two distinct patches
%   Inputs: any of:
%           - a struct that contains vertices, and potentially faces and
%           rois; OR
%           - a v*3 matrix of vertices only; OR
%           - a v*3 matrix of vertices and an f*3 matrix of faces; OR
%           - a v*3 matrix of vertices, an f*3 matrix of faces, and a v*1
%           vector of roi allocations
%           Optionally:
%           - 'SeparatingFunction', a function handle to a function that is 
%            used to separate thesets of vertices
%   Outputs: depends on the number of outputs requested
%           2. two structs containing vertices and faces, and potentially
%           rois
%           4. verts1, faces1, verts2, faces2
%           6. verts1, faces1, rois1, verts2, faces2, rois2

% prelims
ip = inputParser;
addRequired(ip, 'data');
addOptional(ip, 'faces', []);
addOptional(ip, 'rois', []);
addParameter(ip, 'SeparatingFunction', @(x) x(:, 1) < 0);
parse(ip, data, varargin{:});

% parse inputs based on whether first input is a struct
if (class(ip.Results.data) == "struct")
    verts = ip.Results.data.vertices;
    faces = getFieldIfPresent(ip.Results.data, 'faces');
    rois = getFieldIfPresent(ip.Results.data, 'rois');
else % otherwise, first input is the verts
    verts = ip.Results.data;
    faces = ip.Results.faces;
    rois = ip.Results.rois;
end

% check verts
dataFor1 = logical(ip.Results.SeparatingFunction(verts));

% separate verts and faces
if ~isempty(faces)
    [verts1, faces1] = surfKeepCortex(verts, faces, dataFor1);
    [verts2, faces2] = surfKeepCortex(verts, faces, ~dataFor1);
else
    verts1 = verts(dataFor1, :);
    verts2 = verts(~dataFor1, :);
    faces1 = [];
    faces2 = [];
end

% separate rois
if ~isempty(rois)
    rois1 = rois(dataFor1);
    rois2 = rois(~dataFor1);
else
    rois1 = [];
    rois2 = [];
end

% output
if nargout <= 2
    varargout{1} = struct('vertices', verts1, 'faces', faces1, 'rois', rois1);
    varargout{2} = struct('vertices', verts2, 'faces', faces2, 'rois', rois2);
elseif nargout <= 4
    varargout{1} = verts1;
    varargout{2} = faces1;
    varargout{3} = verts2;
    varargout{4} = faces2;
elseif nargout <= 6
    varargout{1} = verts1;
    varargout{2} = faces1;
    varargout{3} = rois1;
    varargout{4} = verts2;
    varargout{5} = faces2;
    varargout{6} = rois2;
end

end