function [theta,A] = calcThetaArea(vertex,faces,allFaces,allVertices)

[~,nFaces] = size(faces);
A = 0;
theta = 0;
for fIndex = 1:nFaces           %Iterating for all neighbouring faces
    currFace = allFaces(:,faces(fIndex));   %Getting current face information
    currFace = currFace(currFace~=vertex);  %Removing initial vertex from current face
    v1 = allVertices(:,currFace(1)) - allVertices(:,vertex); %Finding vectors between points of current face
    v2 = allVertices(:,currFace(2)) - allVertices(:,vertex);
    v3 = allVertices(:,currFace(2)) - allVertices(:,currFace(1));
    theta = theta + acos(dot(v1,v2) / (norm(v1) * norm(v2)));   %Finding value of theta using dot product
    a = norm(v1);       %Finding distances between points
    b = norm(v2);
    c = norm(v3);
    s = (a+b+c) / 2;
	area = sqrt(s * (s-a) * (s-b) * (s-c));     %Using Heron's Formula to find area
    A = A + area;
end
A = A / 3;      %Since only the area joining the Centroids of each face is needed