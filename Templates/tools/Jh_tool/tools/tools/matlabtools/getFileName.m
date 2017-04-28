function info = getFileName(dirName, filename)
%���dirNameĿ¼�������ļ���Ϊfilename���ļ���������Ϣ��·����Ϣ��������info������
%���룺 dirName - Ŀ¼��
%       filename  - �ļ���
%����� info    - �����ļ���Ϣ��Nά�ṹ���飬N���ļ�����Ŀ��N(i).name�ǵ�i���ļ������ƣ�N(i).path�ǵ�i���ļ���·��

w.name  = [];
w.path  = [];
info(1) = w;

%�ݹ�
info = iter(dirName, filename, info);

info(1) = [];		


function s = iter(dirName, filename, s)

content = dir(dirName); %���dirNameĿ¼�����е��ļ���Ŀ¼��Ϣ��������content��

for i = 3:length(content)
  name = content(i).name;
  path = [dirName '/' content(i).name];

  if(content(i).isdir) %Ŀ¼
     s = iter(path, filename, s); %�ݹ�
  else %�ļ�
    if(strfind(lower(name), lower(filename))) %�ҵ���Ϊfilename���ļ�
		w.name = name;      %����ļ�������
		w.path = path;      %����ļ���·��
		s(length(s)+1) = w; %�����ļ���Ϣ
	end
  end   
  
end
