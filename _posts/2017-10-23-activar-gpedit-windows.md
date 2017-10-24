---
layout: post
title: Activar Gpedit en Windows
tags: windows
---

## Para sistemas operativos como Windows 10 Home Single Language

* Descarga y descomprime este [archivo][1]
* Instala el ejecutable pulsando con el botón derecho del ratón > EJECUTAR COMO ADMINISTRADOR
* Si tu sistema operativo es de 64 bits tienes que ir a la carpeta C:\Windows\SysWOW64 y copiar las carpetas “GroupPolicy“, “GroupPolicyUsers” y el archivo “gpedit.msc” para después pegarlo en C:\Windows\system32

Si por algún motivo el editor no arrancara deberíamos descargar estos [archivos adicionales][2]. Después tendríamos que copiarlos en la carpeta C:\Windows\Temp\gpedit reemplazando los archivos ya existentes. Una vez copiados estos archivos si nuestro equipo es de 64 bits tendríamos que ejecutar el archivo x64.bat y si fuera de 32 bits el archivo x86.bat

[1]:{{ site.url }}/download/Instalador de gpedit.zip
[2]:{{ site.url }}/download/Archivos adicionales gpedit.zip