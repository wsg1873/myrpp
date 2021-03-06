% set up color map for display 
%代码优化和解释
cmap = [1 1 1; ...% 1 - white - clear cell  
	0 0 0; ...%2 - black - obstacle  
	1 0 0; 	...% 3 - red = visited  
	0 0 1; ...% 4 - blue - on list 
	0 1 0; ...% 5 - green - start  
	1 1 0];% 6 - yellow - destination
	 colormap(cmap); 
     map=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 2 2 0 0 0 2 2 2 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 2 2 2 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 2 2 2 0 0 0 0 0 0 0 0 0 0 0;
   0 2 2 2 0 0 2 2 2 0 0 0 0 0 0 0 0 0 0 0;
   0 2 2 2 0 0 2 2 2 0 0 0 0 0 0 0 0 0 0 0;
   0 2 2 2 0 0 2 2 2 0 2 2 2 2 0 0 0 0 0 0;
   0 2 2 2 0 0 0 0 0 0 2 2 2 2 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 2 2 2 2 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 2 2 2 2 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 2 2 2 0 2 2 2 2 0;
   0 0 0 0 0 0 0 0 0 0 0 2 2 2 0 2 2 2 2 0;
   0 0 2 2 0 0 0 0 0 0 0 2 2 2 0 2 2 2 2 0;
   0 0 2 2 0 0 2 2 2 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 2 2 2 0 2 2 0 0 0 0 0 2 2 0;
   0 0 0 0 0 0 0 0 0 0 2 2 0 0 2 0 0 2 2 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0;];
	% map = zeros(10); % Add an obstacle 
	 %map (1:6, 6) = 2; 
     %map (6:10, 4) = 2; 
     %map(7,7)=2;
     tic
	 map(5, 5) = 5; % start_coords 
	 map(20,19) =6; %dest_coords
	 image(1.5,1.5,map); 
	 grid on; axis image; %%  
	 nrows = 20; 
	 ncols = 20; 
	 start_node = sub2ind(size(map), 5, 5); 
	 dest_node = sub2ind(size(map), 20, 19); 
	 % Initialize distance array 
	 distanceFromStart = Inf(nrows,ncols); 
	 distanceFromStart(start_node) = 0; 
	 % For each grid cell this array holds the index of its parent 
	 parent = zeros(nrows,ncols); 
	 % Main Loop 
	 while true  
       % Draw current map 
     map(start_node) = 5; 
	 map(dest_node) = 6; 
	 image(1.5, 1.5, map); 
	 grid on; axis image; 
	 drawnow;  % Find the node with the minimum 
	 [min_dist, current] = min(distanceFromStart(:));  
	 if ((current == dest_node) ||isinf(min_dist))  
	 	break; 
	 end; 
	 map(current) = 3; 
	 distanceFromStart(current) = Inf; 
	 [i, j] = ind2sub(size(distanceFromStart), current); 
	 neighbor = [i-1,j;i+1,j;i,j+1; i,j-1];
	 outRangetest = (neighbor(:,1)<1) + (neighbor(:,1)>nrows) +(neighbor(:,2)<1) + (neighbor(:,2)>ncols ); 
	 locate = find(outRangetest>0); 
	 neighbor(locate,:)=[];
	 neighborIndex = sub2ind(size(map),neighbor(:,1),neighbor(:,2));
	 for i=1:length(neighborIndex) 
	   if ((map(neighborIndex(i))~=2) && map(neighborIndex(i))~=3 && map(neighborIndex(i))~= 5) 
	 	map(neighborIndex(i)) = 4;  
	    if distanceFromStart(neighborIndex(i))> min_dist + 1 
	 	distanceFromStart(neighborIndex(i)) = min_dist+1; 
	    parent(neighborIndex(i)) = current; 
        end 
	   end 
	 end 
     end
    t=toc
 if (isinf(distanceFromStart(dest_node))) 
 	route = []; 
 else  %提取路线坐标 
 	route =[dest_node];  
 while (parent(route(1)) ~= 0)
    route = [parent(route(1)), route]; 
    end  %动态显示出路线 
  for k = 2:length(route) - 1  
 	map(route(k)) = 7; pause(0.1); 
    image(1.5,1.5, map); 
    grid on; axis image; 
    end 
 end
title(length(route));


