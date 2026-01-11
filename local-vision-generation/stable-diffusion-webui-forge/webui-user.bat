@echo off

:: Tu ruta a Conda (ESTA PERFECTA)
set PYTHON=C:\Users\marti\miniconda3\envs\forge\python.exe

:: Git (Opcional, pero bueno tenerlo)
set GIT=git

:: CRITICO: El guion deshabilita el venv interno de Forge para usar el de Conda
set VENV_DIR=-

:: OPTIMIZACION: 
:: --cuda-malloc: Ayuda a gestionar la memoria de la 4080
:: --theme dark: Para que no te queme los ojos
set COMMANDLINE_ARGS=--cuda-malloc --theme dark

call webui.bat