function info = getInfo(dirName, suffix)
%获得dirName目录下所有文件后缀为suffix的文件的名称信息和路径信息，保存在info数组中
%输入： dirName - 目录名
%       suffix  - 文件名的后缀
%输出： info    - 保存文件信息的N维结构数组，N是文件的数目，N(i).name是第i个文件的名称，N(i).path是第i个文件的路径

w.name  = [];
w.path  = [];
info(1) = w;

%递归
info = iter(dirName, suffix, info);

info(1) = [];		


function s = iter(dirName, suffix, s)

content = dir(dirName); %获得dirName目录下所有的文件和目录信息，保存在content中

for i = 3:length(content)
  name = content(i).name;
  path = [dirName '\' content(i).name];

  if(content(i).isdir) %目录
     s = iter(path, suffix, s); %递归
  else %文件
    if(strfind(lower(name), lower(suffix))) %找到后缀为suffix的文件
		w.name = name;      %获得文件的名称
		w.path = path;      %获得文件的路径
		s(length(s)+1) = w; %保存文件信息
	end
  end   
  
end