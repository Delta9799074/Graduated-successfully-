import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import xlwt

def median_noise_filter(df_data, threshold=15,rolling_median_window=50):
    exceptions = pd.Series([],dtype='float64')
    df_data['median'] = df_data['value'].rolling(window=rolling_median_window, center=True).median().fillna(method='bfill').fillna(method='ffill')
    difference = np.abs(df_data['value'] - df_data['median'])
    median_difference = np.median(difference)
    if median_difference != 0:
        s = difference / float(median_difference)
        exceptions = s[s > threshold]
    return exceptions


def excel_one_line_to_list(i):
    df = pd.read_excel("E:\\bishe\data\\python_data\\mult.xls", usecols=[i],
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
    """ file = 'E:\\bishe\data\python\\mult_filtered.xls'
    table = xlwt.Workbook(file)
    new_sheet = table.add_sheet("data_filtered", cell_overwrite_ok=True) """
    for i in range(0,101):
        array_temp = excel_one_line_to_list(i)
        #print('before:')
        #print(array_temp)
        df_data = pd.DataFrame(array_temp)
        df_data.columns = ['value']
        exp_value = median_noise_filter(df_data)
        data_index = exp_value.index
        exp_idarr = np.array(data_index)
        #print('except index is :')
        #print(len(exp_idarr))
        if(len(exp_idarr) != 0):
            nparray_filtered  = np.delete(array_temp, data_index, axis=0)
            print('Changed array index is :' + str(i))
            #path = 'E:\\bishe\data\python\\filtered\\mult' + str(i) + 'changed.txt'
            #np.savetxt(path, nparray_filtered, fmt="%d")
            x=np.arange(0,len(nparray_filtered))+1
            x[0]=1
            plt.plot(x,nparray_filtered)
            plt.grid()
            save_path = ("E:\\bishe\data\\python_data\\mult_filtered\\" + str(i) + ".jpg")
            plt.savefig(save_path)
            #plt.show()
            plt.close()
        
    #table.save(file)

