# README

# Herramientas requeridas

Para poder ejecutar este proyecto se requiere que previamente disponga de las siguientes herramientas:

1. Para compilar el código y obtener la simulación del VGA Python 3.8.
2. Para realizar la ejecución del código se requiere ModelSim 10.5b (Quartus Prime 18.1).
3. Además debe tener el código del ASIP previamente descargado, el mismo se encuentra en el repositorio de git que a continuación se adjunta. [Repositorio](https://github.com/kisung5/ProyectoGrupalI.git)

# Pasos para ejecutarlo

1. Primero debe colocar en la raíz del archivo descargado un archivo `.txt` con el siguiente nombre `quartus_directory.txt`  y colocar la ubicación de su ejecutable de Quartus. Ejemplo:  `D:/intelFPGA/18.1`.
2. Para poder compilar un código ensamblador `.asmrsa` debe ejecutar el script de Python que se encuentra en `Compiler/compiler.py` , se asegura que el código tenga el siguiente nombre `RSA_Decrypt.asmrsa` y por último se ejecuta, esto va a generar un archivo `RSA_Decrypt.b` , este se almacenará en la ruta previamente ingresada en el archivo del paso anterior.
3. En el mismo folder del paso uno debe agregar los archivos `data.mif` y `data.ver` estos corresponden a la memoria donde están almacenados los pixeles de la imagen encriptada.
4. Ahora proceda abriendo ModelSim, dentro de este seleccione en el navbar Compile - Compile... en esta ventana acceda a la ruta del archivo descargado en el folder de `Processor` y seleccione todos los archivos que contiene dicho folder.
5. En el navbar seleccione `Simulate - Start Simulation - Libraries` acá seleccione add... y añada en el siguiente orden las librerías `altera_mf_ver` y `altera_mf` . Luego seleccione Design, expanda el fichero work y seleccione el archivo `rsa_asip_system_tb_output` y presione ok.
6. Ahora seleccione `Simulate - Run - Run All` a partir de acá empieza todo el proceso de desencripción de la imagen.
7. Una vez finalizado diríjase a donde tiene el ejecutable de Quartus, acá encontrará dos ficheros llamados `vga_decrypted.txt` y `vga_encrypted.txt` cópielos en el folder VGA del archivo descargado.
8. Ahora en el folder VGA abra el script de Python llamado `simulator.py` y ejecútelo esto va a generar los frames de la imagen encriptada y desencriptada.
9. Por último diríjase al folder `VGA/Simulator outputs` y encontrará los dos frames de la imagen encriptada y desencriptada.
