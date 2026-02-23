# 📚 Guía de Modelos LiteLLM - Organizados por Stacks

**Última actualización:** 17 de Febrero, 2026  
**Total de modelos:** 27 individuales + 8 stacks con fallbacks

---

## 🎯 STACKS ORGANIZADOS POR FUNCIONALIDAD

Los stacks agrupan modelos similares con sistema de fallback automático. Si un modelo falla, LiteLLM usa automáticamente el siguiente.

### 1️⃣ STACK: `chat-general`
**Propósito:** Conversación diaria, uso general  
**Modelos similares:** Conversación natural, respuestas amigables  
**Fallbacks (6 modelos):**
1. `openai/kimi-k2.5-free` (ZenCode) - Principal
2. `openai/glm-4.7-free` (ZenCode)
3. `openai/minimax-m2.5-free` (ZenCode)
4. `gemini/gemini-2.5-flash` (Google)
5. `ollama/gemma3:27b-cloud` (Ollama Cloud)
6. `openrouter/openai/gpt-oss-120b:free` (OpenRouter)

**Uso:**
```bash
curl -X POST "http://localhost:4000/v1/chat/completions" \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "chat-general", "messages": [{"role": "user", "content": "Hola"}]}'
```

---

### 2️⃣ STACK: `coding`
**Propósito:** Programación especializada  
**Modelos similares:** Generación y análisis de código  
**Fallbacks (5 modelos):**
1. `openrouter/qwen/qwen-2.5-coder-32b-instruct:free` (OpenRouter) - Principal
2. `openai/kimi-k2.5-free` (ZenCode)
3. `gemini/gemini-2.5-flash` (Google)
4. `openrouter/qwen/qwen3-coder:free` (OpenRouter)
5. `ollama/ministral-3:8b-cloud` (Ollama Cloud)

**Configuración:** `temperature: 0.2` (más determinista para código)  
**Uso:**
```bash
curl -X POST "http://localhost:4000/v1/chat/completions" \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "coding", "messages": [{"role": "user", "content": "Escribe una función Python para ordenar una lista"}]}'
```

---

### 3️⃣ STACK: `fast`
**Propósito:** Respuestas ultra-rápidas  
**Modelos similares:** Velocidad, bajo consumo de recursos  
**Fallbacks (4 modelos):**
1. `openai/glm-5-free` (ZenCode) - Principal
2. `openrouter/liquid/lfm-2.5-1.2b-instruct:free` (OpenRouter)
3. `ollama/ministral-3:8b-cloud` (Ollama Cloud)
4. `gemini/gemini-2.5-flash` (Google)

**Configuración:** `timeout: 30-60s`, `temperature: 0.8`, `max_tokens: 2048`  
**Uso ideal:** Preguntas rápidas, asistentes en tiempo real

---

### 4️⃣ STACK: `thinking`
**Propósito:** Razonamiento profundo  
**Modelos similares:** Reasoning, análisis complejo, chain-of-thought  
**Fallbacks (6 modelos):**
1. `openai/kimi-k2.5-free` (ZenCode) - Principal
2. `openai/glm-4.7-free` (ZenCode)
3. `openai/minimax-m2.5-free` (ZenCode)
4. `gemini/gemini-2.5-pro` (Google)
5. `openrouter/deepseek/deepseek-r1-0528:free` (OpenRouter)
6. `ollama/qwen3.5:397b-cloud` (Ollama Cloud) - Ultra potente

**Configuración:** `timeout: 600s`, `temperature: 0.5`, `max_tokens: 8192`  
**Uso ideal:** Problemas complejos, matemáticas, razonamiento lógico

---

### 5️⃣ STACK: `vision`
**Propósito:** Análisis de imágenes  
**Modelos similares:** Visión por computadora, multimodal  
**Fallbacks (3 modelos):**
1. `ollama/qwen3-vl:235b-cloud` (Ollama Cloud) - Principal
2. `gemini/gemini-2.5-flash` (Google)
3. `ollama/gemini-3-flash-preview:cloud` (Ollama Cloud)

**Configuración:** `supports_vision: true`  
**Uso:**
```bash
curl -X POST "http://localhost:4000/v1/chat/completions" \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "vision",
    "messages": [{
      "role": "user",
      "content": [
        {"type": "text", "text": "¿Qué hay en esta imagen?"},
        {"type": "image_url", "image_url": {"url": "https://..."}}
      ]
    }]
  }'
```

---

### 6️⃣ STACK: `embeddings`
**Propósito:** Vectorización para RAG  
**Modelos similares:** Embeddings, búsqueda semántica  
**Fallbacks (2 modelos):**
1. `ollama/nomic-embed-text:cloud` (Ollama Cloud) - Principal
2. `ollama/mxbai-embed-large:cloud` (Ollama Cloud)

**Uso:** Ideal para ChromaDB, Qdrant, Pinecone, búsquedas semánticas  
**Ejemplo:**
```python
from openai import OpenAI
client = OpenAI(base_url="http://localhost:4000/v1", api_key="sk-...")

response = client.embeddings.create(
    model="embeddings",
    input="Texto para vectorizar"
)
vector = response.data[0].embedding
```

---

### 7️⃣ STACK: `premium`
**Propósito:** Modelos más potentes  
**Modelos similares:** Máxima capacidad, tareas complejas  
**Fallbacks (5 modelos):**
1. `ollama/qwen3.5:397b-cloud` (Ollama Cloud) - Ultra potente
2. `gemini/gemini-2.5-pro` (Google)
3. `openrouter/openai/gpt-oss-120b:free` (OpenRouter)
4. `openai/kimi-k2.5-free` (ZenCode)
5. `ollama/gemma3:27b-cloud` (Ollama Cloud)

**Configuración:** `timeout: 600s`, `temperature: 0.7`, `max_tokens: 8192`  
**Uso ideal:** Tareas que requieren máxima calidad

---

### 8️⃣ STACK: `multimodal`
**Propósito:** Texto + Imágenes avanzado  
**Modelos similares:** Contenido multimedia, generación de imágenes  
**Fallbacks (3 modelos):**
1. `gemini/gemini-2.5-pro` (Google) - Principal
2. `ollama/qwen3-vl:235b-cloud` (Ollama Cloud)
3. `ollama/gemini-3-flash-preview:cloud` (Ollama Cloud)

**Configuración:** `supports_vision: true`, `timeout: 600s`

---

## 📋 MODELOS INDIVIDUALES (27 MODELOS)

Estos modelos están disponibles para usar directamente sin fallbacks.

### 🔵 ZenCode Free Models (4 modelos)
| Modelo | ID | Descripción |
|--------|-----|-------------|
| GLM-5 Free | `glm5-free` | Modelo más reciente de ZenCode |
| GLM-4.7 Free | `glm47-free` | Versión anterior, muy estable |
| Kimi K2.5 Free | `kimi-free` | Excelente para chat y código |
| Minimax M2.5 Free | `minimax-free` | Alta calidad, reasoning |

---

### 🔴 Google Gemini (2 modelos)
| Modelo | ID | Descripción |
|--------|-----|-------------|
| Gemini 2.5 Flash | `gemini-flash` | Rápido, multimodal |
| Gemini 2.5 Pro | `gemini-pro` | Más potente, análisis profundo |

---

### 🟠 OpenRouter Free Models (6 modelos)
| Modelo | ID | Descripción |
|--------|-----|-------------|
| Liquid LFM 2.5 | `openrouter-liquid` | Ultra ligero (1.2B parámetros) |
| Qwen 2.5 Coder 32B | `openrouter-qwen-coder` | Especialista en código |
| GPT-OSS 120B | `openrouter-gpt-oss` | Modelo open source potente |
| DeepSeek R1 | `openrouter-deepseek-r1` | Razonamiento avanzado |
| Gemma 3 27B | `openrouter-gemma3` | Google Gemma optimizado |
| Mistral Small 3.1 | `openrouter-mistral` | Mistral AI, equilibrado |

---

### 🟢 Ollama Cloud Models (8 modelos)
| Modelo | ID | Descripción |
|--------|-----|-------------|
| GLM-5 Cloud | `glm5-cloud` | GLM modelo más reciente |
| Gemma3 27B Cloud | `gemma3-cloud` | Google Gemma 27B |
| Qwen 3.5 397B Cloud | `qwen35-cloud` | Ultra potente (397B parámetros) ⭐ |
| Minimax M2.5 Cloud | `minimax-cloud` | Minimax con reasoning |
| Qwen VL 235B Cloud | `qwen-vl-cloud` | Visión + Lenguaje (235B) ⭐ |
| Ministral 3 8B Cloud | `ministral-cloud` | Mistral ligero |
| Gemini 3 Flash Cloud | `gemini3-cloud` | Gemini experimental |
| GPT-OSS 120B Cloud | `gpt-oss-cloud` | GPT open source |

---

## 🔄 ESTRATEGIA DE FALLBACK

LiteLLM usa la estrategia `simple-shuffle` con las siguientes configuraciones:

```yaml
router_settings:
  routing_strategy: "simple-shuffle"
  num_retries: 3              # 3 reintentos por modelo
  timeout: 300                # 5 minutos timeout global
  cooldown_time: 60           # Espera 60s antes de reintentar modelo fallido
  retry_delay: 2              # 2 segundos entre reintentos
```

**Cómo funciona:**
1. LiteLLM intenta con el modelo principal
2. Si falla (error, timeout, rate limit), pasa al siguiente
3. Reintenta hasta 3 veces por modelo
4. Si un modelo falla, espera 60s antes de volver a intentarlo

---

## 💡 RECOMENDACIONES DE USO

### Para Chat General
✅ Usa: `chat-general`  
Modelos: Kimi, GLM-4.7, Minimax, Gemini Flash

### Para Programación
✅ Usa: `coding`  
Modelos: Qwen Coder 32B, Kimi, Gemini Flash

### Para Velocidad
✅ Usa: `fast`  
Modelos: GLM-5, Liquid LFM, Ministral 3

### Para Razonamiento Complejo
✅ Usa: `thinking`  
Modelos: Kimi, GLM-4.7, DeepSeek R1, Qwen 3.5 397B

### Para Imágenes
✅ Usa: `vision` o `multimodal`  
Modelos: Qwen VL 235B, Gemini Pro, Gemini 3 Flash

### Para Embeddings (RAG)
✅ Usa: `embeddings`  
Modelos: Nomic Embed Text, MxBAI Embed Large

### Para Máxima Calidad
✅ Usa: `premium`  
Modelos: Qwen 3.5 397B, Gemini Pro, GPT-OSS 120B

---

## 📊 COMPARATIVA POR TAMAÑO

| Categoría | Modelos | Parámetros |
|-----------|---------|------------|
| **Ultra Ligeros** | Liquid LFM | 1.2B |
| **Ligeros** | Ministral 3, GLM-4.7 | 8B |
| **Medianos** | Gemma3, Kimi | 27B |
| **Grandes** | Qwen Coder | 32B |
| **Ultra Grandes** | GPT-OSS | 120B |
| **Premium** | Qwen VL, Qwen 3.5 | 235B - 397B ⭐ |

---

## 🚀 EJEMPLOS DE USO

### Ejemplo 1: Chat General
```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:4000/v1",
    api_key="sk-363289ec96b7c4bcf5e0fb398d241797b5284dd20727bbaa"
)

response = client.chat.completions.create(
    model="chat-general",
    messages=[
        {"role": "user", "content": "Explícame qué es la inteligencia artificial"}
    ]
)

print(response.choices[0].message.content)
```

### Ejemplo 2: Generación de Código
```python
response = client.chat.completions.create(
    model="coding",
    messages=[
        {"role": "user", "content": "Escribe una función para calcular Fibonacci en Python"}
    ],
    temperature=0.2
)
```

### Ejemplo 3: Análisis de Imagen
```python
response = client.chat.completions.create(
    model="vision",
    messages=[{
        "role": "user",
        "content": [
            {"type": "text", "text": "¿Qué objetos ves en esta imagen?"},
            {"type": "image_url", "image_url": {"url": "https://example.com/image.jpg"}}
        ]
    }]
)
```

### Ejemplo 4: Razonamiento Profundo
```python
response = client.chat.completions.create(
    model="thinking",
    messages=[
        {"role": "user", "content": "Si tengo 3 manzanas y compro el doble de lo que tengo, luego regalo la mitad, ¿cuántas me quedan?"}
    ],
    temperature=0.5
)
```

### Ejemplo 5: Embeddings para RAG
```python
text = "La inteligencia artificial está transformando el mundo"

response = client.embeddings.create(
    model="embeddings",
    input=text
)

embedding_vector = response.data[0].embedding
print(f"Vector de {len(embedding_vector)} dimensiones")
```

---

## 🔧 CONFIGURACIÓN AVANZADA

### Ajustar Temperature por Uso
- **Chat General:** `0.7-0.8` (más creativo)
- **Código:** `0.2-0.3` (más determinista)
- **Razonamiento:** `0.5` (equilibrado)
- **Creativo:** `0.9-1.0` (muy variado)

### Ajustar Max Tokens
- **Respuestas cortas:** `256-512`
- **Chat normal:** `2048-4096`
- **Análisis profundo:** `8192+`

### Streaming
Todos los modelos soportan streaming:
```python
response = client.chat.completions.create(
    model="chat-general",
    messages=[{"role": "user", "content": "Cuenta hasta 10"}],
    stream=True
)

for chunk in response:
    if chunk.choices[0].delta.content:
        print(chunk.choices[0].delta.content, end="")
```

---

## 📞 ENDPOINTS DISPONIBLES

- **Chat:** `POST /v1/chat/completions`
- **Embeddings:** `POST /v1/embeddings`
- **Models:** `GET /v1/models`
- **Health:** `GET /health`

**Base URL:** `http://localhost:4000`  
**Auth:** Header `Authorization: Bearer sk-363289ec96b7c4bcf5e0fb398d241797b5284dd20727bbaa`

---

## ⚠️ NOTAS IMPORTANTES

1. **Solo modelos `:cloud`** - No hay modelos locales, todos son remotos
2. **APIs gratuitas** - ZenCode, Google Gemini, OpenRouter son gratuitas
3. **Rate Limits** - Algunos proveedores tienen límites, los fallbacks los manejan automáticamente
4. **Cache Redis** - Respuestas cacheadas por 1 hora (chat) o 2 horas (embeddings)
5. **PostgreSQL** - Métricas y logs guardados en base de datos

---
