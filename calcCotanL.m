function L = calcCotanL(vertices,faces)

vFaceRing = compute_vertex_face_ring(faces);    %Finds neighbouring faces
vRing = compute_vertex_ring(faces);             %Finds neighbouring vertices
[~, nVertices] = size(vertices);
C = zeros(nVertices,nVertices);                 %C is the Cotan Matrix
M = zeros(nVertices,nVertices);                 %M is the Scaling Matrix
for index = 1:nVertices                         %Iterating over all vertices
    currFaces = vFaceRing{index};
    currNeighbours = vRing{index};
    %Function to find cotan values, where angle is an array of cotan values
    %for each neighbour, and totAngle is the sum of all these values. These
    %will be used to construct Laplace-Beltrami Operator
    [angle, totAngle] = calcAngles(index, currFaces, currNeighbours, faces, vertices);
    C(index,index) = -totAngle;     %Assigning diagonal elements
    [~,nFaces] = size(currFaces);
    [~,nNeighbours] = size(currNeighbours);
    for nIndex = 1:nNeighbours
        C(index,currNeighbours(nIndex)) = angle(nIndex);    %Assigning value to element at index of neighbours
    end
    A = 0;
    for face = 1:nFaces
        currFace = faces(:,currFaces(face));
        currFace = currFace(currFace~=index);
        v1 = vertices(:,currFace(1)) - vertices(:,index);
        v2 = vertices(:,currFace(2)) - vertices(:,index);
        v3 = vertices(:,currFace(2)) - vertices(:,currFace(1));
        a = norm(v1);
        b = norm(v2);
        c = norm(v3);
        s = (a+b+c) / 2;
        area = sqrt(s * (s-a) * (s-b) * (s-c));     %Finding area of triangles using Heron's Formula
        A = A + area;
    end
    A = A / 3;          %Since only the area joining the Centroids of each face is needed
    M(index,index) = (1 / (2 * A));   %Inverse matrix for Scaling
end
L = M * C;