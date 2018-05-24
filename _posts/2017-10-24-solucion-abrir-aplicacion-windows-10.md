---
layout: post
title: No se puede abrir aplicación en Windows 10
tags: windows
---

![]({{ site.url }}/img/cantopenapp.PNG)

## Cuenta predefinida de administrador no nos deja abrir nuestras aplicaciones, solución:

* Abrir ventana msdos con privilegios de administrador y ejecutar el siguiente comando: net user Administrador /active:yes
* Ingresar a la configuración de control de cuentas de usuario y elegir notificar siempre (la barrita hasta el nivel máximo superior)
* Ingresar configuración de seguridad SECPOL.MSC:
	* Directivas locales
		* Opciones de seguridad y dentro de las opciones, habilitar la directiva "Control de cuentas de usuario: Modo de aprobación de administrador para la cuenta predefinida Administrador
* Reiniciar equipo

Comandos:

- WINDOWS+X
- CMD
- UAC
- SECPOL.MSC