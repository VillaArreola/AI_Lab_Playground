# 🧪 AI Lab Playground

Repositorio de experimentación y pruebas con modelos de IA, tanto locales como vía API. Este proyecto incluye configuraciones para diferentes servicios de IA y herramientas de desarrollo.

## 📋 Contenido

- **[Litellm](./Litellm/)** - Proxy unificado para múltiples proveedores de LLM (OpenAI, Anthropic, Hugging Face, etc.)
- **[OpenWebUI](./OpenWebUi/)** - Interfaz web para interactuar con modelos de lenguaje
- **[TestAPI](./TestApi/)** - Scripts de prueba para APIs de modelos de IA
- **[MCP](./MCP/)** - Configuraciones del Model Context Protocol
- **Local Vision Generation** - Configuraciones para generación de imágenes con Stable Diffusion

## 🚀 Inicio Rápido

### Prerrequisitos

- Docker & Docker Compose
- Python 3.8+
- Git

### Configuración Inicial

1. **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/AI_Lab_Playground.git
cd AI_Lab_Playground
```

2. **Configurar variables de entorno**
```bash
# Copiar el archivo de ejemplo y agregar tus credenciales
cp TestApi/.env.example TestApi/.env
# Editar TestApi/.env con tus API keys
```

3. **Levantar los servicios con Docker**

Para Litellm:
```bash
cd Litellm
docker-compose up -d
```

Para OpenWebUI:
```bash
cd OpenWebUi
docker-compose up -d
```

## 📁 Estructura del Proyecto

```
AI_Lab_Playground/
├── Litellm/              # Configuraciones de Litellm proxy
│   ├── config.yaml       # Configuración principal
│   └── docker-compose.yml
├── OpenWebUi/            # Interfaz web para LLMs
│   └── docker-compose.yml
├── TestApi/              # Scripts de prueba
│   ├── .env.example      # Plantilla de variables de entorno
│   └── chay.py           # Scripts de test
├── MCP/                  # Model Context Protocol
└── README.md
```

## 🔧 Configuración

### Variables de Entorno

Crea un archivo `.env` en `TestApi/` basado en `.env.example`:

```bash
# Hugging Face
HF_TOKEN=tu_token_aqui
huggingface_endpoint=https://router.huggingface.co/v1

# OpenAI
OPENAI_API_KEY=tu_api_key_aqui
endpoint_openai=https://api.openai.com/v1
```

### Archivos de Configuración

- **Litellm**: Edita `Litellm/config.yaml` para agregar tus modelos y APIs
- **OpenWebUI**: Configuración vía interfaz web en `http://localhost:3000`

## 📖 Documentación Adicional

- [Guía de Modelos Litellm](./Litellm/MODELS_GUIDE.md)
- [Setup Local](./local-setup-Webui.md)

## 🛠️ Tecnologías

- Docker & Docker Compose
- Python 3.x
- Litellm Proxy
- OpenWebUI
- Hugging Face Transformers
- OpenAI API

## ⚠️ Notas Importantes

- **No subas tus archivos `.env`** con tokens reales al repositorio
- Los modelos pesados (`.safetensors`, `.ckpt`, `.bin`) están excluidos del repo
- Las carpetas de cache y datos locales no se sincronizan con Git

## 🤝 Contribuir

Este es un repositorio personal de experimentación. Si encuentras algo útil, siéntete libre de hacer fork y adaptarlo a tus necesidades.

## 📝 Licencia

Proyecto de uso personal y educativo.

---

**Happy AI Testing! 🚀**
