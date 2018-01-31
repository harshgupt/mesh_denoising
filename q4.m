% [vertices, faces] = read_off('bumpy.off');
[vertices, faces] = ply_to_tri_mesh ( 'cow.ply' );
trisurf(faces',vertices(1,:),vertices(2,:),vertices(3,:));
axis equal;
[~, nVertices] = size(vertices);
lambda = 0.02;                                  %Assigning step size
Ident = eye(nVertices);
nIter = 100;                                    %Assigning number of iterations
newVertices = vertices';
for iter = 1:nIter
    [L,~] = calcUnifL(newVertices',faces);
    multiplier = Ident - (lambda .* L);         %Key operation 1a (Implicit)
    newVertices = multiplier \ newVertices;     %Key operation 1b (Implicit)
end
newVertices = newVertices';
figure;
trisurf(faces',newVertices(1,:),newVertices(2,:),newVertices(3,:)); %Displaying modified mesh
axis equal;