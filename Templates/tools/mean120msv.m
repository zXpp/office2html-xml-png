
%% GET the mean of the sample to send to kmeans as the center data matrix
%mydir='/home/zzpp220/DATA/TEST/2520/evy_gmsv/';
 rootdir='/media/zzpp220/Document&&Data/Linux_Documents/9.6/624.500.13.21/';
  mydir=strcat(rootdir,'624.500.13.21.gmm/624.500.13.21.gmm/');
%/home/zzpp220/Documents/mobile/MFCC/MFCC/mean120msv.m
fid = fopen('/home/zzpp220/DATA/TRAIN/lists/model_all.lst', 'rt');
C = textscan(fid, '%s %s');
fclose(fid);
%[C,IA,IC] = unique(A,'stable') returns the values of C in the same order that they appear in A
model_ids = unique(C{1}, 'stable');
nspks = length(model_ids);
tot2520=fopen(strcat(rootdir,'624.500.13.21tot_cat.txt'),'wb');
each_mode=fopen(strcat(rootdir,'624.500.13.21_centercat.txt'),'wb');

total=cell(2520,1);%%%%need change
mean_center=cell(nspks,1);
for j= 1 : nspks
    model_index=strcat(model_ids{j},'*.gmm'); %model_index=strcat(model_ids{j},'*_txt.gmsv');    
    filelist=dir([mydir,model_index]);
    filenum=length(filelist);
    sum=0;
    samplenum=filenum;%%%change follow your need
    for k=1:filenum
        a=filelist(k).name;findchar=strfind(a,'.gmm');
        tmpname=a(1:findchar-1); 
        totalname=strcat(mydir,filelist(k).name);
        
      
     %tmp=load(totalname); % if use gmm excrated by Miscrosoft adapt_gmm then use this
   
   
     
    [C,M,W,N,D] = load_mixture_model_diagb(totalname); %M IS N*D
     tmp=M';
     tmp=tmp(:);
     tmp=tmp';
    
     
        sum=sum+tmp;
        total{k+samplenum*(j-1)}=tmp;
        
    % dlmwrite(txtname,tmp);
    %% save the mean gmsv of each speaker.
     %txtname=strcat('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/',tmpname,'_iv_gmsv.txt'); 
   %long_fid = fopen(txtname,'wb');
   % total_precise_array(long_fid,tmp);
    %fclose(long_fid);
    end
    sum=sum/samplenum;
    mean_center{j}=sum;
end
cat_total=cat(1,total{:});
total_precise_array(tot2520,cat_total);
cat_mean=cat(1,mean_center{:});
total_precise_array(each_mode,cat_mean);
%dlmwrite('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/dn-13_2520cat.txt',cat_total);

%dlmwrite('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/dn-13_centercat.txt',cat_mean);
fclose(tot2520);  
fclose(each_mode);                                                                                                              