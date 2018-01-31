% [vertices, faces] = read_off('bumpy.off');
[vertices, faces] = ply_to_tri_mesh ( 'cow.ply' );
% trisurf(faces',vertices(1,:),vertices(2,:),vertices(3,:));
% axis equal;
ptCloudOld = pointCloud(vertices');             %Converting to point cloud to get structure containg limits as well as locations
sigma = 0.01;                                    %Assigning deviation
noisyVertices = addNoise(ptCloudOld,sigma);     %Adding noise to the mesh (makes use of point cloud)
noisyVertices = noisyVertices';
trisurf(faces',noisyVertices(1,:),noisyVertices(2,:),noisyVertices(3,:));
axis equal;
[~, nVertices] = size(noisyVertices);
lambda = 0.02;                                  %Assigning step size
Ident = eye(nVertices);
nIter = 100;                                    %Assigning number of iterations
newVertices = noisyVertices';
for iter = 1:nIter
    [L,~] = calcUnifL(newVertices',faces);
%     multiplier = Ident + (lambda .* L);       %Using Explicit Smoothing
%     newVertices = multiplier * newVertices;
    multiplier = Ident - (lambda .* L);         %Using Implicit Smoothing
    newVertices = multiplier \ newVertices;
end
figure;
newVertices = newVertices';
trisurf(faces',newVertices(1,:),newVertices(2,:),newVertices(3,:)); %Display de-noised (smoothed) mesh
axis equal;