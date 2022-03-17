import os
import numpy as np
import re
import pandas as pd
import xlwt
 
with open("E:\\bishe\data\python\\divu_no_blank.txt") as txt:
    content = txt.readlines() #读全部行
    txt.close()
lines =np.array(content) #转换成array 类型
indexs = []
for k in range(lines.size):
    if(len(lines[k]) < 800):
        indexs.append(k)

newlines = np.delete(lines,indexs,0)
""" print(newlines)
print(newlines.size) """
 
num_of_instances = newlines.size #整个txt的行数
print("number of instances: ", num_of_instances)
list=[]

file = 'E:\\bishe\data\python\\divu.xls'
table = xlwt.Workbook(file)
new_sheet = table.add_sheet("data", cell_overwrite_ok=True)

for i in  range(0,num_of_instances):
    txtvalue=newlines[i]
    txtvalue = txtvalue.lstrip('0')
    txtvalue = '0000' + txtvalue
    txtvalue_sep = re.findall(r'\w{8}', txtvalue)
    #dec_array = []
    for j in range(len(txtvalue_sep)):
        dec_int = int(txtvalue_sep[j],16)
        new_sheet.write(j,i,dec_int)
        


table.save(file)     


    #print(dec_array)


    ##print(txtvalue_sep)
    #txtarray = np.array(txtvalue_sep)


"""     data = pd.DataFrame(dec_array)
    #data = pd.DataFrame(txtarray)
    writer = pd.ExcelWriter('E:\\bishe\data\python\A_plus.xlsx')		# 写入Excel文件
    data.to_excel(writer, 'Sheet1', float_format='%.5f',index=False,header=None,startcol=12)
    writer.save()
    writer.close() """

        