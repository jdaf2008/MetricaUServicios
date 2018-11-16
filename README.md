# Métrica de MicroServicios
Métrica para observar el consumo de un servicio (click en botón). A través de CloudWatch AWS

## Desarrollo e implementación

1. Creación del cliente del servicio: El cliente es una página básica que consume un servicio al ser pulsado un botón. Fue desarrollado en HTML con consumo de servicios HTTP en javascript. Archivo llamado `front.html`.
 
2. Servicio con Node.js, y express: Se basó en el ejemplo: [Node js docker webapp](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/). Consiste en un servicio desarrollado con node.js y express, que sirve una sola ruta en el puerto *20000*, la cual responde a  un metodo GET que devuelve la palabra **Metrica**. Archivos `server.js` (corresponde al archivo principal), `package.json` (definición de modulos y caracteristicas en node.js para la aplicación).

3. Contenedor en EC2: El app Backend se desplego en un contenedor Docker. Para esto se creó el archivo `Dockerfile`, el cual tiene las instrucciones de construcción. De manera que se debe entrar a la consola de la instancia EC2 en AWS o en el proveedor que se desea y seguir los siguientes pasos:

* Instalar Docker
* Clonar el presente repositorio
* Construir la imagen a partir del archivo `Dockerfile`. Mediante `docker build -t nube/metrica .`
* Ejecutar el contenedor exponiendolo en el puerto 20000. `docker run -p 20000:8080 -d nube/metrica`

#### Consideraciones
En este punto debe tenerse en cuenta las politicas de seguridad de la instancia _EC2_, ya que debe permitir _inbound_ desde puerto 20000.

4. Métrica del consumo del servicio en AWS con CloudWatch

Basado en las intrucciones de creación de CUSTOM METRICS [Cloud Watch Custom Metrics](https://aws.amazon.com/premiumsupport/knowledge-center/cloudwatch-custom-metrics). El enfoque consiste en **Crear una nueva metrica basada en las solicitudes al puerto 20000, de está manera se realiza un conteo de cuantas solicitudes se realizaron en un tiempo determinado**, ademas de está métrica se crearon otras para el consumo de CPU, o la monitorizaci+ón por puerto 80. Fueron creadas métricas personalizadas para realizar el monitoreo de **micro servicios especificos**, particularmente el backend que se ejecuta en el contenedor en la instancia EC2 del actual ejemplo.

El Archivo `memv2.sh` escucha las solicitudes realizadas al puerto _20000_, y para esto se uso **AWS CLI** y las funciones especificas de _métrica_: POr ejemplo para enviar la información de las métricas del puerto 20000 a **CloudWatch** se usó: `aws cloudwatch put-metric-data --metric-name TCP_connection_on_port_20000 --dimensions Instance=$INSTANCE_ID --namespace Maestria --value $TCP_CONN_PORT_20000`

#### Consideraciones
Para el uso de **AWS Command Line** se necesita un usuario con permisos para enviar métrica a Cloud Watch.

FUe creada una tarea calendarizada en _crontab_ para que cada minuto verifique las solicitudes `*/1 * * * * <path>/MetricaUServicios/memv2.sh`

## Ejecución

1. Ejecución del cliente Front

 El Comportamiento puede ser replicado desde Postman o desde el navegador, ya que es un servicio web con Metodo HTTP GET a la ruta: [http://18.224.108.208:20000/](http://18.224.108.208:20000/)  o correr el archivo _front.html_ desde el navegador y dar click al botón. 

2. Verificación de la Métrica en **AWS Cloud Watch**

  Una vez se ingresa a la **consola de AWS** en Métrica se seleccionan las métricas personalizada, para este caso la métrica del puerto **20000** con esto se pueden generar Gráficas y realizar operaciones mátematicas de las estadisticas como las suma, promedio, etc.

 A continuación se muestran las imagenes de las gráficas de las instancias personalizadas para el conjunto de métricas llamado `Maestria` 

#### Para las solicitudes en puerto 20000

 ![alt text](https://github.com/jdaf2008/MetricaUServicios/graph.png "Métrica de puerto 20000") 


#### Para las 4 métricas configuradas


 ![alt text](https://github.com/jdaf2008/MetricaUServicios/graph2.png "Métrica de puerto 20000") 

