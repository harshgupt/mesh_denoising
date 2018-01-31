function [angle,totAngle] = calcAngles(vertex, faces, neighbours, allFaces, allVertices)

%This function first finds pairs of adjacent faces by finding those faces 
%in the set of neighbouring faces, which have two vertices in common (one 
%of which is the initial vertex)

[~, fSize] = size(faces);
[~, nSize] = size(neighbours);
currFaces = [];
currNeighbours = [];
angle = [];
totAngle = 0;
vertex1 = allVertices(:,vertex);    %Getting current vertex coordinates
for fIndex = 1:fSize
    currFaces = [currFaces allFaces(:, faces(fIndex))]; %Finding current neighboouring faces
end
for nIndex = 1:nSize            %Iterating over neighbours
    facePair = [];
    vertex2 = allVertices(:,neighbours(nIndex));        %Getting current neighbour coordinates
    for y = 1:fSize
        for x = 1:3
            if currFaces(x,y) == neighbours(nIndex)     %If the face contains the current neighbour, add it to the facepair array
                facePair = [facePair currFaces(:,y)];
            end
        end
    end
    face1 = facePair(:,1);
    face2 = facePair(:,2);
    face1 = face1(face1~=neighbours(nIndex));   %Removing the current neighbour to get the last vertex in face 1
    face1 = face1(face1~=vertex);
    face2 = face2(face2~=neighbours(nIndex));   %Removing the current neighbour to get the last vertex in face 2
    face2 = face2(face2~=vertex);
    vertex3 = allVertices(:,face1);             %Getting vertex 3 coordinates
    vertex4 = allVertices(:,face2);             %Getting vertex 4 coordinates
    v1 = vertex1 - vertex3;                     %Finding vectors, to be used to find angle alpha
    v2 = vertex2 - vertex3;
    alpha = acos(dot(v1,v2) / (norm(v1) * norm(v2)));
    v1 = vertex1 - vertex4;                     %Finding vectors, to be used to find angle beta
    v2 = vertex2 - vertex4;
    beta = acos(dot(v1,v2) / (norm(v1) * norm(v2)));
    alpha = cot(alpha);                         %Finding cotan of the angles
    beta = cot(beta);
    angle = [angle (alpha+beta)];               %storing Cot(alpha) + Cot(beta) in an array to be returned
    totAngle = totAngle + alpha + beta;         %Sum of all Cotan values for current vertex
end