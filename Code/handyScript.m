%obj = import_data_by_tags();
%upObj = import_UPdata_by_tags();
%upObj = rateTrials(upObj);
%obj = rateTrials(obj);
%hist_with_UPdata(obj,upObj,idxExp,idxCtrl,idxUPexp,idxUPctrl,'turn');
%fish = twoFish(2);
%[numCross,idx] = calcNumCrossing(fish);
% personal analysis to get memory extinction of each fish

% idxPostTr = 16:24;
% for i = 1:length(fishStack)
%     fish = fishStack(i);
%     fish.personalAnalysis(idxPostTr);
%     fprintf('Fish: %d\n',i);
%     pause();
% end
%   

% i = 24;
% idx = find(turnTiming > TrMat(i,1) & turnTiming < TrMat(i,2));
% tempS = scores(idx);
% numNeg = length(find(tempS == -1));
% numPos = length(find(tempS == 1));
% fprintf('Number of bad turns: %d\n',numNeg);
% fprintf('NUmber of good turns: %d\n',numPos);


% Separate hist plot to compare training effect in all, learners and
% non-learners
% Based on time
%PIs = [];%zeros(2,6); % non-learners (before/after), learners (before/after), all(b/a)

PItimeMat = [];
for i = 1:length(obj.FishStack)
    fish = obj.FishStack(i);
    temp = fish.ratePerformanceByTrials('time',false);
    PItimeMat = cat(1,PItimeMat,temp');
end

PIturnMat = [];
for i = 1:length(obj.FishStack)
    fish = obj.FishStack(i);
    temp = fish.ratePerformanceByTrials('turn',false);
    PIturnMat = cat(1,PIturnMat,temp');
end






NLers = cat(2,mean(timeNLres(:,1:5),2),mean(timeNLres(:,16:24),2));
Lers = cat(2,mean(timeMat(:,1:5),2),mean(timeMat(:,16:24),2));
allers = cat(1,NLers,Lers);
PIs = nancat(2,NLers,Lers,allers);

figure;
    
ctrlColor = [0,0,0.5];
expColor = [0.5,0,0];

colors = [ctrlColor;expColor;ctrlColor;expColor;ctrlColor;expColor];
labels = {'Baseline(C)','Training(C)','Test(C)',...
    'Baseline','Training','Test'};
UnivarScatter(PIs,'Whiskers','lines','PointStyle','.',...
    'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[1,1,1],'PointSize',20,...
    'SEMColor',colors/1.5,'StdColor',[1,1,1]);
set(gca,'YGrid','on'); % add yGrid to help compare data
ylim([0,1]);

% significant test




% numLers = size(Lers,1);
% numNLers = size(NLers,1);


% PIs(1,1) = mean(NLers(:,1),1);
% PIs(2,1) = std(NLers(:,1),1,1)/sqrt(numNLers);
% PIs(1,2) = mean(NLers(:,2),1);
% PIs(2,2) = std(NLers(:,2),1,1)/sqrt(numNLers);
% 
% PIs(1,3) = mean(Lers(:,1),1);
% PIs(2,3) = std(Lers(:,1),1,1)/sqrt(numLers);
% PIs(1,4) = mean(Lers(:,2),1);
% PIs(2,4) = std(Lers(:,2),1,1)/sqrt(numLers);
% 
% PIs(1,5) = (PIs(1,1) * numNLers + PIs(1,3) * numLers) / (numNLers + numLers);
% PIs(2,5) = (PIs(2,1) * sqrt(numNLers) + PIs(2,3) * sqrt(numLers)) /...
%         sqrt(numNLers + numLers);
% PIs(1,6) = (PIs(1,2) * numNLers + PIs(1,4) * numLers) / (numNLers + numLers);
% PIs(2,6) = (PIs(2,2) * sqrt(numNLers) + PIs(2,4) * sqrt(numLers)) /...
%         sqrt(numNLers + numLers);





% Plot learning curve
% timeRes = zeros(42,24);
% for i = 1:length(idxExp)
%     fish = obj.FishStack(idxExp(i));
%     timeRes(i,:) = fish.ratePerformanceByTrials('time',false);
% end

% plot learning curves with error bar (plot all, learners, non-learners)
% figure;
% hold on;
% 
% sem = std(timeRes,1,1) / sqrt(size(timeRes,1));
% errorbar(mean(timeRes,1),sem);
% 
% sem = std(timeNLres,1,1) / sqrt(size(timeNLres,1));
% errorbar(mean(timeNLres,1),sem);
% 
% sem = std(timeMat,1,1) / sqrt(size(timeMat,1));
% errorbar(mean(timeMat,1),sem);
% 


% get PIturn before/after training
expData = obj.FishStack(idxExp);
idxMetric = 2;
PIs = [];
for i = 1:length(expData)
    if idxMetric == 1
        PIdata = cat(2,ctrlData(i).Res.PItime.PIfish,expData(i).Res.PItime.PIfish);
    elseif idxMetric == 2
        PIdata = cat(2,expData(i).Res.PIturn.PIfish);
    end
    PIs = cat(1,PIs,PIdata);
    
end

PIs(:,2) = [];
allersTurn = PIs;
LersTurn = allersTurn(idxL,:);
NLersTurn = allersTurn(idxNL,:);

PIsTurn = nancat(2,NLersTurn,LersTurn,allersTurn);

figure;
ctrlColor = [0,0,0.5];
expColor = [0.5,0,0];

colors = [ctrlColor;expColor;ctrlColor;expColor;ctrlColor;expColor];
UnivarScatter(PIsTurn,'Whiskers','lines','PointStyle','.',...
        'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[1,1,1],'PointSize',20,...
        'SEMColor',colors/1.5,'StdColor',[1,1,1]);
set(gca,'YGrid','on'); % add yGrid to help compare data
ylim([0,1]);






idxLearned = [3,10,14,20,23,24,26,29,33,34,39,44,...
    51,52,55,56,60,66,71,79,83]; % pure black
% idxLearned = [28,109,114,33,44,48,133,136,10,12,54,58,153,154,16,...
%     22,24,26,82,85,93,94,96,99,103,166,182]; % redBlackCheckerboard
idxNL = [];
for i = 1:length(idxExp)
    idx = idxExp(i);
    if isempty(find(idxLearned == idx))
        idxNL = [idxNL, i];
    end
    
    
end






[timeMat, turnMat] = extract_trials_data_from_all_figures();



% use this function after performing ratePerformanceByTrials
function hist_with_UPdata(obj,upObj,idxExp,idxCtrl,idxUPexp,idxUPctrl,metric)
    if length(idxExp) ~= length(idxCtrl)
        error('Data from experiment group is not paired with the control group.');
    elseif length(idxUPexp) ~= length(idxUPctrl)
        error('Data from experiment group is not paired with the control group.'); 
    end

    expData = obj.FishStack(idxExp);
    ctrlData = obj.FishStack(idxCtrl);
    upExpData = upObj.FishStack(idxUPexp);
    upCtrlData = upObj.FishStack(idxUPctrl);
    
    if strcmpi(metric,'time')
        titleStr = 'Non-CS Area Time Proportion (7-9 dpf)';
        expPIs = [];
        for i = 1:length(expData)
            tempPIs = cat(2,expData(i).Res.PItime(1).PIfish,...
                expData(i).Res.PItime(4).PIfish);
            expPIs = cat(1,expPIs,tempPIs);
        end

        ctrlPIs = [];
        for i = 1:length(ctrlData)
            tempPIs = cat(2,ctrlData(i).Res.PItime(1).PIfish,...
                ctrlData(i).Res.PItime(4).PIfish);
            ctrlPIs = cat(1,ctrlPIs,tempPIs);
        end

        upPIs = [];
        for i = 1:length(upExpData)
            tempPIs = cat(2,upExpData(i).Res.PItime(1).PIfish,...
                upExpData(i).Res.PItime(4).PIfish);
            upPIs = cat(1,upPIs,tempPIs); 
        end

        
    
    
    elseif strcmpi(metric,'turn')
        titleStr = 'Turning Performance Index (7-9 dpf)';
        expPIs = [];
        for i = 1:length(expData)
            tempPIs = cat(2,expData(i).Res.PIturn(1).PIfish,...
                expData(i).Res.PIturn(4).PIfish);
            expPIs = cat(1,expPIs,tempPIs);
        end

        ctrlPIs = [];
        for i = 1:length(ctrlData)
            tempPIs = cat(2,ctrlData(i).Res.PIturn(1).PIfish,...
                ctrlData(i).Res.PIturn(4).PIfish);
            ctrlPIs = cat(1,ctrlPIs,tempPIs);
        end

        upPIs = [];
        for i = 1:length(upExpData)
            tempPIs = cat(2,upExpData(i).Res.PIturn(1).PIfish,...
                upExpData(i).Res.PIturn(4).PIfish);
            upPIs = cat(1,upPIs,tempPIs); 
        end

        
    end
    
    PIs = nancat(2,ctrlPIs(:,1),expPIs(:,1),upPIs(:,1),...
                ctrlPIs(:,2),expPIs(:,2),upPIs(:,2));
    
    figure;
    
    colors = 0.8*ones(6,3);%[0.5,0,0;0,0.5,0;0,0,0.5;0.5,0.5,0;0.5,0,0.5;0,0.5,0.5];
    labels = {'Ctrl','Exp','UP',...
        'Ctrl','Exp','UP'};
    UnivarScatter(PIs,'Label',labels,'Whiskers','lines','PointStyle','.',...
        'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[1,1,1],'PointSize',20,...
        'SEMColor',colors/1.5,'StdColor',[1,1,1]);
    set(gca,'YGrid','on'); % add yGrid to help compare data
        
    title(titleStr,'FontSize',14);
    ylim([0,1]);
    str = sprintf('N = %d\n',size(PIs,1));
    text(0.1,0.9,str);
    
    % significant test
    % Before training
    % compare ctrl with exp
    significanceTest(PIs,1,2);
    % compare UP with exp
    significanceTest(PIs,3,2);
    
    % After training
    % compare ctrl with exp
    significanceTest(PIs,4,5);
    % compare UP with exp
    significanceTest(PIs,6,5);
    
    line([1,3],[0.85,0.85],'Color',[0,0,0]);
    text(1.5,0.9,'Before Training');
    line([4,6],[0.85,0.85],'Color',[0,0,0]);
    text(4.5,0.9,'After Training');
    
end


function significanceTest(PIs,idx1,idx2)
    [~,p] = ttest2(PIs(:,idx1),PIs(:,idx2));
    line([idx1,idx2],[0.3,0.3],'Color',[0,0,0]);
    textPos = [(idx1+idx2)/2,0.25];
    if p > 0.05 % n.s.
        text(textPos(1),textPos(2),'n.s.','FontSize',14);
    elseif p < 0.0001 % "****"
        text(textPos(1),textPos(2),'****','FontSize',20);
    elseif p < 0.001 % "***"
        text(textPos(1),textPos(2),'***','FontSize',20);
    elseif p < 0.01 % "**"
        text(textPos(1),textPos(2),'**','FontSize',20);
    elseif p < 0.05 % "*"
        text(textPos(1),textPos(2),'*','FontSize',20);
    end
    


end

% compare results with control and unpaired-control
function hist_comparison(obj,upObj,idxExp,idxCtrl,idxUPexp,idxUPctrl,metric)


if length(idxExp) ~= length(idxCtrl)
    error('Data from experiment group is not paired with the control group.');
elseif length(idxUPexp) ~= length(idxUPctrl)
    error('Data from experiment group is not paired with the control group.');
end

    expData = obj.FishStack(idxExp);
    ctrlData = obj.FishStack(idxCtrl);
    upExpData = upObj.FishStack(idxUPexp);
    upCtrlData = upObj.FishStack(idxUPctrl);
    
    if strcmpi(metric,'time')
        titleStr = 'Non-CS Area Time Proportion (7-10 dpf)';
        expPIs = [];
        for i = 1:length(expData)
            tempPIs = cat(2,expData(i).Res.PItime(1).PIfish,...
                expData(i).Res.PItime(4).PIfish);
            expPIs = cat(1,expPIs,tempPIs);
        end

        ctrlPIs = [];
        for i = 1:length(ctrlData)
            tempPIs = cat(2,ctrlData(i).Res.PItime(1).PIfish,...
                ctrlData(i).Res.PItime(4).PIfish);
            ctrlPIs = cat(1,ctrlPIs,tempPIs);
        end

        upPIs = [];
        for i = 1:length(upExpData)
            tempPIs = cat(2,upExpData(i).Res.PItime(1).PIfish,...
                upExpData(i).Res.PItime(4).PIfish);
            upPIs = cat(1,upPIs,tempPIs); 
        end

        
    
    
    elseif strcmpi(metric,'turn')
        titleStr = 'Turning Performance Index (7-10 dpf)';
        expPIs = [];
        for i = 1:length(expData)
            tempPIs = cat(2,expData(i).Res.PIturn(1).PIfish,...
                expData(i).Res.PIturn(4).PIfish);
            expPIs = cat(1,expPIs,tempPIs);
        end

        ctrlPIs = [];
        for i = 1:length(ctrlData)
            tempPIs = cat(2,ctrlData(i).Res.PIturn(1).PIfish,...
                ctrlData(i).Res.PIturn(4).PIfish);
            ctrlPIs = cat(1,ctrlPIs,tempPIs);
        end

        upPIs = [];
        for i = 1:length(upExpData)
            tempPIs = cat(2,upExpData(i).Res.PIturn(1).PIfish,...
                upExpData(i).Res.PIturn(4).PIfish);
            upPIs = cat(1,upPIs,tempPIs); 
        end
    end
    PIs = nancat(2,ctrlPIs(:,1),ctrlPIs(:,2),expPIs(:,1),expPIs(:,2),...
        upPIs(:,1),upPIs(:,2));

    figure;
    
    ctrlColor = [0,0,0.5];
    expColor = [0.5,0,0];
    
    colors = [ctrlColor;expColor;ctrlColor;expColor;ctrlColor;expColor];%0.8*ones(6,3);%[0.5,0,0;0,0.5,0;0,0,0.5;0.5,0.5,0;0.5,0,0.5;0,0.5,0.5];
%     labels = {'Ctrl','Exp','UP',...
%         'Ctrl','Exp','UP'};
    UnivarScatter(PIs,'Whiskers','lines','PointStyle','.',...
        'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[1,1,1],'PointSize',20,...
        'SEMColor',colors/1.5,'StdColor',[1,1,1]);
    set(gca,'YGrid','on'); % add yGrid to help compare data
        
    title(titleStr,'FontSize',14);
    ylim([0,1]);
    str = sprintf('N = %d\n',size(PIs,1));
    text(0.1,0.9,str);
    
    % significant test
    % Before training
    % compare ctrl with exp
    significanceTest(PIs,1,2);
    % compare UP with exp
    significanceTest(PIs,3,4);
    
    % After training
    % compare ctrl with exp
    significanceTest(PIs,5,6);
    % compare UP with exp
    %significanceTest(PIs,6,5);
    
%     line([1,3],[0.85,0.85],'Color',[0,0,0]);
%     text(1.5,0.9,'Before Training');
%     line([4,6],[0.85,0.85],'Color',[0,0,0]);
%     text(4.5,0.9,'After Training');
            
            
end


function significanceTest(PIs,idx1,idx2)
    [~,p] = ttest(PIs(:,idx1),PIs(:,idx2));
    line([idx1,idx2],[0.3,0.3],'Color',[0,0,0]);
    textPos = [(idx1+idx2)/2,0.25];
    if p > 0.05 % n.s.
        text(textPos(1),textPos(2),'n.s.','FontSize',14);
    elseif p < 0.0001 % "****"
        text(textPos(1),textPos(2),'****','FontSize',20);
    elseif p < 0.001 % "***"
        text(textPos(1),textPos(2),'***','FontSize',20);
    elseif p < 0.01 % "**"
        text(textPos(1),textPos(2),'**','FontSize',20);
    elseif p < 0.05 % "*"
        text(textPos(1),textPos(2),'*','FontSize',20);
    end
    


end



% Test whether any preference to the blue side
function blue_test()
% script to import data from yaml and do basic analysis to check there is
% light preference in this paradigm
aObj = ABLITZER;
aObj.yaml2matlab;
fish = aObj.FishStack(1);
yDivide = fish.yDivide;
expPhase = cat(1,fish.Frames.ExpPhase);
head = cat(1,fish.Frames.Head);
pIdx = cat(1,fish.Frames.PatternIdx);

% checheck whether there is light preference in training section
idx = find(expPhase == 1);
tempPattern = pIdx(idx);
tempHead = head(idx,2);
idxNaN = find(tempHead == -1);
scores = zeros(length(idx),1);

% when the fish is in CS area, give him a credit, otherwise no point
for i = 1:length(idx)
    if tempPattern(i) == 0 % CS on the top
        scores(i) = 2*(tempHead(i) < yDivide) - 1;
    elseif tempPattern(i) == 1 % CS on the bottom
        scores(i) = 2*(tempHead(i) > yDivide) - 1;
    elseif tempPattern(i) == 2 % blackout
        scores(i) = 0;
    end
end

scores(idxNaN) = 0; % exclude the impact of invalid points
fish.Res.PItime(2).Scores = scores;
fish.Res.PItime(2).PIfish = length(find(scores==1)) / length(find(scores~=0));


end



function [timeMat, turnMat] = extract_trials_data_from_all_figures()
numTrials = 24;

pathName = 'F:\Nutstore\Academics\Research\My Project-how social behavior helps learning in zebrafish lavae\Results\ForPaper\Trial-by-trial Analysis\GCaMP\';
postfix = '*redBlackCheckerboard.fig';
fInfo = dir([pathName,postfix]);
numFigs = length(fInfo);
timeMat = zeros(numFigs,numTrials);
turnMat = zeros(numFigs,numTrials);
for i = 1:numFigs
    fName = fInfo(i).name;
    h = open([pathName,fName]);
    
    sp3Data = findobj(subplot(2,2,3),'Type','line');
    yTime = get(sp3Data,'Ydata');
    timeMat(i,:) = yTime;
    
    sp4Data = findobj(subplot(2,2,4),'Type','line');
    yTurn = get(sp4Data,'Ydata');
    turnMat(i,:) = yTurn;
    close all;
end




end


% calculate moving PI over test with 120 s time window.
function pMov = calc_moving_PI(fish)
scores = cat(1,fish.Res.PIturn.Scores);
posLabel = scores == 1;
negLabel = scores == -1;
testInterval = 120; % seconds
frameRate = fish.FrameRate;
windowWidth = testInterval * frameRate;
posSum = movmean(posLabel,windowWidth);
negSum = movmean(negLabel,windowWidth);
pMov = posSum./(posSum + negSum);
end





function check_potential_learners()
close all;
idxL = [1,3,6,7,8,9];
i = 6;
idx = idxL(i);
fish = fishStack(idx);
TrRes = fish.personalAnalysis(16:24);
preTrain = TrRes(1:5,1);
postTrain = TrRes(16:24,1);
idxTr = find(postTrain < mean(preTrain),1);
if isempty(idxTr)
    [h,p] = ttest2(preTrain, postTrain);
elseif idxTr <= 2 % at least one switch
    h = 0;
    p = nan;
else
    [h,p] = ttest2(preTrain,postTrain(1:idxTr-1));
end

if h == 1
    fprintf('Learned!\n');
    fprintf('Confidence level: %6.4f\n',1 - p);
    fprintf('ExpTime: %s\n',fish.ExpStartTime);
    fprintf('ID: %s\n',fish.ID);
    fprintf('Age: %d\n',fish.Age);
    fprintf('PItime (pre): %4.2f\n',fish.Res.PItime(1).PIfish);
    if isempty(idxTr)
        extincTime = inf;
        endIdx = 24;
    else
        extincTime = (idxTr - 1) * 2 * 60; % seconds
        endIdx = 15 + idxTr - 1;
    end  
    fprintf('PItime (post): %4.2f / %4.2f\n',...
        fish.Res.PItime(4).PIfish,mean(TrRes(16:endIdx,1)));
    
    
    fprintf('Extinction Time: %d\n',extincTime);
    fprintf('PIturn (pre): %4.2f\n',mean(TrRes(1:5,2)));
    fprintf('PIturn (post): %4.2f / %4.2f\n',...
        mean(TrRes(16:end,2)),mean(TrRes(16:endIdx,2)));
else
    fprintf('Not learned!\n');
end

%plotSinglePerformance(TrRes,endIdx);
end

function calcRespTimeInTest()

TrMat = [];
expPhase = cat(1,obj.Frames.ExpPhase);
patternIdx = cat(1,obj.Frames.PatternIdx);


% for training
idxPhase = find(expPhase == 1);
tempPIdx = patternIdx(idxPhase);
idx = find(tempPIdx == 2);
IDX = find(diff(idx) > 1);
idxBegin = [1;idx(IDX)+1];
idxEnd = [idx(IDX+1)-1;length(idxPhase)];
TrMat = cat(1,TrMat,cat(2,idxBegin,idxEnd, 1 * ones(size(idxBegin))));



% for test
idxPhase = find(expPhase == 3);
tempPIdx = patternIdx(idxPhase);
idx = find(diff(tempPIdx));
idxBegin = [1;idx+1];
idxEnd = [idx;length(idxPhase)];
TrMat = cat(1,TrMat,cat(2,idxBegin,idxEnd, 3 * ones(size(idxBegin))));


% calculate response time
scores = obj.Res.PItime(4).Scores;
L = scores < 0;
for i = 1:length(idxBegin)
    trialL = L(idxBegin(i):idxEnd(i)); 
    P = regionprops(trialL,'Area');
    areas = cat(1,P.Area);
    
    
end



end

% Correct image recognition failure by
% closest distance assignment
% Two issues to correct
% 1. Head-tail switch
% 2. Vibration-leading wrong recognition
function obj = correctHeadPos(obj)
numFrames = length(obj.Frames);

lastHead = obj.Frames(1).Head;
lastTail = obj.Frames(1).Tail;

for i = 2:numFrames
    thisHead = obj.Frames(i).Head;
    thisTail = obj.Frames(i).Tail;
    
    % Check whether head and tail switched
    if pdist([thisHead;lastHead]) + pdist([thisTail;lastTail]) > ...
            pdist([thisHead;lastTail]) + pdist([thisTail;lastHead])
        obj.Frames(i).Head = thisTail;
        obj.Frames(i).Tail = thisHead;
    end
    
    lastHead = obj.Frames(i).Head;
    lastTail = obj.Frames(i).Tail;
    
    
    
end





end

% calculate the number of crossing the mid-line
function [numCross,idx] = calcNumCrossing(obj)
yDiv = obj.yDivide;
heads = cat(1,obj.Frames.Head);
y = heads(:,2);
L = y > yDiv; 
idx = find(diff(L));
numCross = length(idx);

end

function count_learned_fish()
% count how many fish learned for each case (Age, Strain)
idxExp = obj.FishGroups(10).Data;
fishStack = obj.FishStack(idxExp);
numFish = length(fishStack);
resMat = zeros(numFish,3);
SAmat = zeros(numFish,1);

for i = 1:numFish
    fish = fishStack(i);
    [resMat(i,1),resMat(i,2),resMat(i,3)] = ...
        fish.sayIfLearned('time',false);
    SAmat(i) = fish.sayIfSelfAbused('time',false);
end
numLearnedFish = length(find(resMat(:,1) == 1));
numSelfAbusedFish = length(find(SAmat == 1));
fprintf('The total number of fish: %d\n',numFish);
fprintf('Number of fish learned: %d\n',numLearnedFish);
fprintf('Number of fish self-abused: %d\n',numSelfAbusedFish);
end

function obj = rateTrials(obj)
    for i = 1:length(obj.FishStack)
    fish = obj.FishStack(i);
    fish.ratePerformanceByTrials('time',false);
    fish.ratePerformanceByTrials('turn',false);
    end
end

function upObj = import_UPdata_by_tags(tags)
    % Import data by tags
    pathName = 'F:\Project-Operant Learning in Larval Zebrafish\ExpDataSet\ABLITZER_DATA\';  
    upObj = ABLITZER;
    upObj.importMatsByTags(tags,pathName);
    ages = cat(1,upObj.FishStack.Age);
    % correct age issue
    idx = find(ages == 1);
    for i = 1:length(idx)
        upObj.FishStack(idx(i)).Age = 10;
    end
    

end


function obj = import_data_by_tags(tags)
    % Import data by tags
    pathName = 'F:\Project-Operant Learning in Larval Zebrafish\ExpDataSet\ABLITZER_DATA\';
    
    obj = ABLITZER;
    obj.importMatsByTags(tags,pathName);
    ages = cat(1,obj.FishStack.Age);
    % correct age issue
    idx = find(ages == 1);
    for i = 1:length(idx)
        obj.FishStack(idx(i)).Age = 10;
    end
    
    
    
end


function uncategorized()

% plot memory curve for each fish in exp group
for i=1:length(idxExpData)
    idx = idxExpData(i);
    fish = obj.FishStack(idx);
    figure(1);
    subplot(2,1,1);
    fish.plotMemoryCurveByTrials('time');
    title('Time PI');
    subplot(2,1,2);
    fish.plotMemoryCurveByTrials('turn');
    title('Turn PI');
    fprintf('Training Effect: Time: %4.2f\t Turn: %4.2f\n',...
        fish.Res.PItime(2).PIfish - fish.Res.PItime(1).PIfish,...
        fish.Res.PIturn(2).PIfish - fish.Res.PIturn(1).PIfish);
    fprintf('Test: Time: %4.2f\t Turn: %4.2f\n',...
        fish.Res.PItime(4).PIfish - fish.Res.PItime(1).PIfish,...
        fish.Res.PIturn(4).PIfish - fish.Res.PItime(1).PIfish);    
    pause;
end



% check ontogeny of fish learning process
% to know when the fish could learn
rObj.classifyFishByTags(["ExpType","Age"]);

idxCtrlData = obj.FishGroups(7).Data;
idxExpData = obj.FishGroups(8).Data;

obj.plotPIsOfGroup(idxExpData,idxCtrlData,'time');
obj.plotPIsOfGroup(idxExpData,idxCtrlData,'turn');





% plot PIs for each fish in exp group
for i = 1:length(idxExp)
idx = idxExp(i);
fish = obj.FishStack(idx);
fish.plotPI('turn');
pause;
end



figure;
for i = 1:length(idxExp)
    idx = idxExp(i);
    fprintf('Index: %d\n',idx);
    fish = obj.FishStack(idx);
    s = cat(1,fish.Res.PIturn(2).Scores,fish.Res.PIturn(4).Scores);
    idx = find(s);
    s = s(idx);
    s = (s + 1) / 2;
    x = (1:length(s))';
    y = cumsum(s) ./ x;
    plot(x,y);
    pause;
end

numFish = 82;
aMat = zeros(numFish,3);
Lmat = zeros(numFish,1);
for i=1:numFish
fish = obj.FishStack(idxExp(i));
[Lmat(i),aMat(i,:)] = fish.sayIfLearned('time',false);
fprintf('Learning Rate: %6.2f;\n Plateau: %6.2f;\n Inflection point: %6.2f \n',...
    -aMat(i,1),1+aMat(i,3),-aMat(i,2)/aMat(i,1));
%pause;
end



% fit learning curves to half-logistic function
% y = (1-exp(ax+b)) ./ (1+exp(ax+b)) + c;
fitFunc = @(A,x)((1-exp(A(1)*x+A(2)))./ (1+exp(A(1)*x+A(2))) + A(3));
s = fish.Res.PIturn(2).Scores;
idx = find(s);
s = s(idx);
s = (s+1)/2;
x = (1:length(s))';
y = cumsum(s) ./ x;
A0 = [-1,0,max(y)-1];
opts = statset('nlinfit');
opts.MaxIter = 200;
Afit = nlinfit(x,y,fitFunc,A0,opts);
yFit = fitFunc(Afit,x);
figure;
hold on;
plot(x,y);
plot(x,yFit);
line([0,50],[PIthre,PIthre],'r-');



% plot single fish learning curve based on turning events
fish = obj.FishStack(idxExp(8));
sCell = cell(3,1);
tCell = cell(3,1);
Rmat = [];
for i = 1:3
    if i == 3
        phaseIdx = 4;
    else
        phaseIdx = i;
    end
scores = fish.Res.PIturn(phaseIdx).Scores;
idx = find(scores);
sCell{i,1} = scores(idx);
tCell{i,1} = fish.Res.PIturn(phaseIdx).TurnTiming(idx);

Rmat = cat(1,Rmat,cat(2,tCell{i,1},sCell{i,1}));
%subplot(3,1,i);
%scatter(tCell{i,1},sCell{i,1});
end

t = Rmat(:,1);
s = Rmat(:,2);
cumAccu = zeros(size(s));
for i = 1:length(s)
cumAccu(i) = length(find(s(1:i)==1)) / i;% cummulated accuracy
end 

figure
title('Learning curve based on turning events');
plot(t,cumAccu);


end

function get_PImat_for_exp_only_data()
% process exp-only data
% after imported data to ABLITZER obj
PImat = zeros(6,4);
for i=1:6
fish = obj.FishStack(i);
fish.ratePerformance;
PImat(i,1) = fish.Res.PItime(1).PIfish;
PImat(i,2) = fish.Res.PItime(2).PIfish;
PImat(i,3) = fish.Res.PIturn(1).PIfish;
PImat(i,4) = fish.Res.PIturn(2).PIfish;
end
end


function incorporate_oldYamls(obj,dateStr)
    pathName = 'F:\FishExpData\operantLearning\';
    d = dir([pathName,'*',dateStr,'*G*.yaml']);
    bIdx = 0;
    for fIdx = 1:2:length(d)
        fprintf('Processing file pair: %d\n',(fIdx+1)/2);
        fileName1 =  d(fIdx).name;
        fileName2 = [pathName,d(fIdx+1).name];
        obj.oldYaml2matlab(-1,pathName,fileName1);
        posStruct = read_correct_pos_file(fileName2);
        overwrite_oldData(obj,posStruct,bIdx);
        bIdx = bIdx + 2;
    end
end

function overwrite_oldData(obj,posStruct,bIdx)
% replace head, tail, center, headingAngle with new data
    numFish = 2;
    for n = 1:numFish
        idxFish = n + bIdx;
        fish = obj.FishStack(idxFish);
        heads = posStruct(n).Head;
        tails = posStruct(n).Tail;
        centers = posStruct(n).Center;
        headingAngles = posStruct(n).HeadingAngle;
        for i = 1:min(length(fish.Frames),length(headingAngles)) % 1 frame shift
            fish.Frames(i).Head = heads(i,:);
            fish.Frames(i).Tail = tails(i,:);
            fish.Frames(i).Center = centers(i,:);
            fish.Frames(i).HeadingAngle = headingAngles(i);
        end     
    end

end

% read data from correct pos yaml files
function posStruct = read_correct_pos_file(fileName)
if nargin == 0
    [f,p] = uigetfile('*.yaml');
    fileName = [p,f];
end
posStruct = struct('Head',[],'Center',[],'Tail',[],'HeadingAngle',[]);
fid = fopen(fileName);

MaxFrames = 30000; % the max number of frames
numFish = 2;
% read frames until the end
frames(MaxFrames,numFish) = FRAMEDATA;

idxFrame = 0;
idxFish = 1;

while (~feof(fid))
    [key, value] = read_a_line(fid);
    if (~isempty(key))
        switch key
            case 'Frames'
                idxFrame = idxFrame + 1;
                % show the progress
                if (mod(idxFrame,100)==0)
                    disp(idxFrame);
                end
            case 'FrameNum'
                for i = 1:numFish
                    frames(idxFrame,i).FrameNum = str2num(value);
                end
            case 'FishIdx'
                idxFish = str2num(value) + 1;
            case 'Head'
                frames(idxFrame,idxFish).Head = str2num(value);
            case 'Tail'
                frames(idxFrame,idxFish).Tail = str2num(value);
            case 'Center'
                frames(idxFrame,idxFish).Center = str2num(value);
            case 'HeadingAngle'
                frames(idxFrame,idxFish).HeadingAngle = str2num(value);
            otherwise
                disp(['Unrecognized keyword: ', key]);
        end
    end
end

frames(idxFrame:end,:) = []; % remove redundant frames
for i = 1:numFish
    posStruct(i).Head = cat(1,frames(:,i).Head);
    posStruct(i).Center = cat(1,frames(:,i).Center);
    posStruct(i).Tail = cat(1,frames(:,i).Tail);
    posStruct(i).HeadingAngle = cat(1,frames(:,i).HeadingAngle);
end

end

function [key, value] = read_a_line(fid)
% read a line in yaml and convert the value to struct
% if it is a key-value pair.
tline = fgets(fid);
newLine = remove_brackets(tline);
if (contains(newLine,":"))
    [key,value] = readKeyValuePair(newLine);
else
    key = [];
    value = [];
end

end

function newLine = remove_brackets(tline)
    startIdx = strfind(tline,"{");
    if isempty(startIdx)
        newLine = tline;
        return
    else
        endIdx = strfind(tline,"}");
        newLine = tline(startIdx+1:endIdx-1);
    end
    

end

function [fieldName,value] = readKeyValuePair(str)
    q=textscan(str,'%q','Delimiter',':');
    fieldName = q{1}{1};
    if (length(q{1}) >= 2)
        value = q{1}{2};
    else
        value = [];
    end
end

% plot shocks count as histograms in equal periods of training session
function shock_analysis_beta(obj)
obj.classifyFishByTags("ExpType");
fishStack = obj.FishStack;
expFish = fishStack(obj.FishGroups(2).Data);
numFish = length(expFish);

shockCell = cell(numFish,1);
for i=1:numFish
fish = expFish(i);
if (fish.Res.DataQuality < 0.95)
    continue;
end
shockCell{i,1} = fish.Res.PIshock;

end

% figure;
% hold on;
% for i=1:length(shockCell)
%     if (isempty(shockCell{i,1}))
%         continue;
%     end
%     shockTiming = shockCell{i,1}.ShockTiming;
%     scatter(shockTiming,i*ones(size(shockTiming)),'.');
% end

nBins = 2; % number of bins to count
nShocksArr = [];
shocksOn = [];
for i=1:length(shockCell)
    if (isempty(shockCell{i,1}))
        continue;
    end
    shockTiming = shockCell{i,1}.ShockTiming;
    N = histcounts(shockTiming,nBins);
    nShocksArr = cat(1,nShocksArr,N);
    shocksOn = cat(1,shocksOn,shockTiming);
end
%histogram(shocksOn,nBins);

figure;
set(gca,'YGrid','on'); % add yGrid to help compare data
labels = {'Beginning','Mid-term','Final'};
colors = 0.8*ones(nBins,3);
UnivarScatter(nShocksArr,'MarkerFaceColor',colors,...
'SEMColor',colors/1.5,'StdColor',colors/2);


end

function shockPIMat = calc_weighted_shockPI(obj)
% calculate shock performance with distance to centerline as panelty
nBins = 5;
numFish = length(idxExp);
shockPIMat = zeros(numFish,nBins);
framesInTr = 12000;
for n = 1:numFish
    idx = idxExp(n);
    fish = obj.FishStack(idx);
    %fish.ratePerformance;
    PIshock = fish.Res.PIshock;
    frameRate = fish.FrameRate;
    scores = PIshock.Scores;
    shockTiming = PIshock.ShockTiming;

    edges = 0:ceil(framesInTr/nBins):framesInTr;
    if (edges(end) ~= framesInTr)
        edges = [edges,framesInTr];
    end
    sTime = zeros(nBins,1); % scores of each period in training  
    for i=1:nBins
        idxBegin = edges(i);
        idxEnd = edges(i+1);
        idx = find((shockTiming > idxBegin)&(shockTiming < idxEnd));
        if isempty(idx)
            sTime(i) = 1;
        else
            sTime(i) = sum(scores(idx));
        end  
    end
    shockPIMat(n,:) = sTime;
end
figure;
UnivarScatter(shockPIMat);
end

function output = get_output(obj)

% Get PItimes in all phases
output = struct('ExpTime',[],'ID',[],'Age',[],'Task',[],'DataQuality',[],...
    'PITime_Baseline',[],'PITime_Training',[],'PITime_Test',[],...
    'PITurn_Baseline',[],'PITurn_Training',[],'PITurn_Test',[],...
    'NumShock',[],'PIShock',[]);
obj.classifyFishByTags("ExpType");
idxExp = obj.FishGroups(2).Data;
for i = 1:length(idxExp)
    idx = idxExp(i);
    fish = obj.FishStack(idx);
    % Assign values to output
    output(i).ExpTime = fish.ExpStartTime;
    output(i).ID = fish.ID;
    output(i).Age = fish.Age;
    output(i).Task = fish.ExpTask;

    output(i).DataQuality = fish.Res.DataQuality;
    % PItime
    output(i).PITime_Baseline = fish.Res.PItime(1).PIfish;
    output(i).PITime_Training = fish.Res.PItime(2).PIfish;
    output(i).PITime_Test = fish.Res.PItime(4).PIfish;

    % PIturn
    output(i).PITurn_Baseline = fish.Res.PIturn(1).PIfish;
    output(i).PITurn_Training = fish.Res.PIturn(2).PIfish;
    output(i).PITurn_Test = fish.Res.PIturn(4).PIfish;

    % PIshock
    output(i).NumShock = fish.Res.PIshock.NumShocks;
    output(i).PIshock = fish.Res.PIshock.PIfish;     
      
end

end



% measure the linear correlation between two variables
function  Rsq = calc_Rsquare(x, y)
p = polyfit(x,y,1);
yFit = polyval(p,x);
yResid = y - yFit;
SSresid = sum(yResid.^2);
SStotal = (length(y)-1) * var(y);
Rsq = 1 - SSresid / SStotal;

end

function PIs = get_all_PIs(obj)
    fishStack = obj.FishStack;
    numFish = length(fishStack);
    PIs = [];
    for i=1:numFish
        fish = fishStack(i);
        tempPI = cat(2,fish.Res.PItime.PIfish);
        PIs = cat(1,PIs,tempPI);
        
        
        
    end
end



