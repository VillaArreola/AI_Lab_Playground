# 🚀 Modelos Útiles de OpenRouter - Funcionando ✅


#### 1. **Código / Programación**
```yaml
# Qwen 2.5 Coder - Excelente para código
openrouter/qwen/qwen-2.5-coder-32b-instruct:free

# Qwen 3 Coder - Más reciente
openrouter/qwen/qwen3-coder:free 
```

#### 2. **Razonamiento / Análisis**
```yaml
# DeepSeek R1 - Modelo de razonamiento avanzado
openrouter/deepseek/deepseek-r1-0528:free

# GPT OSS 120B - Modelo open source potente
openrouter/openai/gpt-oss-120b:free
```

#### 3. **Chat General**
```yaml
# Mistral Small - Rápido y eficiente
openrouter/mistralai/mistral-small-3.1-24b-instruct:free

# Google Gemma 3 - Buena calidad
openrouter/google/gemma-3-27b-it:free

# Google Gemma E2B -Más ligero
openrouter/google/gemma-3n-e2b-it:free
```

#### 4. **Generación de Imágenes**
```yaml
# FLUX.2 Pro - Generación de imágenes de alta calidad
openrouter/black-forest-labs/flux.2-pro

# Seedream 4.5 - Alternativa para imágenes
openrouter/bytedance-seed/seedream-4.5
```

#### 5. **Experimental / Avanzado**
```yaml
# Aurora Alpha - Modelo experimental de OpenRouter
openrouter/aurora-alpha
```

## 📦 Cómo Agregar Más Modelos

### Opción 1: Agregar al stack existente como fallback

```yaml
- model_name: openrouter # Agregar después del modelo principal
  litellm_params:
    model: openrouter/qwen/qwen-2.5-coder-32b-instruct:free
    api_key: os.environ/OPENROUTER_API_KEY
    timeout: 300
    temperature: 0.3  # Temperatura baja para código
    max_tokens: 8192
    stream: true
```

### Opción 2: Crear un nuevo stack específico

```yaml
# Stack para código con Qwen
- model_name: qwen-coder
  litellm_params:
    model: openrouter/qwen/qwen-2.5-coder-32b-instruct:free
    api_key: os.environ/OPENROUTER_API_KEY
    timeout: 300
    temperature: 0.2
    max_tokens: 8192
    stream: true

- model_name: qwen-coder # Fallback
  litellm_params:
    model: openrouter/qwen/qwen3-coder:free
    api_key: os.environ/OPENROUTER_API_KEY
    timeout: 300
    temperature: 0.2
    stream: true
```

## 🧪 Cómo Probar Modelos

### 1. Modificar config.yaml
Agrega el modelo que quieres probar

### 2. Reiniciar LiteLLM
```powershell
docker-compose restart litellm
Start-Sleep -Seconds 10
```

### 3. Probar con curl
```powershell
$env:LITELLM_MASTER_KEY = "sk-363289ec96b7c4bcf5e0fb398d241797b5284dd20727bbaa"

$body = @{
    model = "openrouter"  # o el nombre de tu stack
    messages = @(
        @{
            role = "user"
            content = "Test message"
        }
    )
} | ConvertTo-Json -Depth 10

curl http://localhost:4000/v1/chat/completions `
  -H "Authorization: Bearer $env:LITELLM_MASTER_KEY" `
  -H "Content-Type: application/json" `
  -d $body

yaml
# Stack optimizado con fallbacks inteligentes
- model_name: openrouter-premium
  litellm_params:
    model: openrouter/qwen/qwen-2.5-coder-32b-instruct:free
    api_key: os.environ/OPENROUTER_API_KEY
    timeout: 300
    temperature: 0.3
    max_tokens: 8192
    stream: true

- model_name: openrouter-premium # Fallback: DeepSeek R1
  litellm_params:
    model: openrouter/deepseek/deepseek-r1-0528:free
    api_key: os.environ/OPENROUTER_API_KEY
    timeout: 300
    temperature: 0.3
    stream: true

- model_name: openrouter-premium # Fallback: Mistral Small
  litellm_params:
    model: openrouter/mistralai/mistral-small-3.1-24b-instruct:free
    api_key: os.environ/OPENROUTER_API_KEY
    timeout: 300
    temperature: 0.5
    stream: true


**Última actualización:** 2026-02-17  
