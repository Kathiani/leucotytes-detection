function [mAUCPR, SEM] = PrecRecallAUC(nFrames, color, experimentname, namefolder)

AUCPR = NaN(nFrames,1);

    for ii=1:nFrames
        filename = sprintf(strcat(experimentname,'-frame%d.txt'),ii);
        data = load(strcat(namefolder,filename));

        precision = data(1:end,5:5);
        recall    = data(1:end,6:6);
        f1score   = data(1:end,7:7);

        N = length(data);
        for i=N:-1:1
           if isnan( precision(i,:) )
               precision(i,:) = [];
               recall(i,:) = [];
               f1score(i,:) = [];
           end
        end

        AUCPR(ii,:) = abs(trapz(recall, precision,1));

        %plot(recall, precision, [color '-*']); axis([0 1 0 1]); 
        %grid on
        %ylabel('Precision');
        %xlabel('Recall');
        %axis('square');
    end

    % Calculate the mean of AUCPR
    mAUCPR = mean(AUCPR);

    % Calculate Standard Error of the Mean (of the AUCPR)
    SEM = std(AUCPR)/sqrt(length(AUCPR)); % standard error of the mean
    SEM = SEM * 1.96; % 95% confidence interval

end
