# Metrica de microServicios
Metrica para observar el consumo de un servicio (click en botón). A través de CloudWatch AWS

## Desarrollo e implementación

1. Creación del cliente del servicio: El cliente es una página básica que consume un servicio al ser pulsado un botón.Fue desarrollado en HTML con consumo de servicios HTTP en javascript. Acrchivo llamado `front.html`.
 
2. Servicio con Node.js, y express: Se basó en el ejemplo: [Node js docker webapp](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/). Consiste en un servicio desarrollado con node.js y express, que sirve una sola ruta en el puerto *20000*, la cual responde a  un metodo GET que devuelve la palabra **Metrica**. Archivos `server.js` (corresponde al archivo principal), `package.json` (definicion de modulos y caracteristicas en node.js para la aṕlicación).

3. Contenedor en EC2: El app Backend se desplego en un contenedor Docker. Para esto se creó el archivo `Dockerfile`, el cual tiene las instrucciones de construcción. De manera que se debe entrar a la consola de la instancia EC2 en AWS o en el proveedor que se desea y seguir los siguientes pasos:

* Instalar Docker
* Clonar el presente repositorio
* Construir la imagen a partir del archivo `Dockerfile`. Mediante `docker build -t nube/metrica .`
* Ejecutar el contenedor exponiendolo en el puerto 20000. `docker run -p 20000:8080 -d nube/metrica`

### Consideraciones
En este punto debe tenerse en cuenta las politicas de seguridad de la instancia _EC2_, ya que debe permitir _inbound_ desde puerto 20000.

4. Metríca del consumo del servicio en AWS con CloudWatch

Basado en las intrucciones de creación de CUSTOM METRICS [Cloud Watch Custom Metrics](https://aws.amazon.com/premiumsupport/knowledge-center/cloudwatch-custom-metrics). EL enfoque consiste en **Crear una nueva metrica basada en las solicitudes al puerto 20000, de está manera se realiza un conteo de cuantas solicitudes se realizaron en un tiempo determinado**, ademas de está métrica se crearon otras para el consumo de CPU, o la monitorizaci+ón por puerto 80. Fueron creadas metricas personalizadas para realizar el monitoreo de **micro servicios especificos** en este caso el backend que se ejecuta en el contenedor en la instancia EC2.


## Ejecución

1. Ejecución del cliente Front

 Comportamiento que puede ser replicado desde Postman o desde el navegador, ya que es un servicio web con Metodo HTTP GET a la ruta: [I'm an inline-style link](http://18.224.108.208:20000/)  o correr el archivo _front.html_ desde el navegador y dar click al botón. 

2. Verificación de la Métrica en **


