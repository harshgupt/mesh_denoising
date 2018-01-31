[vertices, faces] = read_off('bumpy.off');
% trisurf(faces',vertices(1,:),vertices(2,:),vertices(3,:));
% axis equal;
L = calcCotanL(vertices,faces);     %Function to calculate L using Cotan Discretization
[~, nVertices] = size(vertices);
delX = L * vertices';
for index = 1:nVertices
    modX(index) = norm(delX(index,:));
end
H = modX ./ 2;
[normals,~] = compute_normal(vertices,faces);
for index = 1:nVertices
    if dot(normals(:,index),delX(index,:)') < 0
        H(index) = -H(index);       %H is the mean curvature
    end
end
trisurf(faces',vertices(1,:),vertices(2,:),vertices(3,:),H);
axis equal;