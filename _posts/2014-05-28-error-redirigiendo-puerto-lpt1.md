---
published: false
---

## Error al redirigir al puerto lpt1

En un sistema POS (PointOfSale) que tenemos en la oficina, nos vemos en la necesidad por decision de proveedor, tener que redireccionar al puerto lpt1 de la computadora aquellas impresoras de tickets que estan conectadas a través del puerto USB.

En el departamento de TI tenemos como política que las cuentas de inicio de sesión de las computadoras de los usuarios no cuentan con privilegios de Administrador, al menos que sea requerido por alguna autoridad o se justifique.

Para realizar la asignación de la impresora al puerto lpt1 usamos el comando de msdos NET USE, el cual nos permite redireccionar al puerto, la sintáxis del comando es:

NET USE LPT1: \\HOST\PRINTER /PERSISTENT:YES

En donde HOST, es el nombre de la computadora o dirección IP y PRINTER el nombre del recurso compartido que se asigno a la impresora.




