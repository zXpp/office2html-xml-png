# -*- coding: gb18030 -*-
"""
Created on Wed Jul 12 13:23:35 2017

@author: z81022868
"""
from __future__ import unicode_literals
import pandas as pd
import xlrd,xlwt
from collections import OrderedDict
import sys,os,re
from fileselectcut import TestExcel

'''
ȷ�����ı����ͣ���Ȼ���ӻᶪʧ��*****************************
���Ҫ���Ի�ȡ�ϲ���Ԫ�񣬾�Ҫת��Ϊxls��ʽ��ע�ⲻȻ��ȡ�ϲ���Ԫ��Ĳ���������
unicode���ü�U
gbk�ı����Ҫ�ӣ�
һ��ִ��һ���ļ����ļ����ͱ������Ҫ��һ�У�����ֺܶ��У�Ĭ��Ϊ�ö��е����ΪĿ��������ļ����ͱ������ͷ�ͽ�β�����пո�,Ӣ��Ҫ��Ӣ�����뷨�����롣
'''
#==============================================================================
def getDevPrior(label,single_col,col_series=[]):
    contain=[]
#     if label.decode('gbk') in single_col:#����{һ����񡢶������}
    for ele in enumerate(single_col) :#col_contΪ����и���������
        if ele and ele[1] not in ['',b'',label.decode('gbk')]:
            contain.append(ele)
    if contain:
        batch_fill=[]#��������ظ�ֵ֮�����

        batch_fill.append(contain[0][1])#�������
        for i in range(contain[0][0]+1,len(single_col)):
            if single_col[i] in [b'','']:
                if single_col[i-1] in [b'','']:
                        batch_fill.append(batch_fill[-1])
                else:
                        batch_fill.append(single_col[i-1])
            else:
                batch_fill.append(single_col[i])
        batch_fill.reverse()
        col_series.append(batch_fill)#����в�����������
    return col_series
#==============================================================================

def setColWidth(excelname,sheetname,dataframe_cols,width):
    file2=xlwt.Workbook(encoding='gb18030')
    #fie2name=excelname.decode("GBK",'ignore')
    sheet = file2.add_sheet(sheetname)
    for xlcol in range(dataframe_cols+10):
        sheet.col(xlcol).width=256*int(width)
    file2.save(excelname)
def prompt():
    #print "Unexpected error at your file,check your filename....." ,sys.exc_info()
    raw_input('press enter key to exit')
if __name__ == "__main__":
    # Create QApplication
    import guidata
    _app = guidata.qapplication()
    #app.exec_()
    e = TestExcel()
    #e.view()
    #e.floatarray[:, 0] = np.linspace( -5, 5, 50)
    ##print(e)
    if e.edit():pass
#        e.edit()
#        #print(e)
    e.view()
    e.files.fnames
#if __name__=="__main__":
    try:
        filedir,files=e.files.dir,e.files.fnames#·��+·���ļ�
        sheet=e.string
        for excelfile in files:
#        #print '����ת���ļ��Ƶ���Ŀ¼��:�����������ļ�����չ������ɺ�����# �磺OLT ҵ���͵���Spec����ģ��.xlsm#'
#        tpath='OLT ҵ���͵���Spec����ģ��.xlsm#'.decode('gbk').split('#')[0].strip()#raw_input('Now input your filename:').decode('gbk').split('#')[0].strip()
#        #print 'Successfully input excelname !Finding && reading the input file ����'
#
#        path=os.path.join(os.getcwd(),tpath)
#        try:

            data = xlrd.open_workbook(excelfile)#huo qu merged cell
            #print 'OK\n','now �����ļ������ݱ�ı�������ɺ�����#,��: OLT#','\n'
            tablename=sheet.decode('gbk').strip()#raw_input('Now input your sheetname:').decode('gbk').split('#')[0].strip()
            try:
                table=data.sheet_by_name(tablename)#閫氳繃鍚嶇О鑾峰彇
                #print 'OK , The output excel named: DataOut.xlsx will be at current path'
                nrows,ncols = table.nrows,table.ncols
                '''
                #�ж��Ƿ��кϲ���Ԫ��;#��ǰ10�У���ȡ�������������б�ţ�׼��д�룻#���ϲ���Ԫ�񣬻�ȡ�豸�����ͺ����б�ţ�׼��д��#�Ժϲ���Ԫ�������'''
                copy_col,name=[],[]
                #==============================================================================
                '''���ҵ����˵����λ�ã��ڴ�����������3����Ԫ��ʼ������Ҫ�ж��ǲ��Ǹ��еĹ����������Ƕ�Ӧ�Ĳ�Ū���ˡ�Ҫ�ж��ǲ������ı�����\n��ĩβ�ĺ��ԣ����滻��<p></p>
                "һ��������������񡢹��������Ƿ��ڸ��е�����ֵ�У�ȥ��"  �������汾�š�����"����'''
                para=OrderedDict()
                devs_Paravalue=OrderedDict()
                #print 'extracting parameters����'
                for col_ind in range(0,ncols):
                    col_cont=table.col_values(col_ind)
                    if ('�����' or '����' or '���' or '�汾֧�����' or '֧������') not in col_cont[:20] :

                        if 'һ�����' in col_cont:
                            tmp_ser1=getDevPrior('һ�����',col_cont)
                            #print 'һ��������'
                        elif '�������' in col_cont:
                            tmp_ser2=getDevPrior('�������',col_cont,col_series=tmp_ser1)
                            #print '����������'
                        elif '�������' in col_cont:
                            ser=getDevPrior('�������',col_cont,col_series=tmp_ser2)
                        elif unicode(u'�����') in col_cont:
                            cate_4=[]
                            for ele in enumerate(col_cont):

                                if ele and ele[1] != unicode(u'�����'):
                                    #para['4rd-cate']=contain
                                    cate_4.append(ele[1])
                            if cate_4:
                                cate_4.reverse()
                                ser.append(cate_4)
                                #print '��������'
                        elif unicode(u'֧������') in col_cont :

                            dev_name=col_cont[col_cont.index(unicode(u'֧������'))-2] if col_cont[col_cont.index(unicode(u'֧������'))-2] not in ['', b''] else col_cont[col_cont.index(unicode(u'֧������'))-3] #2,3,4
                            #dev_name=dev_name_list[0].encode("GB18030")
                            name.append(dev_name)
                            col_ind+=1
                            col_cont=table.col_values(col_ind)
                            if unicode(u'���˵��') in col_cont:
#                                #print '����',
#                                for x in range(len(col_cont)):
#                                    if col_cont[x] not in [b'','','���˵��']:
#                                        beg_ind=x
#                                        break
                                dev_val=col_cont[col_cont.index('���˵��')+3:]  ##绌轰�?,7l涓よ�?

                                if dev_name not in devs_Paravalue.keys():
                                     devs_Paravalue[dev_name.encode("GB18030")]=dev_val

                                else:
                                     #print col_ind ," : col",dev_name ,u' �Ѿ����ڣ�����Դ�������!'
                                     sys.exit()
                    else:
                         continue

                minn=min(map(len,ser))-1#serr=ser[:]
                ddd=[ser[1][:minn][::-1],ser[2][:minn][::-1]]

                #print '\nData extracted sucessfully! Now writing to new file����\n'
                oltdata=pd.DataFrame(devs_Paravalue.values(),index=name,columns=range(len(ser[2][:minn][::-1]))).transpose()
                #oltdata2=oltdata
                oltpara=pd.DataFrame(ddd,index=['compareTypeInfo','compareItem']).transpose()
                #oltpara2=oltpara
                oltall=oltpara.join(oltdata,how='outer')
                oltall.drop_duplicates(cols=["compareItem"],inplace=True)

                excelout=os.path.join(filedir,"Data_out.xlsx")
                setColWidth(excelout,'�Ƚ���Ϣ',oltall.shape[1],200)

                if not os.path.exists(os.path.join(os.getcwd(),excelout)):
                    setColWidth(excelout,'�Ƚ���Ϣ',oltall.shape[1],200)
                else:
                    pattern=r'^(.*(?:[^\W\d_]*))\n(.+)$'
                    reg=re.compile(pattern,re.M)
                    for dcol in oltall.columns[2:]:#range(oltall.shape[1]-1):
                        for drow in range(oltall.shape[0]-1):
                            if not isinstance(oltall[dcol].iloc[drow],str)and not isinstance(oltall[dcol].iloc[drow],unicode):
                                oltall[dcol].iloc[drow]=str(oltall[dcol].iloc[drow])
                            check=reg.findall(oltall[dcol].iloc[drow])#.iat[drow,dcol])
                            if check:
                                oltall[dcol].iloc[drow]=re.sub(reg,r'<p>\1</p> <p>\2</p>',oltall[dcol].iloc[drow])
#                        finded=oltall[dcol][oltall[dcol].str.contains(pattern,na=False)]
#                        #print finded
#                        if finded:
#                            for ind in finded.index:
#                                oltall[dcol][ind]=oltall[dcol][ind].replace(pattern,'<p>\1</p> <p>\2</p>')
#                        #print oltall[dcol]
#                        for index_re in finded.index[0]:
#                            oltall[dcol][index_re]=u'<p>'+oltall[dcol][index_re]+u'</p>'
#                    #oltall2.replace(to_replace='\n',value='<p></p>')
                    ss=pd.ExcelWriter(excelout)
                    oltall.to_excel(ss,'�Ƚ���Ϣ',index=False)
                    ss.save()
                    #print 'Finished,go and check the new file DataOut.xlsm under this path!'
                    #print time.strftime('%Y-%m-%d %A %X %Z',time.localtime(time.time()))
                    time.sleep(3)
                    raw_input('press enter key to exit')
    #==============================================================================
            except:
                prompt()
#        except:
#            prompt()
    except:
        prompt()