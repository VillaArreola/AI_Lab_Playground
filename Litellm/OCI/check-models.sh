#!/bin/bash
# =========================================================
# Script de Verificación de Modelos Ollama Cloud
# Verifica qué modelos cloud están activos y cuáles faltan
# =========================================================

echo "🔍 Verificando modelos Ollama Cloud..."
echo ""

# Modelos esperados
EXPECTED_MODELS=(
    "deepseek-v3.2:cloud"
    "glm-4.7:cloud"
    "glm-5:cloud"
    "gemma3:27b-cloud"
    "qwen3.5:397b-cloud"
    "minimax-m2.5:cloud"
    "qwen3-vl:235b-instruct-cloud"
    "ministral-3:8b-cloud"
    "gemini-3-flash-preview:cloud"
    "gpt-oss:20b-cloud"
    "gpt-oss:120b-cloud"
    "qwen3-coder-next:cloud"
)

# Verificar que Ollama esté corriendo
if ! docker ps | grep -q "ollama"; then
    echo "❌ Error: El contenedor 'ollama' no está corriendo"
    exit 1
fi

# Obtener lista de modelos activos
ACTIVE_MODELS=$(docker exec ollama ollama list 2>/dev/null | awk 'NR>1 {print $1}')

FOUND=0
MISSING=0

echo "📊 Estado de Modelos Cloud:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

for MODEL in "${EXPECTED_MODELS[@]}"; do
    if echo "$ACTIVE_MODELS" | grep -q "^${MODEL}$"; then
        echo "✅ $MODEL"
        FOUND=$((FOUND + 1))
    else
        echo "❌ $MODEL (falta activar)"
        MISSING=$((MISSING + 1))
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📈 Resumen:"
echo "   ✅ Activos: $FOUND/${#EXPECTED_MODELS[@]}"
echo "   ❌ Faltantes: $MISSING/${#EXPECTED_MODELS[@]}"
echo ""

if [ $MISSING -gt 0 ]; then
    echo "⚠️  Algunos modelos faltan por activar"
    echo "   Ejecuta: ./activate-cloud-models.sh"
    exit 1
else
    echo "✅ Todos los modelos cloud están activos"
    
    # Verificar estado de LiteLLM
    if docker ps | grep -q "litellm"; then
        echo ""
        echo "🔄 Estado de LiteLLM: ✅ Corriendo"
        echo "   Dashboard: http://localhost:4000/ui"
    else
        echo ""
        echo "⚠️  LiteLLM no está corriendo"
        echo "   Ejecuta: docker-compose up -d litellm"
    fi
fi

echo ""
