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

## 1. Crear un proyecto biblioteca de clases

Este proyecto deberá de contener nuestros objetos de negocio, y por lo tanto aquellos objetos que deseamos persistir. Como ya hemos mencionado en otros tutoriales, se recomienda como buena práctica crear un archivo de solución (sln) y en este agregar tantos proyectos vayamos a necesitar.

<img src="/img/14994942-paso1.jpg">

Para este tutorial he creado un proyecto llamado Tutorial.NH.BOL que es la biblioteca de clases que contendrá las entidades que representaran la base de datos.

## 2. Crear modelo

Nuestro modelo de dominio estará basado en usuarios (crearemos una carpeta con nombre Entidades en nuestro proyecto para depositar nuestras clases) y las diversas tareas que puede tener un usuario, sabemos que nuestras aplicaciones empresariales son más complejas, pero creo que bastará con explicar lo esencial para entender lo que es NH. La idea de esto es poder persistir estas entidades en nuestra base de datos relacional. Para hacer más sencillo el entendimiento de NH imagínense que una instancia de cada una de nuestras entidades en una fila de una tabla de la base de datos, pero no se casen con este concepto.

Es una buena práctica usar el diagramador de clases que por defecto cuenta el VSTS 2008, el trabajo es más limpio, mas controlado y lo mejor de todo en la mayoría de los casos ¡no tenemos que escribir código! =).

<img src="/img/14994982-paso2.jpg">

## 3. Crear modelo relacional

El modelo relacional estará representado por aquellas tablas de base de datos las cuales deberán de representar las entidades del modelo de dominio que queremos persistir. Ya sea en el IDE de VSTS 2008 o en la consola de Microsoft SQL Server deberemos de obtener algo como esto (algo ideal sería utilizar NH para generar el esquema de nuestra base de datos acorde a nuestro modelo de dominio, este método queda fuera del alcance del tutorial):

<img src="/img/14994961-paso3.jpg">

## 4. Mapeo ORM

La manera en cómo se mapeara el modelo de dominio con nuestro modelo relacional es a través de documentos XML, esto se hace con el fin de documentar la relación que existe entre nuestro objeto y la tabla que lo representa en la base de datos, es decir, el documento de configuración define que campos en la base de datos corresponden a los atributos en nuestro objeto y viceversa. La relación puede hacerse mediante código (con ayuda de la librería NHibernate.Mapping.Attributes.dll) en los atributos de la clase ó a través de archivos como los que acabo de comentar, archivos XML que tienen la extensión .hbm.xml, es por esto que nuestros archivos mapping deberan llamarse Usuario.hbm.xml y Tarea.hbm.xml. No hay que perder de vista que el .hbm es parte del nombre del archivo y es una convención que utiliza NH para identificar los archivos como mapping.

Antes de empezar a trabajar con nuestro mapeo ORM debemos de descargar la versión 1.02 de NHibernate para .NET, la cual está disponible en la siguiente dirección: http://downloads.sourceforge.net/nhibernate/NHibernate-1.2.0.GA-bin.zip?modtime=1178204756&big_mirror=0

Se recomienza habilitar el Intellisense para el mapeo y la creación de estos archivos de configuración, para esto debemos de copiar los archivos nhibernate-configuration.xsd (para la configuración de las sesiones, algo que veremos más adelante en este tutorial) y nhibernate-mapping.xsd (para los mappings) a las carpetas de instalación de Visual Studio, <VS .NET directorio de instalación>\Common7\Packages\schemas\xml\ si usamos VS.NET 2003 y <VS 2005 installation directory>\Xml\Schemas\ para VS.NET 2005 y 2008.

Dentro de nuestra librería de clases Tutorial.NH.BOL vamos a crear una carpeta llamada Mapping -esto con el fin de tener mas orden- la cual contendrá todos nuestros archivos de configuración y la implementación de estos la muestro a continuación:

### 4.1. Usuario.hbm.xml

<script src="https://gist.github.com/4079649.js?file=gistfile1.xml"></script>

Ahora podemos hablar un poco sobre el contenido del archivo XML. Todos los documentos para mapear XML deberán de declarar el espacio de nombre urn:nhibernate-mapping-2.2 (depende de la versión distribuida), así como de manera opcional los atributos assembly para indicar el ensamblado de nuestras clases y el namespace de nuestras clases en el proyecto. Existen otros atributos aplicables a nuestro archivo como el schema, que representa el nombre del esquema de la base de datos, entre otros que están fuera del alcance de este tutorial. Una vez hecho esto debemos de comenzar a tratar los atributos y elementos para la clase que deseamos mapear. Dentro de las etiquetas <class name="Usuario"></class> estarán todas aquellas configuraciones para la clase. El atributo name corresponde al nombre de la clase incluyendo el nombre del assembly. El atributo table corresponde al nombre de la tabla en la base de datos.

Con la etiqueta <id> representamos la llave primaria de la tabla de la base de datos. Este elemento define el mapeo entre la propiedad de la clase y la llave primaria de la base de datos. Entre sus atributos se encuentra el name, que indica el nombre del identificador de la propiedad; columna, que representa la columna en la tabla; type, el tipo de dato y el unsaved-value indica que el objeto es nuevo y que no existe en la base de datos.

Debemos de continuar con todas las propiedades, entonces Nombre, Apellido Paterno, Apellido Materno, Correo Electronico y Telefono deberán de estar dentro de las etiquetas <property/> y representan propiedades persistentes de la clase.

Y como habíamos dicho al inicio del tutorial, lo complicaremos creando una relación one-to-many con la clase Tarea y de esta forma representaremos la relación en la base de datos, es decir, que a un usuario se le pueden asignar varias tareas.

### 4.2. Tarea.hbm.xml

<script src="https://gist.github.com/4079650.js?file=gistfile1.xml"></script>

Lo único representativo es el elemento <many-to-one> para la propiedad Usuario de nuestra clase. Esta representa una ordinaria asociación a otra clase persistente, en este caso la que tenemos en la base de datos.

Algo que debemos de saber es que en primera instancia NH está configurado de modo perezoso (lazy load) para todas las entidades creadas. Esto se recomienda dejarse así y no moverse. Debido a esto la regla es que todas las propiedades definidas en nuestras entidades deberán ser virtuales.

<script src="https://gist.github.com/4079655.js?file=gistfile1.txt"></script>

Hay mucha más información relacionada a estos archivos mapping, pero sería algo complicado tratar de explicárselos paso a paso, además de que este tutorial perdería sentido, para ello, recomiendo consultar la referencia en línea sobre este mapeo de clases en http://www.hibernate.org/hib_docs/nhibernate/1.2/reference/en/html/mapping.html.

Hasta aquí nuestro explorador de soluciones deberá verse así:

<img src="/img/14995032-paso4.jpg">

## 5. Configurando NHibernate en VSTS 2008 .NET

Bueno hasta ahora, no hemos hecho mucho, pero ya empieza lo bueno =). Hay que decirle a NH con que proveedor de base de datos vamos a trabajar. Por fortuna NH soporta el más querido por nosotros en la oficina SQL Server.

Para hacer mas modular la aplicación, vamos a agregar una aplicación de consola a nuestra solución con el fin de consumir nuestro ORM. El nombre que yo le he puesto al proyecto es Tutorial.NH.App, tu puedes ponerle el que gustes. Importante agregar dentro de las referencias nuestro ensamblado de nombre Tutorial.NH.BOL. Pudimos haber utilizado Unit Test para probar nuestro proyecto en lugar de la aplicación de Consola, pero mejor eso veámoslo después.

### 5.1. Configuración en App.config

Agregaremos un archivo de configuración donde indicaremos las llaves necesarias para establecer la comunicación con nuestra base de datos.

<script src="https://gist.github.com/4079657.js?file=gistfile1.xml"></script>

### 5.2 Configuración en hibernate.cfg.xml

Este es otra manera de realizar nuestra configuración de NH y consiste en agregar un archivo XML a nuestro proyecto con la siguiente estructura: hibernate.cfg.xml.

<script src="https://gist.github.com/4079650.js?file=gistfile1.xml"></script>

Podemos utilizar cualquiera de los dos. Con este archivo de configuración le decimos a NH que queremos trabajar con Microsoft SQL Server como base de datos. Para nuestro ejemplo usaremos la segunda opción.

Y bien ya estamos listos para iniciar con nuestras operaciones CRUD.

## 6. Operaciones CRUD

Nuestro sistema hasta este punto ha sido preparado con lo esencial. Se han implementado características necesarias para el funcionamiento de NH, se ha creado el modelo de dominio se han definido los archivos mapping y se ha establecido la configuración a NH. Vamos poco a poco y ya llevamos algo recorrido =).

Empezaremos a darle uso y funcionalidad a nuestro dominio.

Ahora, vamos a agregar una carpeta a nuestro proyecto Tutorial.NH.BOL llamado Repositorio (esto lo especifica Domain Driven Design) y en el agregaremos una clase llamada IRepositorioUsuario.cs y la definimos de la siguiente manera:

<script src="https://gist.github.com/4079659.js?file=gistfile1.cs"></script>

Ahora, lo que sigue es implementar cada uno de los métodos definidos por la Interface IRepositorioUsuario.cs. Comenzaremos con el primer método Agregar() que nos va a permitir agregar una instancia de un Usuario en nuestra base de datos.

Dentro de la misma carpeta (Repositorio) vamos a agregar una clase llamada RepositorioUsuario.cs y vamos a hacer que herede de la interfase IRepositorioUsuario.cs, con esto haremos que la clase implemente cada uno de los métodos de la interface.

<script src="https://gist.github.com/4079662.js?file=gistfile1.cs"></script>

Ahora, lo que sigue es crear el mecanismo para crear las sesiones que se van a comunicar con nuestra base de datos. Dentro del mismo proyecto, nos crearemos una Carpeta que nombraremos Genericos y agregamos una clase de nombre NHibernateClass.cs.

<script src="https://gist.github.com/4079664.js?file=gistfile1.cs"></script>

Esta clase lo que hará por nosotros es crear una SessionFactory solo la primera vez que el cliente necesita una sesión. Que contiene este Singleton? Contiene un objeto del tipo Configuración que utiliza la configuración de nuestro hibernate.cfg.xml que creamos en la aplicación se escritorio y que se encarga de cargar el objeto ISessionFactory gracias al método BuildSessionFactory() y de esta forma poder comenzar a crear sesiones de tipo ISessionFactory.

Volvamos a nuestra clase RepositorioUsuario.cs e implementemos el método Agregar() de la siguiente manera:

<script src="https://gist.github.com/4079665.js?file=gistfile1.txt"></script>

En el m&eacute;todo Actualizar() escribiremos lo siguiente:

<script src="https://gist.github.com/4079667.js?file=gistfile1.txt"></script>

En el m&eacute;todo Eliminar() escribiremos lo siguiente:

<script src="https://gist.github.com/4079670.js?file=gistfile1.txt"></script>

Para el m&eacute;todo ObtenerUsuarioPorId() haremos esto:

<script src="https://gist.github.com/4079673.js?file=gistfile1.txt"></script>

Y para obtener todos los usuarios:

<script src="https://gist.github.com/4079674.js?file=gistfile1.txt"></script>
Nota la creaci&oacute;n del objeto sesi&oacute;n desde nuestra clase NHibernateClass.cs y tambien el uso de una transacci&oacute;n.

&iexcl;Y listo! podemos empezar a trabajar con nuestro modelo de NH para la persistencia de nuestras entidades de dominio.

Para guardar la informaci&oacute;n de un usuario y sus tareas una posible implementaci&oacute;n es que desde nuestra aplicaci&oacute;n de consola incluyamos esta implementaci&oacute;n:

<script src="https://gist.github.com/4079677.js?file=gistfile1.txt"></script>

Si bien recordamos cuando hicimos el modelo de dominio y las mapeamos con la base de datos, creamos unas propiedades que permit&iacute;an las relaciones &lt;many-to-one /&gt;, &lt;one-to-many /&gt;. Esta es la verdadera magia, se dieron cuenta que nunca utilizamos procedimientos almacenados? o que nunca nos creamos rutinas de conexi&oacute;n y de creaci&oacute;n de DataAdapters? o DataSets? mucho menos DataReaders? Gracias a NH podemos persistir nuestros objetos de una manera limpia y orientada a objetos que es lo m&aacute;s importante.

## Conclusi&oacute;n

En este sencillo ejemplo, pudimos observar c&oacute;mo manejar un modelo de dominio y como cerrar el "gap" con nuestra base de datos relacional. Sabemos que este es un ejemplo b&aacute;sico y hay mucho m&aacute;s que explicar y que probar, pero por lo pronto espero que esto les haya servido como una introducci&oacute;n (al menos a m&iacute; si me ayudo jeje).
