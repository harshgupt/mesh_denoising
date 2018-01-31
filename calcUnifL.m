function [L,K] = calcUnifL(vertices,faces)

vRing = compute_vertex_face_ring(faces);    %Finding the neighbouring faces of all vertices
[~, nVertices] = size(vertices);
L = zeros(nVertices,nVertices);
K = zeros(1,nVertices);
for index = 1:nVertices                     %Iterating over each vertex
    L(index,index) = -1;                    %Assigning diagonal elements of L matrix as -1
    currFaces = vRing{index};               %Getting current neighbouring faces for current vertex
    [~,nFaces] = size(currFaces);
    currNeighbours = [];
    [theta,A] = calcThetaArea(index,currFaces,faces,vertices);  %function to calculate values of theta and area, to be used in calculation of Gaussian curvature
    K(1,index) = -(1 / (A)) * (2 * pi - theta);     %Calculating Gaussian Curvature, K
    for fIndex = 1:nFaces
        currNeighbours = [currNeighbours faces(:,currFaces(fIndex))];   %Finding all neighbouring vertices of current vertex
    end
    currNeighbours = unique(currNeighbours);        %Removing repetitions
    currNeighbours = currNeighbours(currNeighbours~=index); %Removing curretn vertex from list
    [nNeighbours,~] = size(currNeighbours);
    for n = 1:nNeighbours
        L(index,currNeighbours(n)) = 1 / nNeighbours; %Assigning value at the index of neighbour
    end
end