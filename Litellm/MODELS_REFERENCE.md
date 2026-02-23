# 📋 Referencia de Modelos Individuales

Esta es la lista completa de modelos individuales disponibles en LiteLLM, organizados por proveedor.

---

## 🔍 ¿Cómo Usar?

Puedes llamar a cualquier modelo directamente usando su **`model_name`** en la API:

```bash
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "zencode-kimi",
    "messages": [{"role": "user", "content": "Hola"}]
  }'
```

---

## 🏷️ Nomenclatura

Los modelos siguen el patrón: **`proveedor-modelo`**

- `zencode-*` → ZenCode/OpenCode API (gratis)
- `google-*` → Google Gemini API
- `deepseek-api-*` → DeepSeek API (premium, $5 crédito)
- `openrouter-*` → OpenRouter API (modelos gratis)
- `ollama-*-cloud` → Ollama Cloud Models (sin instalación)

---

## 📦 Modelos Disponibles

### 🟢 ZENCODE FREE MODELS (API Gratis)

| model_name | Modelo Real | Especialidad |
|------------|-------------|--------------|
| `zencode-glm5` | `openai/glm-5-free` | Ultra-rápido |
| `zencode-glm47` | `openai/glm-4.7-free` | Chat general |
| `zencode-kimi` | `openai/kimi-k2.5-free` | Conversación natural, reasoning |
| `zencode-minimax` | `openai/minimax-m2.5-free` | Chat de alta calidad |

**¿Cuándo usar?** Tareas diarias, chat, búsquedas, resúmenes. Son 100% gratis.

---

### 🔵 GOOGLE GEMINI

| model_name | Modelo Real | Especialidad |
|------------|-------------|--------------|
| `google-gemini-flash` | `gemini/gemini-2.5-flash` | Multimodal, visión, rápido |

**¿Cuándo usar?** Análisis de imágenes, multimodal, o tareas rápidas con cuota disponible.

**⚠️ Nota:** Puede tener límites de cuota. Si falla, usa los modelos de fallback de los stacks.

---

### 🟡 DEEPSEEK PREMIUM (API de Pago - $5 crédito)

| model_name | Modelo Real | Especialidad |
|------------|-------------|--------------|
| `deepseek-api-chat` | `deepseek/deepseek-chat` | Chat premium (DeepSeek-V3 671B) |
| `deepseek-api-coder` | `deepseek/deepseek-coder` | Coding especializado |
| `deepseek-api-reasoner` | `deepseek/deepseek-reasoner` | Reasoning profundo (DeepSeek-R1) |

**¿Cuándo usar?** Solo para tareas críticas que requieran máxima calidad. **Consumen créditos.**

**Costo aproximado:**
- Chat: ~$0.001/1K tokens
- Coder: ~$0.001/1K tokens  
- Reasoner: ~$0.002/1K tokens (más caro por reasoning)

---

### 🟣 OPENROUTER FREE MODELS

| model_name | Modelo Real | Especialidad |
|------------|-------------|--------------|
| `openrouter-liquid` | `liquid/lfm-2.5-1.2b-instruct:free` | Ultra-rápido (1.2B) |
| `openrouter-qwen-coder` | `qwen/qwen-2.5-coder-32b-instruct:free` | Coding (32B) |
| `openrouter-gpt-oss` | `openai/gpt-oss-120b:free` | Chat potente (120B) |
| `openrouter-deepseek-r1` | `deepseek/deepseek-r1-0528:free` | Reasoning gratuito |
| `openrouter-gemma3` | `google/gemma-3-27b-it:free` | Google open source |
| `openrouter-mistral` | `mistralai/mistral-small-3.1-24b-instruct:free` | Mistral equilibrado |

**¿Cuándo usar?** Alternativa gratuita a GPT-4. Muy buenos para coding y reasoning.

---

### ☁️ OLLAMA CLOUD MODELS (Sin Instalación)

| model_name | Modelo Real | Tamaño | Especialidad |
|------------|-------------|--------|--------------|
| `ollama-glm5-cloud` | `ollama/glm-5:cloud` | 5B | Ultra-rápido |
| `ollama-gemma3-cloud` | `ollama/gemma3:27b-cloud` | 27B | Google equilibrado |
| `ollama-qwen35-cloud` | `ollama/qwen3.5:397b-cloud` | 397B | Premium potente |
| `ollama-minimax-cloud` | `ollama/minimax-m2.5:cloud` | - | Chat chino |
| `ollama-qwen-vl-cloud` | `ollama/qwen3-vl:235b-cloud` | 235B | **Visión/multimodal** |
| `ollama-ministral-cloud` | `ollama/ministral-3:8b-cloud` | 8B | Coding rápido |
| `ollama-gemini3-cloud` | `ollama/gemini-3-flash-preview:cloud` | - | **Visión Google** |
| `ollama-gpt-oss-cloud` | `ollama/gpt-oss:120b-cloud` | 120B | Premium alt |

**¿Cuándo usar?** Sin instalación, corren en servidores de Ollama. Ideal para probar modelos grandes sin GPU local.

**⚡ Ventaja:** No requieren `ollama pull`, solo activación inicial con `ollama run modelo:cloud`.

---

## 🎯 Stacks vs Modelos Individuales

### Stacks (Recomendados para Producción)
Tienen **fallbacks automáticos**. Si un modelo falla, prueba el siguiente.

```json
{
  "model": "chat-general"  // Intentará 7 modelos hasta que uno funcione
}
```

**Stacks disponibles:**
- `chat-general` → Conversación diaria (7 fallbacks)
- `coding` → Programación (6 fallbacks)
- `fast` → Ultra-rápido (3 fallbacks)
- `thinking` → Reasoning profundo (5 fallbacks)
- `vision` → Análisis de imágenes (3 fallbacks)
- `embeddings` → Vectorización (2 fallbacks)
- `premium` → Máxima calidad (5 fallbacks)
- `multimodal` → Texto + imágenes (3 fallbacks)

### Modelos Individuales (Para Testing/Debug)
**Sin fallbacks**. Si falla, obtienes error inmediato.

```json
{
  "model": "zencode-kimi"  // Solo intenta este modelo
}
```

**¿Cuándo usar modelos individuales?**
- Testear un modelo específico
- Debugging (saber exactamente qué modelo causó un error)
- Forzar el uso de un proveedor específico
- Comparar respuestas entre modelos

---

## 🧪 Ejemplos de Test

### 1. Test de Modelo Individual
```bash
# Probar si ZenCode Kimi funciona
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "zencode-kimi",
    "messages": [{"role": "user", "content": "Di hola"}]
  }'
```

### 2. Test de Stack con Fallback
```bash
# Si el primero falla, prueba el siguiente automáticamente
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "chat-general",
    "messages": [{"role": "user", "content": "Di hola"}]
  }'
```

### 3. Test de Modelo Premium
```bash
# ⚠️ Consume créditos DeepSeek
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "deepseek-api-coder",
    "messages": [{"role": "user", "content": "Escribe un hello world en Python"}]
  }'
```

### 4. Test de Visión (Ollama Cloud)
```bash
# Análisis de imagen
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "ollama-qwen-vl-cloud",
    "messages": [{
      "role": "user",
      "content": [
        {"type": "text", "text": "¿Qué ves en esta imagen?"},
        {"type": "image_url", "image_url": {"url": "https://example.com/image.jpg"}}
      ]
    }]
  }'
```

---

## 🔍 Identificar Qué Modelo Respondió

LiteLLM incluye headers para identificar el modelo:

```bash
curl -i http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -d '{"model": "chat-general", "messages": [...]}'

# Busca en los headers:
# x-litellm-model: openai/kimi-k2.5-free
# x-litellm-model-fallback-number: 0  (si usó fallback)
```

---

## ❓ Troubleshooting

### Error: "Model not found"
```
Error: 401 litellm.AuthenticationError: Model glm47-free not supported
```

**Solución:** Usa el nuevo nombre con proveedor:
- ❌ `glm47-free`
- ✅ `zencode-glm47`


**Solución:** Activa el modelo cloud primero:
```bash
# LOCAL (Windows)
ollama run gpt-oss:120b-cloud "exit"

# SERVIDOR (Ubuntu con Docker)
docker exec -i ollama ollama run gpt-oss:120b-cloud <<< "exit"

# O usa el script automático
./activate-cloud-models.sh  # En servidor
.\activate-cloud-models.ps1  # En Windows
```

---
