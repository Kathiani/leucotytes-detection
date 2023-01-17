function meanFmeasure(nFrames, experimentname, namefolder)
    t = 0.02; p = 0; r = 0; f = 0;
  
    for k=1:50
         for ii=1:nFrames
            fileName = sprintf(strcat(experimentname,'-frame%d.txt'), ii);
            data = load(strcat(namefolder,fileName)); 
             p = p + data(k,5);
             r = r + data(k,6);
             f = f + data(k,7);    
         end

         fileName = sprintf(strcat(experimentname,'-precision-recall-f1measure.txt'));
         fileID = fopen(strcat(namefolder,fileName),'a+t');
         fprintf(fileID,'%f \t %f \t %f \t %f \n', t, p/nFrames, r/nFrames, f/nFrames);
         fclose(fileID);
         
         t = t +  0.02;
         p = 0; r = 0; f = 0;
         
     end


end

 