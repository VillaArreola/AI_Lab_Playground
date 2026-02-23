# Script para verificar modelos disponibles en Z.AI
# Ejecutar: python verify_zai_models.py

from openai import OpenAI

# Configuración de Z.AI
client = OpenAI(
    api_key="cc92db6b9a6b401c977e77d2af7229c6.8sgzztkc4VFoebZ9",
    base_url="https://api.z.ai/api/paas/v4/"
)

print("=" * 60)
print("🔍 Verificando modelos disponibles en Z.AI")
print("=" * 60)

try:
    # Listar todos los modelos disponibles
    models = client.models.list()
    
    print(f"\n✅ Encontrados {len(models.data)} modelos:\n")
    
    for i, model in enumerate(models.data, 1):
        print(f"{i}. {model.id}")
        if hasattr(model, 'description'):
            print(f"   Descripción: {model.description}")
        print()
    
    print("=" * 60)
    print("📋 Para usar en LiteLLM config.yaml:")
    print("=" * 60)
    print("\nEjemplo:")
    if models.data:
        example_model = models.data[0].id
        print(f"""
- model_name: zai
  litellm_params:
    model: openai/{example_model}
    api_base: "https://api.z.ai/api/paas/v4/"
    api_key: os.environ/ZAI_API_KEY
    timeout: 300
    max_tokens: 4096
    temperature: 0.7
    stream: true
""")

except Exception as e:
    print(f"\n❌ Error al conectar con Z.AI:")
    print(f"   {str(e)}")
    print("\n💡 Verifica:")
    print("   1. API Key correcta")
    print("   2. URL base correcta")
    print("   3. Conexión a internet")

print("\n" + "=" * 60)
print("🧪 Probando generación de texto...")
print("=" * 60)

try:
    # Probar con el primer modelo disponible
    completion = client.chat.completions.create(
        model="glm-4.7",  # Modelo según tu ejemplo
        messages=[
            {"role": "user", "content": "Say 'OK' if you work"}
        ]
    )
    
    response_text = completion.choices[0].message.content
    print(f"\n✅ Respuesta del modelo GLM-4.7:")
    print(f"   {response_text}")
    print("\n✨ Z.AI está funcionando correctamente!")
    
except Exception as e:
    print(f"\n❌ Error al generar texto:")
    print(f"   {str(e)}")
    print("\n💡 El modelo 'glm-4.7' puede no estar disponible.")
    print("   Prueba con los nombres listados arriba.")
