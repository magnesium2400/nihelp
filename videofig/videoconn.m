function out = videoconn(verts, conn)

conn = logical(conn); 
assert(height(conn) == width(conn)); 
assert(height(conn) == height(verts)); 

out = videofigs(height(conn), @(x) cla, @(x) scat3(verts,'.'), @(x) hold('on'), ...
    @(x) scat3(verts(x,:), 20, 'r', 'filled'), ...
    @(x) plotLines( repmat(verts(x,:),sum(conn(x,:)), 1) , verts(conn(x,:),:)) );

end
