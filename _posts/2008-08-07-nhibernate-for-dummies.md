---
published: false
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


