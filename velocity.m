position = xlsread('firstvideo-1.xls');
positionx = position(:,1);    % the values of x cordinates
positiony = position(:,2);    % the values of y cordinates
t = 1;                      % time between each frame

n = numel(positionx);         %to find the number of tracks
for i = 1:n-1
    velx(i) = abs((position((i+1),1)- position(i,1)))/t;
end

m = numel(positiony);
for j = 1:m-1
    vely(j) = abs((position((j+1),2)- position(j,2)))/t;
    
end

%for k = 1:n-1
 %   velabs(k) = sqrt((velx(k)).^2 + (vely(k).^2));   
%end

velabs = sqrt((velx.^2) + (vely.^2));
velabs1 = transpose(velabs);

%for l = 1:n 
 %   velavg = (velabs(l)+velabs(l))/n;
%end
velavg = mean(velabs);

