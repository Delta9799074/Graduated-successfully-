import numpy as np
import pandas as pd
from collections import Counter

def excel_one_line_to_list(i):
    df = pd.read_excel("E:\\bishe\data\\python_data\\subu.xls", usecols=[i],
                       names=None)
    df_li = df.values.tolist()
    df_arr = np.array(df_li)
    df_arr_valid = np.nan_to_num(df_arr)
    df_arr_valid = df_arr_valid.astype(int) 
    return df_arr_valid
    #print('This array:')
    #print(df_arr_valid)

if __name__ == '__main__':
    common_list = []
    for i in range(0,100):
        array_temp = excel_one_line_to_list(i)
        array_new = np.delete(array_temp, np.where(array_temp == 0))
        #print('This array:')
        #print(array_new)
        #print('dict:',dict(Counter(array_new)))
        #print('frequency:',Counter(array_new).most_common(3))
        common_list.append(Counter(array_new).most_common(5))
    #print(type(common_list))

    with open("E:\\bishe\data\\python_data\\subu_fre.txt","w") as f:
        for i in common_list:
            f.write(str(i))
            f.write('\n')
    f.close()

""" 
list2=[5,5,5,8,8,9,1]
def num(lis):
    lis=np.array(lis)
    key=np.unique(lis)
    result={}
    for k in key:
        mask =(lis == k)
        list_new=lis[mask]
        v=list_new.size
        result[k]=v
    return result
print(num(list2)) """