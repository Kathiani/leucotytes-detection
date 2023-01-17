function validationlocalmax(namevideo, BB, Cm, experimentname, namefolder, nframes)

    TP = 0; FP = 0; FN = 0 ; th = 0.16; sumTP = 0; sumFP = 0; sumFN = 0;
    objvideo = VideoReader(namevideo);
    mkdir('C:\Users\Kathiani\Dropbox\Novos\Marcados\');

    for f =1:nframes
                frame = read(objvideo,f);
                rows = Cm.Slice==f; 
                vars = {'X','Y'};
                Cmf = Cm(rows,vars);
                Cmf = table2array(Cmf);
                sz = size(Cmf); 
                cl = findMaximal(BB{f,1},th);
                c = double(cl);
                cz = size(c);
                fileName = sprintf(strcat('teste','-frame%d.txt'),f);               
                fileID = fopen(strcat(namefolder,fileName),'a+t');
                for v=1:cz(1)                   
                    fprintf(fileID,'%d \t %.1f\t %.1f\t \n', v, c(v,1), c(v,2)); 
                    frame =  insertShape(frame, 'FilledCircle', [c(v,1) c(v,2) 3.2],'Color',{'cyan'});
                end
                fclose(fileID);          
                imshow(frame);
    end
   
  


