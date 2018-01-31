[vertices, faces] = read_off('bumpy.off');
% trisurf(faces',vertices(1,:),vertices(2,:),vertices(3,:));
% axis equal;                   %To view the original mesh
[L,K] = calcUnifL(vertices,faces);      %Function to calculate L with Uniform Discretization and Gaussian Curvature K
[~, nVertices] = size(vertices);
delX = L * vertices';
for index = 1:nVertices                 %Normalising each row of the matrix
    modX(index) = norm(delX(index,:));
end
H = modX ./ 2;
[normals,~] = compute_normal(vertices,faces);   %Computing normals to check consistency with direction of H
for index = 1:nVertices
    if dot(normals(:,index),delX(index,:)') < 0
        H(index) = -H(index);                   %H is the Mean Curvature
    end
end
trisurf(faces',vertices(1,:),vertices(2,:),vertices(3,:),H);    %Using trisurf to display mesh with colour interpolation using values of H
axis equal;
figure;
trisurf(faces',vertices(1,:),vertices(2,:),vertices(3,:),K);    %Using trisurf to display mesh with colour interpolation using values of K
axis equal;