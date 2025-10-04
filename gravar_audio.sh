#!/bin/bash

#Descubra a sua Device exemplo
#list sources short | grep usb

# Saída 
# 49	alsa_output.usb-Solid_State_System_Co._Ltd._USB_PnP_Audio_Device_000000000000-00.analog-stereo.monitor	PipeWire	s16le 2ch 48000Hz	RUNNING
# 50	alsa_input.usb-Solid_State_System_Co._Ltd._USB_PnP_Audio_Device_000000000000-00.analog-stereo	PipeWire	s16le 2ch 48000Hz	RUNNING

# Define a fonte de monitoramento de áudio USB
# COPIE O NOME COMPLETO DA SUA SAÍDA DE ÁUDIO (com .monitor no final)
INPUT_DEVICE="alsa_output.usb-Solid_State_System_Co._Ltd._USB_PnP_Audio_Device_000000000000-00.analog-stereo.monitor"

# Define o nome do arquivo de saída com um timestamp (data e hora)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="audio_pc_${TIMESTAMP}.mp3"

echo "--- Gravando áudio do PC (dispositivo USB) ---"
echo "Arquivo de saída: ${OUTPUT_FILE}"
echo "Pressione Ctrl + C para PARAR a gravação."
echo "----------------------------------------------"

# Executa o comando FFmpeg
ffmpeg -f pulse -i "$INPUT_DEVICE" -ac 2 -c:a mp3 -q:a 0 "$OUTPUT_FILE"

echo "Gravação finalizada. Arquivo salvo."
