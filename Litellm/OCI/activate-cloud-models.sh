#!/bin/bash
# =========================================================
# Script de Activación de Modelos Ollama Cloud - Ubuntu Server
# Para ejecutar en servidor donde Ollama corre en Docker
# =========================================================

set -e  # Detener si hay error

echo "🚀 Activando modelos Ollama Cloud en Docker..."
echo ""

# Lista de modelos cloud a activar
MODELS=(
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

ACTIVATED=0
FAILED=0
TOTAL=${#MODELS[@]}

echo "📦 Total de modelos a activar: $TOTAL"
echo ""

# Verificar que el contenedor de Ollama esté corriendo
if ! docker ps | grep -q "ollama"; then
    echo "❌ Error: El contenedor 'ollama' no está corriendo"
    echo "   Ejecuta: docker-compose up -d ollama"
    exit 1
fi

# Activar cada modelo
for MODEL in "${MODELS[@]}"; do
    NUM=$((ACTIVATED + FAILED + 1))
    echo "[$NUM/$TOTAL] Activando: $MODEL"
    
    # Ejecutar dentro del contenedor con timeout de 30 segundos
    if timeout 30 docker exec -i ollama ollama run "$MODEL" <<< "exit" > /dev/null 2>&1; then
        echo "        ✅ Activado correctamente"
        ACTIVATED=$((ACTIVATED + 1))
    else
        echo "        ❌ Error al activar"
        FAILED=$((FAILED + 1))
    fi
    
    sleep 1
done

echo ""
echo "============================================================"
echo ""
echo "✅ Activados exitosamente: $ACTIVATED modelos"
echo "❌ Fallidos: $FAILED modelos"
echo ""

if [ $ACTIVATED -gt 0 ]; then
    echo "🎉 ¡Activación completada!"
    echo ""
    echo "📋 Verifica los modelos disponibles:"
    echo "   docker exec ollama ollama list"
    echo ""
    echo "🔄 Reinicia LiteLLM para aplicar cambios:"
    echo "   docker-compose restart litellm"
    echo ""
    
    # Preguntar si reiniciar automáticamente
    read -p "¿Deseas reiniciar LiteLLM ahora? (s/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[SsYy]$ ]]; then
        echo "🔄 Reiniciando LiteLLM..."
        docker-compose restart litellm
        echo "✅ LiteLLM reiniciado correctamente"
    fi
else
    echo "⚠️  No se activó ningún modelo."
    echo "   Verifica que Ollama esté corriendo:"
    echo "   docker ps | grep ollama"
fi

echo ""
echo "✅ Script completado"
