%  % from left to right: id, parent, g, h, f
%  graph = [
%      1 1 0 8.7 8.7;
%      2 2 0 8.5 8.5;
%      3 3 0 8.1 8.1;
%      4 4 0 5.3 5.3;
%      5 5 0 5.1 5.1;
%      6 6 0 4.5 4.5;
%      7 7 0 6 6;
%      8 8 0 2.5 2.5;
%      9 9 0 2.3 2.3;
%      10 10 0 0 0];
%  
%  % a matrix that indicates how the nodes are connected
%  % i.e. 1 means two nodes are connected, vice versa
%  connections = [
%      0 1 1 0 0 0 1 0 0 0;
%      1 0 0 0 0 1 0 0 0 0;
%      1 0 0 1 1 0 0 0 0 0;
%      0 0 1 0 0 0 0 0 1 0;
%      0 0 1 0 0 1 0 0 0 1;
%      0 1 0 0 1 0 0 1 1 0;
%      1 0 0 0 0 0 0 1 0 0;
%      0 0 0 0 0 1 1 0 0 0;
%      0 0 0 1 0 1 0 0 0 1;
%      0 0 0 0 1 0 0 0 1 0];
%  %1 2 3 4 5 6 7 8 9 10
%  
%  % a matrix that stores the distances between nodes,
%  % where 'inf' means two nodes are disconnected
%  distances = [
%      inf 2.2 6 inf inf inf 4 inf inf 8.7;
%      2.2 inf inf inf inf 4.2 inf inf inf 8.5;
%      6 inf inf 4 3 inf inf inf inf 8.1;
%      inf inf 4 inf inf inf inf inf 3.5 5.3;
%      inf inf 3 inf inf 2.5 inf inf inf 5.1;
%      inf 4.2 inf inf 2.5 inf inf 3 3.3 4.5;
%      4 inf inf inf inf inf inf 3.5 inf 6;
%      inf inf inf inf inf 3 3.5 inf inf 2.5;
%      inf inf inf 3.5 inf 3.3 inf inf inf 2.3;
%      inf inf inf inf 5.2 inf inf inf 2.3 0];

openList = [];
closeList = [];
openCount = 0;
closeCount = 0;
path_cost=0;
nNodes = size(distances, 1);

% the node ID of the first node
currentNode = graph(1, 1);
openList = [openList; currentNode currentNode graph(currentNode, 3) graph(currentNode, 4) graph(currentNode, 5) 1];
%closeList = [closeList; currentNode];
openCount = 1;
%closeCount = 1;

while (currentNode ~= graph(nNodes, 1))
    exp_array = [];
    for i = 1:nNodes 
        %sum(find(i == closeList))==0
        if (connections(currentNode, i) == 1  && sum(find(i == closeList))==0)
            g = (path_cost + distances(currentNode, i));
            h = distances(i, nNodes);
            exp_array = [exp_array; i currentNode g  h (h + g)];
        end
    end
    exp_count=size(exp_array, 1);
    
    for i = 1:exp_count
        flag = 0;
        for j = 1:openCount
            if (exp_array(i, 1) == openList(j, 1))
                openList(j, 5) = min(exp_array(i, 5), openList(j, 5));
               openList(j, [2 3 4]) = (openList(j, 5) == exp_array(i, 5)) * exp_array(i, [2 3 4]) + (openList(j, 5) ~= exp_array(i, 5)) * openList(j, [2 3 4]);
               
                flag = 1;
            end
        end
        if (flag == 0)
            openCount = openCount + 1;
            openList = [openList; exp_array(i, 1) exp_array(i, 2) exp_array(i, 3) exp_array(i, 4) exp_array(i, 5) 1];
        end
    end
    
    [val index_min_node] = min(openList(:,5));
    currentNode = openList(index_min_node, 1);
    path_cost = openList(index_min_node, 3);
    closeCount = closeCount + 1;
    closeList(closeCount) = currentNode;
    openList(index_min_node, 6) = 0;
    openList(index_min_node, 5) = inf;
end

current = openList(end, 1);

index = 1;
path = [];
path(index) = current;
while (current ~= openList(1, 1))
    current = openList(find(current == openList(:,1)), 2);
    index = index + 1;
    path(index) = current;
end
