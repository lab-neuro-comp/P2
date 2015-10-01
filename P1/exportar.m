[name path]=uiputfile;
file=strcat(path,name,'.ascii');

if userok==1
    userinfo{1}='Nome:';
    userinfo{2}='Idade:';
	userinfo{3}='Sexo';
	userinfo{4}='Valor inicial:';
	userinfo{5}='Digito referencia:';
	userinfo{6}='Tempo de teste [s]:';
	userinfo{7}='Data e hora:';
	
	coluna{1}='Numero digitado';
    coluna{2}='Numero Correto';
	coluna{3}='Tempo de digitacao [s] (TD)';
	coluna{4}='Tempo de calculo [s] (TC)';
    coluna{5}='Tempo de ocorrencia [s]';
    coluna{6}='Erro=1, Acerto=0';
    coluna{7}='TD/TC';
    
    userdata{7}=datestr(now);
    
    estat{1}='Media';
    estat{2}='Maximo';
    estat{3}='Minimo';
    estat{4}='Desvio Padrao';
    estat{5}='Mediana';
    estat{6}='Percentil 25';
    estat{7}='Percentil 75';
    
    [fr,cr]=size(vtsst_result);   
	vtsst_result=vtsst_result(2:fr,:);
    fr=fr-1;
    
    somadig=0;
    somacal=0;
    err=0;
    ac=0;
    for k=1:fr
       somadig=somadig+vtsst_result(k,3);
       somacal=somacal+vtsst_result(k,4);
       vtsst_result(k,7)=vtsst_result(k,3)/vtsst_result(k,4);
       if vtsst_result(k,6)==1
           err=err+1;
           vtsst_errmat(err,1)=vtsst_result(k,3);
           vtsst_errmat(err,2)=vtsst_result(k,4);
           vtsst_errmat(err,3)=vtsst_result(k,7);
       else
           ac=ac+1;
           acmat(ac,1)=vtsst_result(k,3);
           acmat(ac,2)=vtsst_result(k,4);
           acmat(ac,3)=vtsst_result(k,7);
       end
   end
   
   [ef ec]=size(vtsst_errmat);
   [af acol]=size(acmat);
   
   parestat(1,:)=[mean(acmat,1) mean(vtsst_errmat,1)];
   parestat(2,:)=[max(acmat,[],1) max(vtsst_errmat,[],1)];
   parestat(3,:)=[min(acmat,[],1) min(vtsst_errmat,[],1)];
   parestat(4,:)=[std(acmat,0,1) std(vtsst_errmat,0,1)];
   parestat(5,:)=[median(acmat,1) median(vtsst_errmat,1)];
   
   if af>1
       if ef>1
           parestat(6,:)=[prctile(acmat,25) prctile(vtsst_errmat,25)];
           parestat(7,:)=[prctile(acmat,75) prctile(vtsst_errmat,75)];
           tcomp=2;
       else
           parestat(6,:)=[prctile(acmat,25) vtsst_errmat];
           parestat(7,:)=[prctile(acmat,75) vtsst_errmat];
           tcomp=2;
       end      
   else
       if ef>1
           parestat(6,:)=[acmat prctile(vtsst_errmat,25)];
           parestat(7,:)=[acmat prctile(vtsst_errmat,75)];
           tcomp=3;
       else
           parestat(6,:)=[acmat vtsst_errmat];
           parestat(7,:)=[acmat vtsst_errmat];
           tcomp=4;
       end
   end
   
      
   fid=fopen(file,'w');
	
	for i=1:7
        fprintf(fid,'%s\t',userinfo{i});
        fprintf(fid,'%s',userdata{i});
        fprintf(fid,'\n');
	end
	fprintf(fid,'\n');
    
    for i=1:7
        fprintf(fid,'%s\t',coluna{i});
    end
    fprintf(fid,'\n');
    
    for i=1:fr
        fprintf(fid,'%4.3f\t',vtsst_result(i,:));
        fprintf(fid,'\n');
    end   
    fprintf(fid,'Tempos Totais[s]:\t\t%4.3f\t%4.3f',somadig,somacal);
    fprintf(fid,'\n\n');
    
    fprintf(fid,'\tACERTOS\tERROS\tTotal digitados\n');
    fprintf(fid,'N\t%d\t%d\t%d\n%%\t%2.2f\t%2.2f',ac,err,fr,100*ac/fr,100*err/fr);
    
     fprintf(fid,'\n\n');
     
     fprintf(fid,'\tTEMPOS DE DIGITACAO\n\tACERTOS\tERROS\n');
     for i=1:7
         fprintf(fid,'%s\t%4.3f\t%4.3f',estat{i},parestat(i,1),parestat(i,4));
         fprintf(fid,'\n');
     end
     
     fprintf(fid,'\tTEMPOS DE CALCULO\n\tACERTOS\tERROS\n');
     for i=1:7
         fprintf(fid,'%s\t%4.3f\t%4.3f',estat{i},parestat(i,2),parestat(i,5));
         fprintf(fid,'\n');
     end
     
     fprintf(fid,'\tTD/TC\n\tACERTOS\tERROS\n');
     for i=1:7
         fprintf(fid,'%s\t%4.3f\t%4.3f',estat{i},parestat(i,3),parestat(i,6));
         fprintf(fid,'\n');
     end
     fclose(fid);
 else
    dataadd=questgld('A informacao do usuario esta incompleta, deseja completa-la agora?',...
        'Informacao incompleta!','Sim','Nao','Sim');
    if dataadd=='Sim'
        eval(huserconfig_callback);
    else
        userok=1;
        exportar;
    end
end
     
    