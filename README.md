# MetricaUServicios
Metrica para observar el consumo

## Desarrollo e implementación

1. Creación del cliente del servicio: El cliente es una págína básica que consume un servicio al ser pulsado un botón, desarrollada en HTML con consumo de servicios HTTP en javascript. Acrchivo llamado `front.html`.
 
2. Servicio con Node.js, y express
  Se basó en el ejemplo: [I'm an inline-style link](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/). Consiste en un servicio desarrollado con node.js y express, que sirve una sola ruta en el puerto *20000*, la cual es un metodo GET que devuelve la palabra Metrica

3. Despliegue del contenedor en EC2 
	Para el Despliegue del contenedor se tiene el archivo Dockerfile el cual tiene las instrucciones de construcción. De manera que se debe entrar a la consola de la instancia EC2 en AWS o en el proveedor que se desea.

* Instalar DOcker  

4. Metríca del consumo del servicio en AWS con CLoudWatch

Basado en las intrucciones de creación de CUSTOM METRIC [I'm an inline-style link](https://aws.amazon.com/premiumsupport/knowledge-center/cloudwatch-custom-metrics)

## Ejecución

1. Ejecución del cliente Front

 Comportamiento que puede ser replicado desde Postman o desde el navegador, ya que es un servicio web con Metodo HTTP GET a la ruta: [I'm an inline-style link](http://18.224.108.208:20000/)  o correr el archivo _front.html_ desde el navegador y dar click al botón. 

2. Verificación de la Métrica en **


