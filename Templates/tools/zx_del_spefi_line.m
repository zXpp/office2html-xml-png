%ɾ���ļ��е�ĳЩ���ϱ���str��������ʽ���У���ʣ������ݴ浽tmpfile
%ֻ��Ҫ����ı� no.5 �е��ļ�����no.10����Ҫɾ�������е������ַ�/����/��ʾ֮���������ʽ
%
tmpfile='tmp1.rttm';
fidin=fopen('train.lab','r'); % ��ԭʼ�����ļ���.list��
fidtmp=fopen(tmpfile,'w'); % �������������ļ�������˵�����֣�
 while ~feof(fidin) % �ж��Ƿ�Ϊ�ļ�ĩβ
  tline=fgetl(fidin); % ���ļ�����һ���ı��������س�����
  if ~isempty(tline) % �ж��Ƿ����
    str = '*'; %������ʽΪ���������Ƿ������ - . E e ���� �� �հ��ַ� ��������ַ�
    start = regexp(tline,str, 'once');
    if isempty(start)
      fprintf(fidtmp,'%s\n',tline);
    end
  end
 end
fclose(fidin);
fclose(fidtmp);
%data=textread(tmpfile);
% delete(tmpfile)