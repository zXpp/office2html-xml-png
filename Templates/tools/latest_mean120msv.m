% % change the workspace to mydir
 mydir='/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/bn500-13-gmsv/2520sep_gmm/';
% % fid = fopen('/home/zzpp220/DATA/TRAIN/lists/model_all.lst', 'rt');
% % C = textscan(fid, '%s %s');
% % fclose(fid);
% % %[C,IA,IC] = unique(A,'stable') returns the values of C in the same order that they appear in A
% % model_ids = unique(C{1}, 'stable');
% % nspks = length(model_ids);
% filelist=dir([mydir,'*.mat']);
% matnum=length(filelist);
% for q=1:matnum,
%     filename=filelist(q).name;%TBL0101-MIXA1.ev_is.180.seg
%     findchar=strfind(filename,'.mat');%�����ַ��λ��
%   %begpos=length(mydir);
%      tmpname=filename(1:findchar-1);%TBL0101-MIXA1
%      newname=strcat(tmpname,'_txt.gmsv');
%      fid2=fopen([newname],'wb');
%      totalname=strcat(mydir,filelist(q).name);
%      mat=load(totalname);
%      mat1=(mat.gmm.ubm.mu);
%      mat=mat1(:)';
%      dlmwrite([newname],mat);
%      fclose(fid2);
% end





%% GET the mean of the sample to send to kmeans as the center data matrix
%mydir='/home/zzpp220/DATA/TEST/2520/evy_gmsv/';
fid = fopen('/home/zzpp220/DATA/TRAIN/lists/model_all.lst', 'rt');
C = textscan(fid, '%s %s');
fclose(fid);
%[C,IA,IC] = unique(A,'stable') returns the values of C in the same order that they appear in A
model_ids = unique(C{1}, 'stable');
nspks = length(model_ids);
tot2520=fopen('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/dn-13_2520cat.txt','wb');
each_mode=fopen('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/dn-13_centercat.txt','wb');

total=cell(2520,1);
mean_center=cell(nspks,1);
for j= 1 : nspks
model_index=strcat(model_ids{j},'*.gmm'); %model_index=strcat(model_ids{j},'*_txt.gmsv');    
filelist=dir([mydir,model_index]);
filenum=length(filelist);
sum=0;
samplenum=120;%%%change follow your need
for k=1:filenum
   a=filelist(k).name;findchar=strfind(a,'.gmm');
   tmpname=a(1:findchar-1); 
   txtname=strcat('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/',tmpname,'_bn_gmsv.txt');
   totalname=strcat(mydir,filelist(k).name);
     %tmp=load(totalname);
    [C,M,W,N,D] = load_mixture_model_diagb(totalname); %M IS N*D
     tmp=M';
     tmp=tmp(:);
     tmp=tmp';
     long_fid = fopen(txtname,'wb');
     
     sum=sum+tmp;
     total{k+samplenum*(j-1)}=tmp;
    % dlmwrite(txtname,tmp);
    total_precise_array(long_fid,tmp);
    fclose(long_fid);
end
sum=sum/samplenum;
mean_center{j}=sum;
% f1=filelist(1).name;
% findchar=strfind(f1,'_train');
% %findchar=strfind(filelist.name,'.gmsv');%返回字符串的位置                                        
%  tmpname=f1(1:findchar-1);                                            
% %  tmpname=unique(tmpname(1));
 newname=strcat('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/21_mean_gmsv/',model_ids{j},'_mean_bn.gmsv'); 
 f=fopen(newname,'wb');                                                                                                                                                    
%f=fopen('Apple_iPhone5_30_mean','wb');
%dlmwrite(newname,sum);
total_precise_array(f,sum);
    fclose(f);                                                
end 
cat_total=cat(1,total{:});
total_precise_array(tot2520,cat_total); 
%dlmwrite('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/dn-13_2520cat.txt',cat_total);
cat_mean=cat(1,mean_center{:});
total_precise_array(each_mode,cat_mean);
%dlmwrite('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/dn-13_centercat.txt',cat_mean);
fclose(tot2520);  
fclose(each_mode);                                                                                                              