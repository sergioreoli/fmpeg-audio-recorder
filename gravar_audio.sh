#!/bin/bash

echo "--- Detectando dispositivo de áudio USB ---"

# Detecta automaticamente o dispositivo USB de áudio
INPUT_DEVICE=$(pactl list sources short | grep -i "usb" | grep "monitor" | head -n 1 | awk '{print $2}')

# Verifica se encontrou algum dispositivo
if [ -z "$INPUT_DEVICE" ]; then
    echo "ERRO: Nenhum dispositivo USB de áudio encontrado!"
    echo ""
    echo "Dispositivos disponíveis:"
    pactl list sources short
    exit 1
fi

echo "Dispositivo detectado: ${INPUT_DEVICE}"
echo ""

# Define o nome do arquivo de saída com um timestamp (data e hora)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="audio_pc_${TIMESTAMP}.mp3"

echo "--- Gravando áudio do PC (dispositivo USB) ---"
echo "Arquivo de saída: ${OUTPUT_FILE}"
echo "Pressione Ctrl + C para PARAR a gravação."
echo "----------------------------------------------"

# Executa o comando FFmpeg
ffmpeg -f pulse -i "$INPUT_DEVICE" -ac 2 -c:a mp3 -q:a 0 "$OUTPUT_FILE"

echo ""
echo "Gravação finalizada. Arquivo salvo: ${OUTPUT_FILE}"
