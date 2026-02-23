import yaml
import sys

try:
    with open('OCI/config.yaml', 'r', encoding='utf-8') as f:
        content = f.read()
        yaml.safe_load(content)
    print("✅ OCI/config.yaml is valid YAML")
except yaml.YAMLError as e:
    print(f"❌ YAML Error in OCI/config.yaml:")
    print(e)
    sys.exit(1)
except Exception as e:
    print(f"❌ Error reading file:")
    print(e)
    sys.exit(1)

try:
    with open('config.yaml', 'r', encoding='utf-8') as f:
        content = f.read()
        yaml.safe_load(content)
    print("✅ config.yaml is valid YAML")
except yaml.YAMLError as e:
    print(f"❌ YAML Error in config.yaml:")
    print(e)
    sys.exit(1)
except Exception as e:
    print(f"❌ Error reading file:")
    print(e)
    sys.exit(1)

print("\n✅ Both config files are valid!")
