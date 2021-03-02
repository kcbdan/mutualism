function [] = PlotBubbles(path,visType,p2micromfactor)
    if (nargin<3)
        p2micromfactor=1;
    end
    imagefiles = dir([path,'*.png']);
    load([path,'bubblesData.mat']);
    %frame=[];
    nfiles = length(imagefiles);    % Number of imgs found
    sz=36;
    if strcmp(visType, 'OVERLAY')
       %image = imread([path,'/','q.png']);
       image = imread([path,'/',imagefiles(2).name]);
        figure(1);
        imshow(image);
        hold on;
        for imCnt=2:3:nfiles
             %filename = [path,'/',imagefiles(imCnt).name];
             %filename = [path,'/',imagefiles(imCnt).name];
             %images{imCnt} = image;
            
            %if ~isempty(frame{imCnt})
                for i = 1:size(frame{imCnt}.locs,2)-1
                    %title('Motion of Defects over time');
                    %scatter(frame{imCnt}.locs{i}(1),frame{imCnt}.locs{i}(2),sz,'MarkerEdgeColor',[1 0 0],...
                       %'MarkerFaceColor',[1 0 0],...
                       %'LineWidth',1)
                   plot(frame{imCnt}.locs{i}(1),frame{imCnt}.locs{i}(2),'b--o')
                end
                %pause(1);    
            end
            %close all; 
        end
    if strcmp(visType,'GRAPH')
        for imCnt=1:1:labelId-1
            %~isempty(frame{imCnt})
            if (~isempty(frame{imCnt}))
            %if exists(frame{imCnt}.locs)
                for i = 1:size(frame{imCnt}.locs,2)-1
                    figure(1);
                    title('Motion of Particles over time');
                    xlabel('location of particle in X (micrometer)');
                    ylabel('location of particle in Y (micrometer)');
                    %p2micromfactor = 0.0449;
                    scatter(frame{imCnt}.locs{i}(1)*p2micromfactor,frame{imCnt}.locs{i}(2)*p2micromfactor,sz,'MarkerEdgeColor',[1 1 1],...
                       'MarkerFaceColor',[1/i .5 .4],...
                       'LineWidth',1.5); hold on; 
                    set(gca,'xaxislocation','bottom','yaxislocation','left');
                    set(gca,'Ydir','reverse');
                    %ax1=gca;
                    %ax1_pos=ax1.Position;
                    %ax2=axes('Position', ax1_pos,...
                       % 'XAxisLocation','top',...
                        %'YAxisLocation','right',...
                        %'Color','none');
                    drawnow; 
                        %pause();
                    %line([frame{imCnt}.locs{i}(1),frame{imCnt+1}.locs{i}(1)],[frame{imCnt}.locs{i}(2),frame{imCnt+1}.locs{i}(2)])

                end
               % pause();    
            end
            %end
            %close all; 
        end
    end    
 end