---
published: true
layout: post
title: "NHibernate for dummies"
date: 2008-08-07 14:09:00
categories: programacion orm
---

Sabemos hoy en día que la mayoría de las empresas basan sus aplicaciones en software analizado, diseñado y programado orientado a objetos. Novutek, los últimos meses se ha preocupado porque que cada vez en los desarrollos que se venden se utilicen objetos para crear modelos de negocio, que con esto, sin duda si creamos un modelo de dominio orientado a objetos será más claro el negocio para que el que lo necesite entender y código fácil mucho mas mantenible para los programadores que lo vayan a modificar.

Por otro lado tenemos la información, los datos, y probablemente todos nosotros en nuestros desarrollos hemos trabajado con bases de datos relacionales tales como SQL Server, MySQL, entre otras. Esta información seguramente necesitara cambiar e irse modificando, así como también necesitaremos tener esta información disponible cuando queramos, esto en al área de desarrollo de sistemas se le conoce como persistencia. Como se relaciona esto? el modelo relacional de datos es la representación más clara de los objetos de negocio que existen en nuestro dominio de sistema y este necesitara almacenar información de cada una de sus entidades dentro del mismo dominio (Clientes, Productos, Usuarios, etc) y al conjuntarse nace un concepto conocido como Object Relational Mapping (ORM).

NHibernate (NH) es un marco de trabajo ORM para ambientes en los que utilizamos .NET que nace de un port de Hibernate de Java y la gran utilidad es que ayuda a mapear los objetos de negocio que creamos en nuestras aplicaciones de .NET a bases de datos relacionales.

A partir de ahora intentaremos explicar cómo funciona a grandes rasgos NH y como podríamos aplicarlo a los nuevos desarrollos en la empresa. Para la práctica estaremos utilizando la versión 2008 del Visual Studio Team System (VSTS 2008) como IDE de desarrollo y la versión express del SQL Server 2005.

##1. Crear un proyecto biblioteca de clases

Este proyecto deberá de contener nuestros objetos de negocio, y por lo tanto aquellos objetos que deseamos persistir. Como ya hemos mencionado en otros tutoriales, se recomienda como buena práctica crear un archivo de solución (sln) y en este agregar tantos proyectos vayamos a necesitar.

![Paso 1](https://app.box.com/representation/file_version_14966616093/image_2048_jpg/1.jpg)

Para este tutorial he creado un proyecto llamado Tutorial.NH.BOL que es la biblioteca de clases que contendrá las entidades que representaran la base de datos.

##2. Crear modelo

Nuestro modelo de dominio estará basado en usuarios (crearemos una carpeta con nombre Entidades en nuestro proyecto para depositar nuestras clases) y las diversas tareas que puede tener un usuario, sabemos que nuestras aplicaciones empresariales son más complejas, pero creo que bastará con explicar lo esencial para entender lo que es NH. La idea de esto es poder persistir estas entidades en nuestra base de datos relacional. Para hacer más sencillo el entendimiento de NH imagínense que una instancia de cada una de nuestras entidades en una fila de una tabla de la base de datos, pero no se casen con este concepto.

Es una buena práctica usar el diagramador de clases que por defecto cuenta el VSTS 2008, el trabajo es más limpio, mas controlado y lo mejor de todo en la mayoría de los casos ¡no tenemos que escribir código! =).

![Paso 2](https://app.box.com/representation/file_version_14966703179/image_2048_jpg/1.jpg)

##3. Crear modelo relacional

El modelo relacional estará representado por aquellas tablas de base de datos las cuales deberán de representar las entidades del modelo de dominio que queremos persistir. Ya sea en el IDE de VSTS 2008 o en la consola de Microsoft SQL Server deberemos de obtener algo como esto (algo ideal sería utilizar NH para generar el esquema de nuestra base de datos acorde a nuestro modelo de dominio, este método queda fuera del alcance del tutorial):

![Paso 3](https://app.box.com/representation/file_version_14966701891/image_2048_jpg/1.jpg)

##4. Mapeo ORM

La manera en cómo se mapeara el modelo de dominio con nuestro modelo relacional es a través de documentos XML, esto se hace con el fin de documentar la relación que existe entre nuestro objeto y la tabla que lo representa en la base de datos, es decir, el documento de configuración define que campos en la base de datos corresponden a los atributos en nuestro objeto y viceversa. La relación puede hacerse mediante código (con ayuda de la librería NHibernate.Mapping.Attributes.dll) en los atributos de la clase ó a través de archivos como los que acabo de comentar, archivos XML que tienen la extensión .hbm.xml, es por esto que nuestros archivos mapping deberan llamarse Usuario.hbm.xml y Tarea.hbm.xml. No hay que perder de vista que el .hbm es parte del nombre del archivo y es una convención que utiliza NH para identificar los archivos como mapping.

Antes de empezar a trabajar con nuestro mapeo ORM debemos de descargar la versión 1.02 de NHibernate para .NET, la cual está disponible en la siguiente dirección: http://downloads.sourceforge.net/nhibernate/NHibernate-1.2.0.GA-bin.zip?modtime=1178204756&big_mirror=0

Se recomienza habilitar el Intellisense para el mapeo y la creación de estos archivos de configuración, para esto debemos de copiar los archivos nhibernate-configuration.xsd (para la configuración de las sesiones, algo que veremos más adelante en este tutorial) y nhibernate-mapping.xsd (para los mappings) a las carpetas de instalación de Visual Studio, <VS .NET directorio de instalación>\Common7\Packages\schemas\xml\ si usamos VS.NET 2003 y <VS 2005 installation directory>\Xml\Schemas\ para VS.NET 2005 y 2008.

Dentro de nuestra librería de clases Tutorial.NH.BOL vamos a crear una carpeta llamada Mapping -esto con el fin de tener mas orden- la cual contendrá todos nuestros archivos de configuración y la implementación de estos la muestro a continuación:

###4.1. Usuario.hbm.xml


