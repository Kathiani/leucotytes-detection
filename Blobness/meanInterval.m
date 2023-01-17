function meanInterval(l1, l2, nframes)%Recebe a posição do melhor limiar no txt

som1 = 0; som2 = 0;
f1 = NaN(nframes,1); f2 = NaN(nframes,1);
namefolder1 = strcat('C:\Users\Kathiani\Desktop\Experimentos Finais\Resultados\Teste-or-4-sigma-0.59-beta-0.7\');
namefolder2 = strcat('C:\Users\Kathiani\Desktop\Experimentos - Pós-processamento\Resultados\TM\');

for ii=1:nframes
    filename1 = sprintf(strcat('Teste-or-4-sigma-0.59-beta-0.7','-frame%d.txt'),ii);
    data1 = load(strcat(namefolder1,filename1));
    f1(ii,:)   = data1(l1:l1,7:7);
    som1 = som1 + data1(l1:l1,7:7);
    
    filename2 = sprintf(strcat('TM','-frame%d.txt'),ii);
    data2 = load(strcat(namefolder2,filename2));
    f2(ii,:)   = data2(l2:l2,7:7);
    som2 = som2 + data2(l2:l2,7:7);
  
end
    m1 = som1/nframes;
    se1 = std(f1)/sqrt(length(f1));
    ic1 = se1*1.96;
    display(ic1);
    
    m2 = som2/nframes;
    se2 = std(f2)/sqrt(length(f2));
    ic2 = se2*1.96;
    display(ic2);

 
    Title = 'Intervalo de Confiança (220 frames)';
    tec = {'Blobness', 'Casamento de Padrões'}; % Use for legend
    figure                                      % Label the top
    errorbar([m1 m2], [ic1 ic2],'r*');         % Error bars use black squares
    set(gca, 'XTick', 1:3, 'XTickLabel', tec,'FontSize',14) % Set ticks and tick labels
    title(Title,'FontSize',14)
    legend('Média (medida-F1)', 'Location', 'Northeast', 'FontSize',14) % Upper left
    xlabel('Técnica', 'FontSize',14)
    ylabel('medida-F1', 'FontSize',14)

end

