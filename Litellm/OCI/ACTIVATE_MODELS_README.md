# 🚀 Activación de Modelos Ollama Cloud en Ubuntu Server

Este script activa automáticamente todos los modelos cloud de Ollama dentro del contenedor Docker.

## 📋 Requisitos Previos

1. Docker y Docker Compose instalados
2. Contenedor `ollama` corriendo
3. Conexión a internet

## 🔧 Instalación

### 1. Subir archivos al servidor

```bash
# Desde tu máquina local, copia los archivos
scp -r OCI/* usuario@tu-servidor:~/litellm/

# O usa git si tienes repositorio
cd ~/litellm
git pull origin main
```

### 2. Dar permisos de ejecución

```bash
cd ~/litellm
chmod +x activate-cloud-models.sh
```

## ▶️ Uso

### Opción 1: Ejecución automática (recomendado)

```bash
./activate-cloud-models.sh
```

El script:
- ✅ Verifica que Ollama esté corriendo
- ✅ Activa todos los modelos cloud (12 modelos)
- ✅ Muestra el progreso en tiempo real
- ✅ Te pregunta si reiniciar LiteLLM automáticamente

### Opción 2: Activación manual de un modelo

```bash
# Activar un solo modelo cloud
docker exec -i ollama ollama run deepseek-v3.2:cloud <<< "exit"
```

### Opción 3: Verificar modelos ya activados

```bash
# Listar todos los modelos disponibles
docker exec ollama ollama list
```

## 🧪 Verificación

### 1. Ver logs de Ollama

```bash
docker-compose logs -f ollama
```

### 2. Ver logs de LiteLLM

```bash
docker-compose logs -f litellm
```

### 3. Test de API

```bash
# Test rápido del stack multimodal
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "multimodal",
    "messages": [{"role": "user", "content": "Hola"}]
  }'
```

## 📊 Modelos que se Activan

| Modelo | Tamaño | Uso Principal |
|--------|--------|---------------|
| `deepseek-v3.2:cloud` | 671B | Chat general potente |
| `glm-4.7:cloud` | 4.7B | Chat rápido |
| `glm-5:cloud` | 5B | Ultra-rápido |
| `gemma3:27b-cloud` | 27B | Google, equilibrado |
| `qwen3.5:397b-cloud` | 397B | Premium, reasoning |
| `minimax-m2.5:cloud` | - | Chat chino |
| `qwen3-vl:235b-instruct-cloud` | 235B | Visión/multimodal |
| `ministral-3:8b-cloud` | 8B | Coding rápido |
| `gemini-3-flash-preview:cloud` | - | Multimodal Google |
| `gpt-oss:20b-cloud` | 20B | Open source alt |
| `gpt-oss:120b-cloud` | 120B | Premium alt |
| `qwen3-coder-next:cloud` | - | Coding especializado |

## ⚠️ Troubleshooting

### Error: "Container 'ollama' not running"

```bash
# Iniciar Ollama
docker-compose up -d ollama

# Verificar estado
docker ps | grep ollama
```

### Error: "Permission denied"

```bash
# Dar permisos al script
chmod +x activate-cloud-models.sh

# O ejecutar con sudo
sudo ./activate-cloud-models.sh
```

### Modelos no aparecen después de activar

```bash
# Limpiar caché y reiniciar
docker-compose restart ollama
sleep 10
docker-compose restart litellm
```

### Verificar conectividad de Ollama

```bash
# Test directo al contenedor
docker exec ollama ollama --version

# Ver logs
docker logs ollama --tail 50
```

## 🔄 Automatización (Opcional)

### Ejecutar al iniciar el servidor

```bash
# Agregar al crontab
crontab -e

# Agregar esta línea:
@reboot sleep 60 && cd /ruta/a/litellm && ./activate-cloud-models.sh
```

### Script systemd (alternativa)

```bash
# Crear servicio
sudo nano /etc/systemd/system/ollama-cloud-activate.service
```

```ini
[Unit]
Description=Activate Ollama Cloud Models
After=docker.service
Requires=docker.service

[Service]
Type=oneshot
WorkingDirectory=/ruta/a/litellm
ExecStart=/ruta/a/litellm/activate-cloud-models.sh
User=tu-usuario
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

```bash
# Habilitar y ejecutar
sudo systemctl daemon-reload
sudo systemctl enable ollama-cloud-activate.service
sudo systemctl start ollama-cloud-activate.service
```

## 📝 Notas Importantes

1. **Primera ejecución toma tiempo**: Los modelos cloud necesitan registrarse la primera vez
2. **No descarga archivos**: Los modelos `:cloud` corren en servidores de Ollama
3. **Requiere internet**: Los modelos cloud necesitan conexión constante
4. **Embeddings pueden fallar**: `nomic-embed-text:cloud` y `mxbai-embed-large:cloud` aún no están confirmados

## 🔗 Enlaces Útiles

- [Documentación Ollama](https://ollama.ai/library)
- [LiteLLM Docs](https://docs.litellm.ai/)
- [Modelos Cloud de Ollama](https://ollama.ai/blog/cloud-models)

