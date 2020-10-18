
#CYNTHIA PATRICIA SANDOVAL MENDOZA GPO.064
function obtenerDIP{
    $Ipconfiguracion = Get-NetIPConfiguration
    Write-Host "Tu direccion IP es:" $Ipconfiguracion.IPv4Address.IPAddress
    Write-Host "Tu direccion de puerta:" $Ipconfiguracion.IPv4DefaultGateway.NextHop
}

function obtener-conexionestcp{
    $conexiones = Get-NetConnection | Format-Table -Property LocalAddress,RemoteAddress,State, OwningProcess
}

function Ver-StatusPerfil{  
param([Parameter(Mandatory)] [ValidateSet("Public","Private")] [string] $perfil)  
$status = Get-NetFirewallProfile -Name $perfil Write-Host "Perfil:" $perfil  
if($status.enabled){  
Write-Host "Status: Activado"  
} else{  
Write-Host "Status: Desactivado"  
}  
}  

function Cambiar-StatusPerfil{  
param([Parameter(Mandatory)] [ValidateSet("Public","Private")] [string] $perfil)  
$status = Get-NetFirewallProfile -Name $perfil  
Write-Host "Perfil:" $perfil  
if($status.enabled){  
Write-Host "Status actual: Activado"  
$opc = Read-Host -Promt "Deseas desactivarlo? [Y] Si [N] No"  
if ($opc -eq "Y"){  
Set-NetFirewallProfile -Name $perfil -Enabled False  
}  
} else{  
Write-Host "Status: Desactivado"  
$opc = Read-Host -Promt "Deseas activarlo? [Y] Si [N] No"  
if ($opc -eq "Y"){  
Write-Host "Activando perfil"  
Set-NetFirewallProfile -Name $perfil -Enabled True  
}  
}  
Ver-StatusPerfil -perfil $perfil  
}  

function Ver-PerfilRedActual{  
$perfilRed = Get-NetConnectionProfile  
Write-Host "Nombre de red:" $perfilRed.Name  
Write-Host "Perfil de red:" $perfilRed.NetworkCategory  
}  

function Cambiar-PerfilRedActual{  
$perfilRed = Get-NetConnectionProfile  
if($perfilRed.NetworkCategory -eq "Public"){  
Write-Host "El perfil actual es público"  
$opc = Read-Host -Prompt "Quieres cambiar a privado? [Y] Si [N] No"  
if($opc -eq "Y"){  
Set-NetConnectionProfile -Name $perfilRed.Name -NetworkCategory Private  
Write-Host "Perfil cambiado"  
}  
} else{  
Write-Host "El perfil actual es privado"  
$opc = Read-Host -Prompt "Quieres cambiar a público? [Y] Si [N] No"  
if($opc -eq "Y"){  
Set-NetConnectionProfile -Name $perfilRed.Name -NetworkCategory Public 
Write-Host "Perfil cambiado"  
}  
}  
Ver-PerfilRedActual  
}  

function Ver-ReglasBloqueo{  
if(Get-NetFirewallRule -Action Block -Enabled True -ErrorAction SilentlyContinue){  
$reglas = Get-NetFirewallRule -Action Block -Enabled True
Foreach($i in $reglas){
Write-Host "Nombre" $i.name
Write-Host "NombreMuestra:" $i.DisplayName
Write-Host "Estado:" $i.Enabled
Write-Host "DireccionRestriccion:" $i.Direction
Write-host "Accion:" $i.Action
} 
} else{  
Write-Host "No hay reglas definidas aún"  
}  
}  

function Agregar-ReglasBloqueo{  
$puerto = Read-Host -Prompt "Cuál puerto quieres bloquear?"  
#La siguiente es una sola línea, no tiene saltos de línea 
$null = New-NetFirewallRule -DisplayName "Puerto-Entrada-$puerto" -Profile "Public" -Direction Inbound -Action Block -Protocol TCP -LocalPort $puerto  
} 

function Eliminar-ReglasBloqueo{  
$reglas = Get-NetFirewallRule -Action Block -Enabled True  
Write-Host "Reglas actuales"  
foreach($regla in $reglas){  
Write-Host "Regla:" $regla.DisplayName  
Write-Host "Perfil:" $regla.Profile  
Write-Host "ID:" $regla.Name  
$opc = Read-Host -Prompt "Deseas eliminar esta regla [Y] Si [N] No"  
if($opc -eq "Y"){  
Remove-NetFirewallRule -ID $regla.name  
#break  
}  
}  
} 

do{
$opc = Read-Host -Prompt 'Que Modulo desea Importar?
[1]ConexionesIP
[2]ConexionesTCP
[3]EstatusPerfil
[4]PerfilRed
[5]ReglasBloqueo
[6]Salir
opcion'
switch($opc){
1{
Import-Module -Name carpeta1
$opc2 = Read-Host -Prompt 'Que Funcion deseas ejecutar?
[1]DireccionIP
[2]Regresar
opcion'
switch($opc2){
1{
obtenerDIP
break
}
2{
break
}
}
break
}
2{
Import-Module -Name carpeta2
$opc2 = Read-Host -Prompt 'Que Funcion deseas ejecutar?
[1]ConexionesTCP
[2]Regresar
opcion'
switch($opc2){
1{
obtener-conexionestcp
break
}
2{
break
}
}
break
}
3{
Import-Module -Name carpeta3
$opc2 = Read-Host -Prompt 'Que Funcion deseas ejecutar?
[1]Ver-StatusPerfil
[2]Cambiar-StatusPerfil
[3]Regresar
opcion'
switch($opc2){
1{
Ver-StatusPerfil
break
}
2{
Cambiar-StatusPerfil
break
}
3{
break
}
}
break
}
4{
Import-Module -Name carpeta4
$opc2 = Read-Host -Prompt 'Que Funcion deseas ejecutar?
[1]Ver-PerfilRedActual
[2]Cambiar-PerfilRedActual
[3]Regresar
opcion'
switch($opc2){
1{
Ver-PerfilRedActual
break
}
2{
Cambiar-PerfilRedActual
break
}
3{
break
}
}
break
}
5{
Import-Module -Name carpeta5
$opc2 = Read-Host -Prompt 'Que Funcion deseas ejecutar?
[1]Ver-ReglasBloqueo
[2]Agregar-ReglasBloqueo
[3]Eliminar-ReglasBloqueo
[4]Regresar
opcion'
switch($opc2){
1{
Ver-ReglasBloqueo
break
}
2{
Agregar-ReglasBloqueo
break
}
3{
Eliminar-ReglasBloqueo
break
}
4{
break
}
}
break
}
}
}While($opc -ne 6)