from turtle import shapesize
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def excel_one_line_to_list(i):
    df = pd.read_excel("E:\\bishe\data\\python_data\\divu.xls", usecols=[i],
                       names=None)
    df_li = df.values.tolist()
    df_arr = np.array(df_li)
    df_arr_valid = np.nan_to_num(df_arr)
    df_arr_valid = df_arr_valid.astype(int)
    df_arr_valid = np.delete(df_arr_valid, np.where(df_arr_valid == 0)) 
    return df_arr_valid
    #print('This array:')
    #print(df_arr_valid)

if __name__ == '__main__':
    common_list = []
    for i in range(0,100):
        array_temp = excel_one_line_to_list(i)
        print(len(array_temp))
        x=np.arange(0,len(array_temp))+1
        x[0]=1
        plt.plot(x,array_temp)
        plt.grid()
        save_path = ("E:\\bishe\data\\python_data\\divu\\" + str(i) + ".jpg")
        plt.savefig(save_path, dpi=800)
        #plt.show()
        plt.close()


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