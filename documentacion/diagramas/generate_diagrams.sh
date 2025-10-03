#!/usr/bin/env bash

# Necesitamos el paquete mmdc para generar diagramas mermaid
if ! command -v mmdc &> /dev/null
then
    echo "Debes instalar @mermaid-js/mermaid-cli para poder usar el script"
    exit 1
fi

# Por cada fichero mermaid generamos un png
for mmd_file in *.mmd; do
    if [ -f "$mmd_file" ]; then
        output_file="${mmd_file%.mmd}.png"

        echo "Generando png para $mmd_file -> $output_file"

        mmdc -i "$mmd_file" -o "$output_file" --scale 3
    fi
done

echo "Diagramas generados."
