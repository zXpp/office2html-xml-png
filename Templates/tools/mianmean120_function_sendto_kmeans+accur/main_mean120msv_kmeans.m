
%% GET the mean of the sample to send to kmeans as the center data matrix
%mydir='/home/zzpp220/DATA/TEST/2520/evy_gmsv/';
 rootdir='/media/zzpp220/Data/Linux_Documents/Mobile/ILP/chain6.0/SCUTPHONE/';
 %rootdir='/home/zzpp220/Documents/mobile/DATA/TRAIN/';
  filedir=strcat(rootdir,'wav/');
  
%/home/zzpp220/Documents/mobile/MFCC/MFCC/mean120msv.m
fid = fopen('/home/zzpp220/DATA/TRAIN/lists/model_all.lst', 'rt');
C = textscan(fid, '%s %s');
fclose(fid);
%[C,IA,IC] = unique(A,'stable') returns the values of C in the same order that they appear in A
model_ids = unique(C{1}, 'stable');
nspks = length(model_ids);

label='624.500.100.21';
codebook=8;%if use vq 

tot2520=fopen(strcat(rootdir,label,'tot_cat.txt'),'wb');
each_mode=fopen(strcat(rootdir,label,'_centercat.txt'),'wb');

total=cell(2520,1);%%%%need change
mean_center=cell(nspks,1);
for j= 1 : nspks
    model_index=strcat(model_ids{j},'*.gmm'); %model_index=strcat(model_ids{j},'*_txt.gmsv');    
    filelist=dir([filedir,model_index]);
    filenum=length(filelist);
    sum=0;
    samplenum=filenum;%%%change follow your need
    for k=1:filenum
        a=filelist(k).name;findchar=strfind(a,'.gmm');
        tmpname=a(1:findchar-1); 
        totalname=strcat(filedir,filelist(k).name);
        
     %% if use gmm excrated by Miscrosoft adapt_gmm then use this 
     %tmp=load(totalname); 
   
   %%
     %%if use zx_main01_MFCC.m to get the spkr gmms
    [C,M,W,N,D] = load_mixture_model_diagb(totalname); %M IS N*D
     tmp=M';
     tmp=tmp(:);
     tmp=tmp';
     %% use the cut the frame contain 0 method to vq 
     
%      [d]=READHTK(totalname);
%         [z,x]=size(d);
%         MFCC_zerocut=[];
%         for row =1:z
%             rowline=d(row,:);
%             count_zero=size(find(rowline==0),2);%%find and count the frame who has 0 elements
%             if count_zero==0
%                 MFCC_zerocut=[MFCC_zerocut;rowline];% put the no 0 frame into new matrix
%             end
%         end
%         v=MFCC_zerocut';
%          code{k} = vqlbg(v, codebook); % Train VQ codebook
%         tmp=code{k}(:)';
    %%
     
        sum=sum+tmp;
        total{k+samplenum*(j-1)}=tmp;
        
    % dlmwrite(txtname,tmp);
    %% save the mean gmsv of each speaker.
     %txtname=strcat('/home/zzpp220/DATA/bn/gmsv_208.1024.1024.13.21-13/',tmpname,'_iv_gmsv.txt'); 
   %long_fid = fopen(txtname,'wb');
   % total_precise_array(long_fid,tmp);
    %fclose(long_fid);
    end
    avg=sum/samplenum;
    mean_center{j}=avg;
    al=cat(1,total{:});
    an=cat(1,mean_center{:});
    
end

cat_total=cat(1,total{:});
cat_mean=cat(1,mean_center{:});

%% send to kmeans
%%send to kmeans
 %a=load('cat_total.mat'); b=load('cat_mean.mat');%
[cluster_labels,newname]=sendto_kmeans(rootdir,cat_total,cat_mean,label);
%[cluster_labels,newname]=sendto_kmeans(rootdir,a.cat_total,b.cat_mean,label);
%%
%%send to accuracy&&nmi

true_labels=load('/home/zzpp220/DATA/TRAIN/lists/true_labels.lst');
send_to_accury(rootdir,true_labels,cluster_labels,label);

%%
total_precise_array(tot2520,cat_total);
total_precise_array(each_mode,cat_mean);

fclose(tot2520);  
fclose(each_mode);                                                                                                              