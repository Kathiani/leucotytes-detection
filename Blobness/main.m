function BB = main(cm, video, namevideo, namemask) 
   %Antes de executar essa função usar:
   %cm = readtable('centroidesKathiani.xlsx'); %Gerar a lista de
   %centroides da marcação manual
       
    objvideo = VideoReader(video);
    mask = imread(namemask); 
    mask = im2double(mask); 
    mask(mask~=0)=1;    
    nframes = 220; %número de quadros processados
    h = get(objvideo, 'Height'); w = get(objvideo, 'Width');    
    BB = cell(1,1);
    M = cell(h, w); 
    E = cell(h, w); 
    alpha = 0.1; beta = 0.7; 
    
    nscale = 4;
    norient = 4;
    minWaveLength = 8;
    mult = 2.1;
    sigmaOnf = 0.59;
    k =  9;
    cutOff = 0.4;
    g = 5;
    noiseMethod = -1;
   
   %for o=1:3
       %for m=1:8
           %for t=1:1
               experimentname = strcat('Teste-Thrs0.16-',namevideo);
               namefolder = strcat('C:\Users\Kathiani\Desktop\Código - fonte  - Revista\Blobness\Resultados\',experimentname,'\');
               mkdir(namefolder);
               for f=1:nframes
                    im =  read(objvideo,f);
                    im =  rgb2gray(im);                  
                    [covx, covy, covxy] = phasecong3(im, nscale, norient, minWaveLength, mult, sigmaOnf, k, cutOff, g, noiseMethod); 
                    for i=1:h
                      for j=1:w
                            M{i,j} = [covx(i,j) covxy(i,j); covxy(i,j) covy(i,j)]; 
                            E{i,j} = eig(M{i,j}); 
                       end
                    end 
                    B = blobness(E, w, h, alpha, beta); 
                    B = immultiply(B, mask);
                    imshow(B);
                    %imshow(mask);
                    BB{f,1} = B;         
               end
               validationlocalmax(video, BB, cm, experimentname, namefolder, nframes); %Calculate and save the value metrics Precision, Recall and F1-measure to each frame in each threshold
               %meanFmeasure(nframes, experimentname, namefolder);
               %[mAUCPR, SEM] = PrecRecallAUC(nframes, 'red', experimentname, namefolder); %Return the mean AUC and confidence interval
               %fileName = sprintf('meanAUCPR.txt');
               %fileID = fopen(strcat('C:\Users\Kathiani\Dropbox\KATHIANI\Código - fonte\Blobness\',fileName),'a+t');
               %fprintf(fileID,'\n%s: %f , interval: %f', experimentname, mAUCPR, SEM); %abre o arquivo e salva valor de TP no txt;
               %fclose(fileID);
         
               %Testes p/definição dos parâmetros
               %if t == 1
                  %mult = 1.6;
                  %sigmaOnf = 0.75;
               %end
               %if t == 2
                    %mult = 2.1;
                    %sigmaOnf = 0.65;
               %end
               %if t == 3
                    %mult = 3;
                    %sigmaOnf = 0.55;
               %end   
               %beta = beta + 0.1;
           %end
           
       %minWaveLength = minWaveLength + 1;
       %mult = 1.3;
       %sigmaOnf = 0.85;      
       %end    
end

function B = blobness(E, w, h, alpha, beta) 
ep = 0.0001;

    for i=1:h
        for j=1:w
                R = (abs(E{i,j}(1,1))/((abs(E{i,j}(2,1))) + ep)); 
                S = sqrt((E{i,j}(1,1)^2) + (E{i,j}(2,1)^2));
                B(i,j) = (1 - exp(-((R^2)/(2*alpha)^2))) * (1 - exp(-((S^2)/(2*beta)^2)));  
        end
    end

end


