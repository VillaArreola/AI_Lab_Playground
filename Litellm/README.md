# LiteLLM Proxy - Configuración Mejorada 🚀

## 📋 Descripción

Proxy unificado de LLMs con múltiples stacks temáticos, fallbacks automáticos, y soporte para modelos locales (Ollama) y en la nube (ZenCode).

## 🎯 Stacks Disponibles

| Stack | Descripción | Modelos | Uso Principal |
|-------|-------------|---------|---------------|
| **gpt-automatico** | Uso general y chat diario | GLM 4.7, Kimi K2.5, Kimi local | Conversaciones, escritura, asistencia general |
| **coder** | Programación y scripts | Kimi local, Kimi cloud, CodeLlama 13B | Código, debugging, refactoring |
| **deepseek-coder** | Especialista en código | DeepSeek Coder V2, Kimi | Proyectos complejos, arquitectura |
| **vision** | Análisis de imágenes | Qwen3 VL 8B, Llama 3.2 Vision 11B | OCR, descripción de imágenes, análisis visual |
| **fast** | Respuestas instantáneas | Llama 3.1 8B, Kimi cloud, Llama 3.2 3B | Queries rápidas, búsquedas, summaries |
| **thinking** | Razonamiento profundo | GLM 4.7, Kimi K2.5 | Problemas complejos, análisis, planificación |
| **embeddings** | RAG y búsqueda semántica | Nomic Embed Text, MxBAI Embed Large | Vector databases, búsqueda, clustering |

## 🔧 Instalación y Setup

### 1. Requisitos Previos

- Docker y Docker Compose instalados
- Ollama instalado y corriendo en `localhost:11434`
- Modelos de Ollama descargados (ver sección "Descargar Modelos")

### 2. Configurar Variables de Entorno

El archivo `.env` ya está creado con valores por defecto. **IMPORTANTE: Cambia las claves antes de usar en producción.**

```bash
# Edita .env y cambia al menos:
# - LITELLM_MASTER_KEY (para acceder a la UI)
# - REDIS_PASSWORD (seguridad de Redis)
# - POSTGRES_PASSWORD (seguridad de PostgreSQL)
```

### 3. Descargar Modelos en Ollama

```powershell
# Modelos esenciales (obligatorios)
ollama pull kimi-k2.5:cloud         # Chat general y código
ollama pull llama3.1:8b             # Fast general purpose
ollama pull nomic-embed-text        # Embeddings

# Modelos de visión
ollama pull qwen3-vl:8b             # Visión multimodal
ollama pull llama3.2-vision:11b     # Alternativa de visión

# Modelos de código
ollama pull deepseek-coder-v2       # Especialista en código
ollama pull codellama:13b           # Código general

# Modelos fast (opcionales, para más velocidad)
ollama pull llama3.2:3b             # Ultra rápido, menor calidad

# Embeddings alternativos
ollama pull mxbai-embed-large       # Fallback embeddings

# Modelos premium (solo si tienes GPU potente)
# ollama pull llama3.1:70b          # Modelo grande, requiere 40GB+ VRAM
# ollama pull mixtral:8x7b          # MoE model, excelente calidad
```

### 4. Levantar Servicios

```powershell
# En el directorio del proyecto
docker-compose up -d

# Ver logs
docker-compose logs -f litellm

# Verificar que todo esté corriendo
docker-compose ps
```

### 5. Acceder a la UI

- **URL**: http://localhost:4000
- **Master Key**: El valor de `LITELLM_MASTER_KEY` en tu `.env`

## 🧪 Probar la Configuración

### Listar Modelos Disponibles

```powershell
curl http://localhost:4000/v1/models `
  -H "Authorization: Bearer $env:LITELLM_MASTER_KEY"
```

### Chat Completion (OpenAI Compatible)

```powershell
# Test stack gpt-automatico
$body = @{
    model = "gpt-automatico"
    messages = @(
        @{
            role = "user"
            content = "Hola, cuéntame un chiste"
        }
    )
} | ConvertTo-Json

curl http://localhost:4000/v1/chat/completions `
  -H "Authorization: Bearer $env:LITELLM_MASTER_KEY" `
  -H "Content-Type: application/json" `
  -d $body
```

### Probar DeepSeek Coder (Código)

```powershell
$body = @{
    model = "deepseek-coder"
    messages = @(
        @{
            role = "user"
            content = "Escribe una función en Python para ordenar una lista usando quicksort"
        }
    )
    temperature = 0.2
} | ConvertTo-Json

curl http://localhost:4000/v1/chat/completions `
  -H "Authorization: Bearer $env:LITELLM_MASTER_KEY" `
  -H "Content-Type: application/json" `
  -d $body
```

### Embeddings (Para RAG)

```powershell
$body = @{
    model = "embeddings"
    input = "¿Cuál es el sentido de la vida?"
} | ConvertTo-Json

curl http://localhost:4000/v1/embeddings `
  -H "Authorization: Bearer $env:LITELLM_MASTER_KEY" `
  -H "Content-Type: application/json" `
  -d $body
```

### Visión (Análisis de Imágenes)

```powershell
$body = @{
    model = "vision"
    messages = @(
        @{
            role = "user"
            content = @(
                @{
                    type = "text"
                    text = "¿Qué hay en esta imagen?"
                }
                @{
                    type = "image_url"
                    image_url = @{
                        url = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"
                    }
                }
            )
        }
    )
} | ConvertTo-Json -Depth 10

curl http://localhost:4000/v1/chat/completions `
  -H "Authorization: Bearer $env:LITELLM_MASTER_KEY" `
  -H "Content-Type: application/json" `
  -d $body
```

## 📊 Monitoreo y Mantenimiento

### Ver Logs

```powershell
# Logs de LiteLLM
docker-compose logs -f litellm

# Logs de Redis
docker-compose logs -f redis

# Logs de PostgreSQL
docker-compose logs -f db
```

### Reiniciar Servicios

```powershell
# Reiniciar todo
docker-compose restart

# Reiniciar solo LiteLLM
docker-compose restart litellm

# Reconstruir y reiniciar (si cambias config.yaml)
docker-compose down
docker-compose up -d
```

### Limpiar Cache de Redis

```powershell
# Conectar a Redis
docker exec -it $(docker ps -q -f name=redis) redis-cli -a $env:REDIS_PASSWORD

# Dentro de Redis
FLUSHALL
exit
```

### Backups de Base de Datos

```powershell
# Backup de PostgreSQL
docker exec $(docker ps -q -f name=db) pg_dump -U litellm litellm > backup_$(Get-Date -Format "yyyyMMdd_HHmmss").sql

# Restaurar backup
cat backup_YYYYMMDD_HHMMSS.sql | docker exec -i $(docker ps -q -f name=db) psql -U litellm litellm
```

## 🔒 Seguridad

### ✅ Implementado
- ✅ Variables de entorno para secretos
- ✅ `.gitignore` para evitar commit de `.env`
- ✅ Redis con contraseña
- ✅ PostgreSQL con autenticación
- ✅ Master key para acceso a LiteLLM

### ⚠️ Recomendaciones Adicionales
- 🔐 Cambia todas las claves en `.env` antes de usar en producción
- 🚫 NO expongas el puerto 4000 públicamente sin HTTPS/firewall
- 🔄 Rota las claves API periódicamente
- 📝 Habilita logs estructurados en producción (`json_logs: true`)
- 🛡️ Considera usar un reverse proxy (Nginx/Traefik) con HTTPS

## 🐛 Troubleshooting

### Error: "Connection refused to Ollama"
```powershell
# Verificar que Ollama esté corriendo
curl http://localhost:11434/api/tags

# Si no responde, iniciar Ollama
ollama serve
```

### Error: "Model not found"
```powershell
# Listar modelos instalados en Ollama
ollama list

# Descargar modelo faltante
ollama pull <nombre-modelo>
```

### Error: "Redis connection failed"
```powershell
# Verificar que Redis esté corriendo
docker-compose ps redis

# Reiniciar Redis
docker-compose restart redis
```

### Error: "Database connection failed"
```powershell
# Verificar PostgreSQL
docker-compose ps db

# Ver logs de PostgreSQL
docker-compose logs db

# Reiniciar base de datos
docker-compose restart db
```

### LiteLLM no responde o está lento
```powershell
# Verificar recursos
docker stats

# Ver logs para errores
docker-compose logs litellm --tail=100

# Reiniciar LiteLLM
docker-compose restart litellm
```

## 📈 Optimizaciones Futuras

### Cuando necesites más control:
1. **Rate Limiting**: Agregar límites por usuario/IP en `config.yaml`
2. **Monitoreo**: Integrar Prometheus + Grafana para métricas
3. **Logs**: Langfuse o LangSmith para tracking detallado
4. **Alertas**: Sentry para errores, Slack para notificaciones
5. **Load Balancing**: Estrategias avanzadas (`latency-based-routing`)
6. **Modelos Premium**: GPT-4, Claude 3.5, Gemini Pro si necesitas máxima calidad

## 📚 Recursos Adicionales

- [Documentación LiteLLM](https://docs.litellm.ai/)
- [Ollama Models Library](https://ollama.ai/library)
- [OpenAI API Reference](https://platform.openai.com/docs/api-reference) (compatible)

## 📝 Changelog

### v2.0.0 - 2026-02-17
- ✅ Migración de secretos a variables de entorno
- ✅ Agregado stack DeepSeek Coder para programación avanzada
- ✅ Agregados modelos Llama 3.1/3.2 locales
- ✅ Agregado stack de embeddings (Nomic, MxBAI)
- ✅ Configuración de router settings (retries, cooldown, timeouts)
- ✅ Parámetros optimizados por modelo (temperature, max_tokens)
- ✅ Streaming habilitado en todos los stacks
- ✅ Cache TTL diferenciado (1h para chat, 2h para embeddings)
- ✅ Documentación completa y guías de uso

### v1.0.0 - Versión Original
- Configuración básica con 5 stacks
- Modelos ZenCode y Ollama básicos
- Cache Redis simple

---

**¿Preguntas o problemas?** Abre un issue o consulta la documentación de LiteLLM.
