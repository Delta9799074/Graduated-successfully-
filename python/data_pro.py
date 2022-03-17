""" def clearBlankLine(): """
file1 = open('E:\\bishe\data\python\\divu.txt', 'r', encoding='utf-8') # 要去掉空行的文件
stringa = file1.read()
stringa = stringa.replace(' ', '')
stringa = stringa.replace('00000080', '')
stringa = stringa.replace('000000E0', '')
stringa = stringa.replace('000000FC', '')
stringa = stringa.replace('000000FE', '')
stringa = stringa.replace('000000F8', '')
stringa = stringa.replace('000000C0', '')
stringa = stringa.replace('000000F0', '')
stringa = stringa.replace('000000FF', '')
stringa = stringa.replace('00000000', '\n')

str_temp = stringa.split("\n")

file2 = open('E:\\bishe\data\python\\divu_no_blank.txt', 'w', encoding='utf-8') # 生成没有空行的文件


#str_temp = str_temp.remove()
rm_str = [x.strip() for x in str_temp if x.strip()]
#print(rm_str)

for line in rm_str:
    file2.write(line+'\n')


file1.close()
file2.close()

#str_array = map(str,str_temp)
#print(str_temp)

""" 
stringa = stringa.replace('\n\n\n\n\n\n\n\n\n\n', '\n')
stringa = stringa.replace('\n\n\n\n\n\n\n\n', '\n')
stringa = stringa.replace('\n\n\n\n\n\n', '\n')
stringa = stringa.replace('\n\n\n\n', '\n')
stringa = stringa.replace('\n\n', '\n')
stringa = stringa.replace('\n\n', '\n') """
#stringa = stringa.replace('\n\n', '\n')
#stringa = stringa.replace('\n\n', '\n')
#stringa = stringa.replace('\n\n', '\n')

""" with open('E:\\bishe\data\python\\divu_try2_no_blank.txt', 'w', encoding='utf-8')as f:
    f.write(stringa)
    f.close() """


#print(stringa)
#print(len(stringa))
""" file2 = open('E:\\bishe\data\python\\divu_try2_no_blank.txt', 'w', encoding='utf-8') # 生成没有空行的文件

for line in stringa.readlines():
        if line == '\n':
            line = line.strip("\n")
        file2.write(line)

file1.close()
file2.close() """

""" #try:
    for line in file1.readlines():
        if line == '\n':
            line = line.strip("\n")
        file2.write(line)
#finally:
    file1.close()
    file2.close() """
""" if __name__ == '__main__':
    clearBlankLine() """
