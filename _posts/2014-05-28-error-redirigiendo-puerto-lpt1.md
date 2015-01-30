---
published: true
layout: post
title: Acceso denegado al redirigir el puerto LPT1 en Windows
date: 2014-05-28 15:00:00
categories: it windows
---

En un sistema POS (PointOfSale) que tenemos en la empresa donde trabajo, nos vemos en la necesidad por decision del proveedor, tener que redireccionar al puerto lpt1 de la computadora la impresora de tickets que conectada a través del puerto USB.

En el departamento de TI tenemos como política que las cuentas de inicio de sesión de las computadoras de los usuarios no cuentan con privilegios de Administrador, al menos que sea requerido por alguna autoridad o se justifique.

Para realizar la asignación de la impresora al puerto lpt1 usamos el comando de msdos NET USE, el cual nos permite redireccionar al puerto, la sintáxis del comando es:

> NET USE LPT1: \\HOST\PRINTER /PERSISTENT:YES

En donde HOST es el nombre de la computadora o dirección IP y PRINTER el nombre del recurso compartido que se asigno a la impresora.

El problema es que en cuentas sin privilegios de administrador, al querer usar el comando NET USE nos topamos con el mensaje **_access denied_**, el cual nos indica que no es posible imprimir en el puerto LPT1.

Para corregir esto y no morir en el intento de impedir que los usuarios hagan lo que quieran en el PC y dejarlos como usuario estándar en el equipo, hay que modificar el puerto LPT1 en el administrador de dispositivos de Windows, y asignarle uno nuevo, por ejemplo, cambiarle de LPT1 a LPT2 por ejemplo; de esta manera liberamos el puerto para que el usuario del PC en turno pueda usarlo.

![Administrador de Dispositivos](https://dl.dropboxusercontent.com/u/1671360/robertoramirez.github.io/assets/portlpt1.png)
