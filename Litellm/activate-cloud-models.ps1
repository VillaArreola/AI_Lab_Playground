Write-Host "🚀 Activando modelos Ollama Cloud..." -ForegroundColor Cyan
Write-Host ""

$cloudModels = @(
    "deepseek-v3.2:cloud",
    "glm-4.7:cloud",
    "glm-5:cloud",
    "gemma3:27b-cloud",
    "qwen3.5:397b-cloud",
    "minimax-m2.5:cloud",
    "qwen3-vl:235b-instruct-cloud",
    "ministral-3:8b-cloud",
    "gemini-3-flash-preview:cloud",
    "gpt-oss:20b-cloud",
    "gpt-oss:120b-cloud",
    "nomic-embed-text:cloud",
    "mxbai-embed-large:cloud",
    "qwen3-coder-next:cloud"
)

$activated = 0
$failed = 0
$total = $cloudModels.Count

Write-Host "📦 Total de modelos a activar: $total" -ForegroundColor Yellow
Write-Host ""

foreach ($model in $cloudModels) {
    $num = $activated + $failed + 1
    Write-Host "[$num/$total] Activando: $model" -ForegroundColor Cyan
    
    try {
        # Ejecutar ollama run con entrada mínima
        $output = echo "exit" | ollama run $model 2>&1
        
        if ($LASTEXITCODE -eq 0 -or $output -match "success|pulled|ready") {
            Write-Host "        ✅ Activado correctamente" -ForegroundColor Green
            $activated++
        } else {
            Write-Host "        ❌ Error al activar" -ForegroundColor Red
            $failed++
        }
    }
    catch {
        Write-Host "        ⚠️  Error: $($_.Exception.Message)" -ForegroundColor Yellow
        $failed++
    }
    
    Start-Sleep -Milliseconds 500
}

Write-Host ""
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ Activados exitosamente: $activated modelos" -ForegroundColor Green
Write-Host "❌ Fallidos: $failed modelos" -ForegroundColor Red
Write-Host ""

if ($activated -gt 0) {
    Write-Host "🎉 ¡Proceso completado! Ahora reinicia LiteLLM:" -ForegroundColor Cyan
    Write-Host "   docker-compose restart litellm" -ForegroundColor White
    Write-Host ""
    Write-Host "📋 Verifica los modelos disponibles con:" -ForegroundColor Cyan
    Write-Host "   ollama list" -ForegroundColor White
} else {
    Write-Host "⚠️  No se activó ningún modelo. Verifica que Ollama esté corriendo." -ForegroundColor Yellow
    Write-Host "   docker-compose ps ollama" -ForegroundColor White
}

Write-Host ""
