#!/bin/bash 
# ./aibtotal.sh $1 $2
## this script is to do the procedure after your give the files in rootdir ie . 620_21 dir include 630_21.scp ,630_21.ref.rttm,630_21.wav then run this script it will get the der result automaticlly 
rootdir=/home/zzpp220/DATA/TRAIN/$1
if [ -e $rootdir ]
then 
	echo ----------->>---dirfile----EXIST -- OK
	#mkdir $rootdir
	if [ -e $rootdir/$1.scp ]
	then 
	 	echo copy .scp to aib\/tmp,data
	 	cp $rootdir/$1.scp /home/zzpp220/spkr_diar/tmp/
	 	cp $rootdir/$1.scp /home/zzpp220/spkr_diar/data/
	 	cp $rootdir/$1.scp /home/zzpp220/spkr_diar/scripts
		cp $rootdir/$1.wav /home/zzpp220/spkr_diar/data/wav
	
		if [ -e ~/DATA/TRAIN/$2 ]
		then
	 		echo extract fea
	#$2 is hcopy scp file,can be generated by jh_hcopy_scp.py -->210_21.scp
			echo \/home\/zzpp220\/spkr_diar\/data\/wav\/$1.wav\ \/home\/zzpp220\/spkr_diar\/data\/mfcc\/$1.fea >> ~/DATA/TRAIN/$2
	 		HCopy -A -D -C ~/HTK/mob2mfcc.cfg -S ~/DATA/TRAIN/$2
		
	
			echo aib begins
			source /home/zzpp220/spkr_diar/scripts/test_1stream.sh $1
			echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			cat /home/zzpp220/spkr_diar/scripts/test_1stream.sh
			echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\		
			
			echo copy the result sys.rttm to score--->sys.sttm and rename
			cp /home/zzpp220/spkr_diar/tmp/chain.sys.rttm /home/zzpp220/Documents/score/sys_tmp/$1.sys.rttm
	
			echo copy .ref.rttm to scoreref\/chain_ref
			cp $rootdir/$1.ref.rttm /home/zzpp220/Documents/score/chain_ref/
	
	
			echo change the reference.list
			echo \/home\/zzpp220\/Documents\/score\/chain_ref\/$1.ref.rttm >>/home/zzpp220/Documents/score/reference2.list
			echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\		
			cat /home/zzpp220/Documents/score/reference2.list
			echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
			echo useage.sh
			source /home/zzpp220/Documents/score/useage.sh
		else 
	 		echo ******************no $2 
		fi
	else 
	 	echo *************** $1.scp NO EXIST\!\!
	fi
else
	echo ----------->> no $rootdir
fi
