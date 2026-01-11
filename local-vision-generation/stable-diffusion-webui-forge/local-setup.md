# 👁️ Local Vision Module (Flux.1 [dev] + Forge)

Implementación optimizada de **Flux.1 [dev]** cuantizado en **FP8** para correr en hardware de (RTX 4080 Laptop, 12GB VRAM) con máxima eficiencia.

> **Status:** 🟢 Stable / Production Ready
> **Engine:** WebUI Forge (Optimized backend)
> **Model:** Flux.1 Dev (FP8 Kijai Quant)

## 📋 Requisitos de Hardware & Software

* **GPU:** NVIDIA RTX 3000/4000 series (Min 12GB VRAM recomendados para Flux).
* **Driver:** Latest Game Ready Driver.
* **Gestor:** Miniconda3 (Anaconda).
* **Git:** Instalado y en PATH.

---

## 1. Instalación del Entorno (Conda)

Evitamos el "Infierno de Dependencias" usando un entorno aislado con **Python 3.10** (Obligatorio, Python 3.11/3.12 rompen Torch actual).

### 1.1 Crear Entorno

```powershell
# Aceptar licencias si es instalación fresca
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main

# Crear entorno especificando Python 3.10
conda create -n forge python=3.10 git -y
conda activate forge

```

### 1.2 Clonar WebUI Forge

```powershell
cd D:\Workspace\AI-Engineering-Lab\local-vision-generation\
git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git

```

### 1.3 🛑 Parche Preventivo (Numpy/Scikit)

Forge intenta instalar NumPy 2.x por defecto, lo cual rompe `scikit-image`. Instalamos las versiones correctas **antes** de arrancar.

```powershell
# Asegurar pip actualizado
python -m pip install --upgrade pip

# Instalar versiones estables para IA
pip install numpy==1.26.4
pip install scikit-image==0.23.2

```

---

## 2. Configuración del Launcher (`webui-user.bat`)

Editamos `stable-diffusion-webui-forge\webui-user.bat` para forzar el uso de Conda y liberar VRAM.

```batch
@echo off

:: 1. RUTA DE TU ENTORNO CONDA (Ajustar usuario)
set PYTHON=C:\Users\marti\miniconda3\envs\forge\python.exe

:: 2. CRITICO: Deshabilita el venv interno de Forge para usar Conda
set VENV_DIR=-

:: 3. ARGUMENTOS DE OPTIMIZACIÓN
:: --cuda-malloc: Mejor gestión de memoria para 40 series
:: --theme dark: Interfaz oscura
set COMMANDLINE_ARGS=--cuda-malloc --theme dark

call webui.bat

```

---

## 3. Arquitectura de Modelos (Filesystem)

Flux requiere una estructura modular (Cerebro + Ojos + Compresor). No funciona con un solo archivo.

### 3.1 Descargas Necesarias

| Componente | Archivo | Peso | Link |
| --- | --- | --- | --- |
| **Checkpoint** | `flux1-dev-fp8.safetensors` | 11.9 GB | [HuggingFace](https://huggingface.co/Kijai/flux-fp8) |
| **VAE** | `ae.safetensors` | 335 MB | [HuggingFace](https://www.google.com/search?q=https://huggingface.co/black-forest-labs/FLUX.1-dev/blob/main/ae.safetensors) |
| **Clip L** | `clip_l.safetensors` | 234 MB | [HuggingFace](https://www.google.com/search?q=https://huggingface.co/comfyanonymous/flux_text_encoders/blob/main/clip_l.safetensors) |
| **T5 XXL** | `t5xxl_fp8_e4m3fn.safetensors` | 4.9 GB | [HuggingFace](https://huggingface.co/comfyanonymous/flux_text_encoders/blob/main/t5xxl_fp8_e4m3fn.safetensors) |

### 3.2 Estructura de Carpetas (¡Crítico!)

Forge escanea rutas específicas. Organizar exactamente así:

```text
stable-diffusion-webui-forge/
└── models/
    ├── Stable-diffusion/
    │   └── flux1-dev-fp8.safetensors
    │
    ├── VAE/
    │   └── ae.safetensors   <-- (Renombrar si bajó como 'diffusion_pytorch_model')
    │
    ├── text_encoder/        <-- (Si no existe, crearla. A veces llamada CLIP)
    │   ├── clip_l.safetensors
    │   └── t5xxl_fp8_e4m3fn.safetensors
    │
    └── Lora/                <-- (Para parches Uncensored/Estilos)
        └── Flux_Uncensored_V2.safetensors

```

---

## 4. Estrategia de Inferencia (Settings)

Flux.1 [dev] es muy sensible a los parámetros. Usar esta configuración base para evitar imágenes negras o ruido.

### Configuración UI (Barra Superior)

* **Checkpoint:** `flux1-dev-fp8...`
* **VAE:** `ae.safetensors`
* **Clip L:** `clip_l.safetensors`
* **T5:** `t5xxl_fp8...`

### Parámetros de Generación (Txt2img)

| Parámetro | Valor | Nota de Ingeniería |
| --- | --- | --- |
| **Sampler** | `Euler` | No usar "Euler a" (ancestral) con FP8. |
| **Schedule** | `Simple` | O "Beta". "Automatic" a veces falla. |
| **Steps** | `20` - `30` | Suficiente para Flux. |
| **Width/Height** | `896` / `1024` / `1152` | **NUNCA usar 512.** Flux colapsa en baja resolución. |
| **CFG Scale** | **`1.0`** | **CRÍTICO.** Bajar esto al mínimo. |
| **Distilled CFG** | `3.5` | Este es el verdadero control de guía de Flux. |

---

## 5. Gestión de Censura (LoRA Workflow)

Para bypass de filtros de contenido 
1. **Ubicación:** Guardar en `models/Lora/`.
2. **Activación:**
* En Forge, ir a pestaña **Lora** -> **Refresh**.
* Click en la tarjeta del modelo.
* Se añade al prompt: `<lora:NombreArchivo:1.0>`.
* A veces requiere "Trigger Word" al inicio (ej: `uncensored`).



---

## 🔧 Troubleshooting Log

### Error: "Numpy.dtype size changed" / Connection Errored Out

* **Causa:** Conflicto binario entre Numpy 2.x y Scikit-image.
* **Solución:**
```powershell
pip install numpy==1.26.4 --force-reinstall
pip install scikit-image==0.23.2 --force-reinstall

```



### Error: "You do not have CLIP state dict!"

* **Causa:** Forge no encuentra los encoders de texto dentro del checkpoint FP8 (porque viene vacío para ahorrar espacio).
* **Solución:** Mover `clip_l` y `t5xxl` a la carpeta `models\text_encoder` y **seleccionarlos manualmente** en el menú superior de la UI.

### Imágenes Negras o Ruido Estática

* **Causa A:** Resolución muy baja (ej. 512x512). -> **Subir a 1024.**
* **Causa B:** CFG Scale muy alto (7.0). -> **Bajar a 1.0.**