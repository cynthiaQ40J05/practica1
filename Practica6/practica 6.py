import time
import urllib.request
from bs4 import BeautifulSoup


url=input('Ingrese la URL:')
info=urllib.request.urlopen(url).read().decode()
bsoup=BeautifulSoup(info)
tags=bsoup('a')
print('Dominios relacionados con la URL')
print('Buscando, espere unos segundos')
time.sleep(5)
for i in tags:
    print(i.get('href'))
print('se ha finalizado la busqueda')
