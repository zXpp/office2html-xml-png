%% change the ilp cluster_result file format into the 'rttm' format.
%% if reuse ,change the parmenter of filename in row 4 ,31.
mydir='C:\Users\Administrator\Desktop\ilp_tmp\';
filelist=dir([mydir,'*.seg']);
filenum=length(filelist);
for q=1:filenum
filename=filelist(q).name;%TBL0101-MIXA1.ev_is.180.seg
findchar=strfind(filename,'.ev_is.180.seg');%�����ַ�����λ��
  %begpos=length(mydir);
  tmpname=filename(1:findchar-1);%TBL0101-MIXA1
  newname=strcat(tmpname,'.sys.rttm');%TBL0101-MIXA1.sys.rttm
tmpfile='tmp1.rttm';
fidin=fopen(filename,'r'); % ��ԭʼ�����ļ���.list��
fidtmp=fopen(tmpfile,'w'); % �������������ļ�������˵�����֣�
 while ~feof(fidin) % �ж��Ƿ�Ϊ�ļ�ĩβ
   tline=fgetl(fidin); % ���ļ�����һ���ı��������س�����
  if ~isempty(tline) % �ж��Ƿ����
    str = ';;'; %������ʽΪ���������Ƿ������ - . E e ���� �� �հ��ַ� ��������ַ�
    start = regexp(tline,str, 'once');
    if isempty(start)
      fprintf(fidtmp,'%s\n',tline);
    end
  end
 end
fclose(fidin);
fclose(fidtmp);
[a1 a2 a3 a4 a5 a6 a7 a8 a9] =textread(tmpfile,'%s%d%d%d%s%s%s%c%d');
[num,n]=size(a1);
A=[a3,a4,a9];
A=sortrows(A);
a3=A(:,1);a4=A(:,2);a9=A(:,3);b=unique(a9);
   for k=1:num
    a5{k,1}='<NA>';
    a6{k,1}='<NA>';
   end
a3=a3/100;
a4=a4./100;
a1=char(a1);
 fileid=fopen('tmp.rttm','wb');
 fileid1=fopen([newname],'wb'); %��newname ��Ϊ����ȡ���ַ�������ʽ
   for j=1:size(b)
     b1(j,:)='SPKR-INFO';
     b2(j,:)=a1(1,:);%TBL0101-MIXA1
     b3(j,:)=a2(1,:);%1
     b4(j,:)=a8(1,:)%S
   end
 formatSpec1='%s  %s   %d   <NA>     <NA>    <NA>    unknown  %c%d    <NA>\n';
   for p=1:size(b)
    fprintf(fileid1,formatSpec1,b1(p,:),b2(p,:),b3(p,:),b4(p,:),b(p,:));
   end
formatSpec='SPEAKER  %s %d  %2.3f  %2.3f    <NA>  <NA>  %c%d    <NA>\n';
   for i=1:num
%fprintf(fileid,formatSpec,b1(:),b2(:),b(:),a1(i,:),a2(i,:),a3(i,:),a4(i,:),a8(i,:),a9(i,:));
   fprintf(fileid1,formatSpec,a1(i,:),a2(i,:),a3(i,:),a4(i,:),a8(i,:),a9(i,:));
   end
 fclose(fileid);
 fclose(fileid1);
 delete('tmp.rttm');
 delete('tmp1.rttm');
end


