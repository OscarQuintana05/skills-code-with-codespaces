#!/usr/bin/env bash
set -euo pipefail

echo "postCreate: preparando entorno..."

# Preferir usar el python del contenedor
if command -v python >/dev/null 2>&1; then
  PYTHON=python
elif command -v python3 >/dev/null 2>&1; then
  PYTHON=python3
else
  echo "Python no encontrado en el PATH."
  exit 0
fi

echo "Usando: $PYTHON"

# Actualizar pip
"$PYTHON" -m pip install --upgrade pip setuptools wheel || true

# Instalar dependencias si existe requirements.txt
if [ -f "requirements.txt" ]; then
  echo "Instalando dependencias desde requirements.txt..."
  "$PYTHON" -m pip install -r requirements.txt
else
  echo "No se encontró requirements.txt — omitiendo instalación de dependencias."
fi

echo "postCreate: completado."

# Añadir animación de locomotora de vapor (sl)
echo "Preparando instalación opcional de 'sl' (animación)..."
if command -v apt-get >/dev/null 2>&1; then
  # Sólo intentar instalar si el script se ejecuta como root
  if [ "$(id -u)" -eq 0 ]; then
    apt-get update
    apt-get install -y sl
    # Asegurar que /usr/games esté en PATH para bash y zsh
    echo "export PATH=\$PATH:/usr/games" >> ~/.bashrc || true
    echo "export PATH=\$PATH:/usr/games" >> ~/.zshrc || true
    echo "Instalación de 'sl' completada. Ejecuta 'sl' para ver la animación (si terminal la soporta)."
  else
    echo "No se tienen privilegios de root; no se instalará 'sl' aquí."
    echo "Para evitar fallos del validador, instala 'sl' en la imagen (Dockerfile) o usa una feature en devcontainer.json."
  fi
else
  echo "apt-get no disponible — omitiendo instalación de 'sl'."
fi
