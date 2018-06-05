%%%%descargar los archivos de webiio del openquake en formato csv, ademas
%%%%de un archivo mean que es el resultado de el promedio ponderado de cada
%%%%realizacion con los pesos de las realizaciones, esto  esta
%%%%comprovado.

 feature('DefaultCharacterSet', 'UTF8');
[file,path] = uigetfile('*.csv','MultiSelect', 'on');
if isequal(file,0)
  disp('User selected Cancel');
else
  disp(['User selected ', fullfile(path,file)]);
end
img=fullfile(path,file);

if iscell(img)==1;

for i=1:length(img);  
	fileID = fopen(img{1,i});
    C = textscan(fileID,'%s %s %s %s','Delimiter',',');
    fclose(fileID);
    
MMM=[];
MMM1=[];
MMM2=[];
MMM3=[];
MMM4=[];
    j=0;
    k=0;
    l=0;
    p=0;
for i=1:length(C{1})
    if str2num(C{1}{i})<99999999999999;
    j=j+1;
    k=k+1;
    l=l+1;
    p=p+1;
    if str2num(C{1}{i})*0==0; MMM1(j)=str2num(C{1}{i});else MMM1(j)=0;end;
    if str2num(C{2}{i})*0==0; MMM2(k)=str2num(C{2}{i});else MMM2(k)=0;end;
    if str2num(C{3}{i})*0==0; MMM3(l)=str2num(C{3}{i});else MMM3(l)=0;end;
    if str2num(C{4}{i})*0==0; MMM4(p)=str2num(C{4}{i});else MMM4(p)=0;end;
    MMM=transpose([MMM1;MMM2;MMM3;MMM4]);
    else; 
        
    end;
end;
ejex=C{1}{3}
ejey=C{2}{3}
ejez='Poe'
i=0;
j=0;
k=0;
x1  = MMM(:,1); xx1=unique(x1);xxx1=length(unique(x1));
x2  = MMM(:,2); xx2=unique(x2);xxx2=length(unique(x2));
x3  = MMM(:,3); xx3=unique(x3);xxx3=length(unique(x3));
x4  = MMM(:,4); xx4=unique(x4);xxx4=length(unique(x4));
M=[];
MM=[];
for i=1:xxx1;
for j=1:xxx2;
k=k+1;    
M(j)=x3(k);
end;
MM=[MM;M];
end;
MM=transpose(MM)
i=length(MM)
% i=20
figure
MM=MM(1:i,:)

h=bar3(MM,0.5)
title('Desagregação Magnitude-Distância')
ax = gca;
ax.XTick = [1:1:length(xx1)]; 
ax.XTickLabels = transpose(xx1)-(xx1(2)-xx1(1))*0.5;
ax.YTick = [1:1:length(MM)]; 
ax.YTickLabels = transpose(xx2)-(xx2(2)-xx2(1))*0.5;

% hh = get(h(1),'parent');
% hhh = get(h(2),'parent');
% set(hh,'xticklabel',transpose(xx1)-(xx1(2)-xx1(1))*0.5);
% % hh = get(h(3),'parent');
% xtick = [1:1:length(MM)];
% set(hhh,'yticklabel',transpose(xx2));
xlabel(ejex)
ylabel(ejey)
zlabel(ejez) 
axis tight    
end;

else
feature('DefaultCharacterSet', 'Windows-1250');
 %%%si solo se escoge uno
fileID = fopen(img);
C = textscan(fileID,'%s %s %s %s','Delimiter',',');
fclose(fileID);


MMM=[];
MMM1=[];
MMM2=[];
MMM3=[];
MMM4=[];
    j=0;
    k=0;
    l=0;
    p=0;
for i=1:length(C{1})
    if str2num(C{1}{i})<99999999999999;
    j=j+1;
    k=k+1;
    l=l+1;
    p=p+1;
    if str2num(C{1}{i})*0==0; MMM1(j)=str2num(C{1}{i});else MMM1(j)=0;end;
    if str2num(C{2}{i})*0==0; MMM2(k)=str2num(C{2}{i});else MMM2(k)=0;end;
    if str2num(C{3}{i})*0==0; MMM3(l)=str2num(C{3}{i});else MMM3(l)=0;end;
    if str2num(C{4}{i})*0==0; MMM4(p)=str2num(C{4}{i});else MMM4(p)=0;end;
    MMM=transpose([MMM1;MMM2;MMM3;MMM4]);
    else; 
        
    end;
end;
ejex=C{1}{3};
ejey=C{2}{3};
ejez='% contribuição de ameaça';
i=0;
j=0;
k=0;
x1  = MMM(:,1); xx1=unique(x1);xxx1=length(unique(x1));
x2  = MMM(:,2); xx2=unique(x2);xxx2=length(unique(x2));
x3  = MMM(:,3); xx3=unique(x3);xxx3=length(unique(x3));
%%hacer q te pida el tiempo de exposion
rx3=(-1/50)*log(1-x3);
nx3=rx3/(-1/50)*log(1-prod(1-x3));

x4  = MMM(:,4); xx4=unique(x4);xxx4=length(unique(x4));
M=[];
MM=[];
for i=1:xxx1;
for j=1:xxx2;
k=k+1;    
M(j)=nx3(k);
end;
MM=[MM;M];
end;
MM=100*transpose(MM);

%%%% descoemtar cuanco el ejej de distacia sea muy grande y no se observe
%%%% nada en rango de gra distacia
i=20;
MM=MM(1:i,:);
figure;
h=bar3(MM,0.9);
title('Desagregação Magnitude-Distância jb');
ax = gca;
ax.XTick = [1:1:length(xx1)]; 
    G=transpose(xx1)-(xx1(2)-xx1(1))*0.5;
    UX=2;
    for i=1:length(G);
        if floor((i)/UX)<(i)/UX;GX{i}='';else GX{i}=sprintf('%.1f',G(i)); end;
    end;
ax.XTickLabels = GX;
ax.YTick = [1:1:length(MM)]; 
    G=transpose(xx2)-(xx2(2)-xx2(1))*0.5;
    UX=2;
    for i=1:length(G);
        if floor((i)/UX)<(i)/UX;GY{i}='';else GY{i}=sprintf('%.0f',G(i)); end;
    end;
ax.YTickLabels = GY;
xlabel(ejex);
ylabel(ejey);
zlabel(ejez);
axis tight;
for k = 1:length(h)
    zdata = h(k).ZData;
    h(k).CData = zdata;
    h(k).FaceColor = 'interp';
end
colormap jet;
colorbar;
view(-60,25);
nfig=sprintf('%s.svg',file(1:end-4));
saveas(gcf,nfig);
end;