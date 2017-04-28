function info = getInfo(dirName, suffix)
%���dirNameĿ¼�������ļ���׺Ϊsuffix���ļ���������Ϣ��·����Ϣ��������info������
%���룺 dirName - Ŀ¼��
%       suffix  - �ļ����ĺ�׺
%����� info    - �����ļ���Ϣ��Nά�ṹ���飬N���ļ�����Ŀ��N(i).name�ǵ�i���ļ������ƣ�N(i).path�ǵ�i���ļ���·��

w.name  = [];
w.path  = [];
info(1) = w;

%�ݹ�
info = iter(dirName, suffix, info);

info(1) = [];		


function s = iter(dirName, suffix, s)

content = dir(dirName); %���dirNameĿ¼�����е��ļ���Ŀ¼��Ϣ��������content��

for i = 3:length(content)
  name = content(i).name;
  path = [dirName '\' content(i).name];

  if(content(i).isdir) %Ŀ¼
     s = iter(path, suffix, s); %�ݹ�
  else %�ļ�
    if(strfind(lower(name), lower(suffix))) %�ҵ���׺Ϊsuffix���ļ�
		w.name = name;      %����ļ�������
		w.path = path;      %����ļ���·��
		s(length(s)+1) = w; %�����ļ���Ϣ
	end
  end   
  
end