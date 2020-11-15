from ftplib import FTP
import os, re
import pickle

def list_folder(con: FTP, directory:str):
    listado = []
    con.retrlines(f'LIST {directory}', listado.append)
    #print(listado)
    return listado

def get_file_dir(con: FTP, directory:str):
    listado = list_folder(con,directory)
    return [file_info for file_info in listado if file_info.startswith('-')],  \
        [file_info for file_info in listado if not file_info.startswith('-')]

def save_file(con: FTP, remote_file_path:str, local_file_path:str):
    with open(local_file_path,'wb') as local_file:
        con.retrbinary(f'RETR {remote_file_path}', local_file.write)

def get_txt_file(con: FTP, file_path:str):
    listado = []
    con.retrlines(f'RETR {file_path}', listado.append)
    return listado

    
ftp = FTP('ftp.us.debian.org')
ftp.login()
ftp.pwd()
#ftp.retrlines('LIST') 
save_path='/Users/Cynthia/Desktop/laboratorios'
l_file, l_dir = get_file_dir(ftp, 'debian')
file_name = 'welcome.msg'
save_file(ftp, file_name, f'{save_path}/{file_name}')
#print(l_file)
#print(l_dir)
ftp.cwd('debian')
ftp.retrlines('LIST')

listado_allfiles = []
for fichero in l_dir:
    p = re.compile(r"(\w+)$")
    d = p.search(fichero)
    f = str(d.group(0))
    l_file, l_dir = get_file_dir(ftp, f)
    listado_allfiles.append(l_file)

with open('archivo.txt','a+', encoding='utf-8') as f:
    for file in listado_allfiles:
        for e in file:
            f.write('{}\n'.format(e))
            
