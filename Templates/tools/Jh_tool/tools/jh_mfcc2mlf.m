%%��mfcc�ļ�ת����mlf�ļ�
%ת����ɺ������޿��У�Linux�µ��ļ���ʽ������Ҫת��Ϊunix.
mydir='F:\mfcc\gunshot\';
filelist=dir([mydir,'*.mfcc']);
filenum=length(filelist);
fidout=fopen('gunshot.mlf','wb');  %��һ���ļ�����д 
fprintf(fidout,'%s\n','#!MLF!#');
for k=1:filenum
  filename=[mydir,filelist(k).name];
  [D,FP,DT,TC,T]=READHTK(filename)
  findchar=strfind(filename,'.mfcc');%�����ַ�����λ��
  begpos=length(mydir);
  tmpname=filename(begpos+1:findchar-1);
  newname=strcat(tmpname,'.lab"');
  fprintf(fidout,'"*/%s\n',newname);
 
  [row col] = size(D);  %ȡ�������������к���
  begtime=0;
  endtime=row*FP*10000000;
  fprintf(fidout,'%d %s %s\n',begtime,int2str(endtime),'Gunshot');
  fprintf(fidout,'%s\n','.');
end
fclose(fidout);