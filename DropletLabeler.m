
%% This function takes as input the absolute path of extracted image files and outputs the labeled locations
function [DropletPoints] = DropletLabeler(path,skip,loadFile)
    %% Read in  frames
   if loadFile
        load([path,'DropletData.mat']);
    else
        verify = input('Are you sure you want to label from the first frame? exisiting labels will be deleted (Y/N) : ');
        if exist([path,'DropletData.mat'],'file') 
            load([path,'DropletData.mat']);   
            save([path,'DropletData_bkp.mat'],'frame','labelId')
        end
        if(strcmp(verify,'Y'))
            frame = [];
            labelId = 1;
        else
            DropletPoints = []; return
        end
    end
    
    imagefiles = dir([path,'*.png']);
    nfiles = length(imagefiles);    % Number of files found
    
    for imCnt=1:nfiles
        filename = [path,imagefiles(imCnt).name];
        image = imread(filename);
        images{imCnt} = image;
    end
  sz = 40;
  ESC = 27;
  for imCnt = labelId+1:skip:size(images,2)
    BubblePoints=[];
    close all;
    handle = figure('Position',[00,0,768*1.5,768*1.5]);
    title(['IMAGE number', num2str(imCnt)])
    cnt =1;
    finish=false;
    set(gcf,'CurrentCharacter','@'); % set to a dummy character      
      while ~finish
          imagesc(images{imCnt}); axis image; axis off; hold on;
          retry = 1;
          % allow the user to retry by pressing the ESCAPE key
          while retry
            retry = 0;
            % loop over each part and bring up a cursor for selecting (x,y)
            [x, y, button] = ginput(1);
            pl=scatter(x,y,sz,'MarkerEdgeColor',[0 .5 .5],...
                       'MarkerFaceColor',[1 0 .4],...
                       'LineWidth',1.5);
            drawnow; hold on;       
            %pll=plot(x,y);
            if button == ESC
                retry = 1;
                break;
            end
            loc = [x y];
          end
          BubblePoints{cnt}=loc;
          cnt=cnt+1;                
         % check for keys
         k=get(gcf,'CurrentCharacter');
         if k~='@' % has it changed from the dummy character?
             set(gcf,'CurrentCharacter','@'); % reset the character
             % now process the key as required
             if k=='q' 
                 finish=true;
                 BubblePoints{cnt-1}=[];
             end
          end
     end      
     close(handle);
     frame{imCnt}.locs=BubblePoints;
     labelId=imCnt;
     save([path, 'bubblesData.mat'],'frame','labelId')
  end
end
   
