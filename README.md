# Gravador de Áudio USB - Debian/Linux

Script bash para gravar áudio do PC através de dispositivos USB automaticamente.

## 📋 Descrição

Este script detecta automaticamente dispositivos de áudio USB conectados ao seu sistema Debian/Linux e grava o áudio do computador em formato MP3 de alta qualidade.

## 🔧 Requisitos

Antes de usar o script, certifique-se de ter os seguintes pacotes instalados:

```bash
sudo apt update
sudo apt install ffmpeg pulseaudio-utils
```

- **ffmpeg**: Para processar e gravar o áudio
- **pulseaudio-utils**: Para detectar dispositivos de áudio (comando `pactl`)

## 📦 Instalação

1. Salve o script como `gravar_audio.sh`
2. Dê permissão de execução:

```bash
chmod +x gravar_audio.sh
```

## 🚀 Como Usar

Execute o script diretamente no terminal:

```bash
./gravar_audio.sh
```

### O que acontece:

1. O script detecta automaticamente seu dispositivo USB de áudio
2. Mostra qual dispositivo foi encontrado
3. Inicia a gravação em formato MP3
4. Para parar a gravação, pressione `Ctrl + C`
5. O arquivo será salvo com nome: `audio_pc_AAAAMMDD_HHMMSS.mp3`

## 📁 Arquivos Gerados

Os arquivos são salvos no mesmo diretório onde o script é executado, com o seguinte formato:

```
audio_pc_20250104_153045.mp3
         └─ Ano/Mês/Dia_Hora/Min/Seg
```

## 🔍 Como Funciona

### Detecção Automática do Dispositivo

```bash
pactl list sources short | grep -i "usb" | grep "monitor" | head -n 1 | awk '{print $2}'
```

- **pactl list sources short**: Lista todos os dispositivos de áudio
- **grep -i "usb"**: Filtra apenas dispositivos USB
- **grep "monitor"**: Seleciona o monitor de saída (para gravar o que o PC está reproduzindo)
- **head -n 1**: Pega o primeiro dispositivo encontrado
- **awk '{print $2}'**: Extrai apenas o nome do dispositivo

### Verificação de Erro

Se nenhum dispositivo USB for encontrado, o script:
- Exibe uma mensagem de erro
- Lista todos os dispositivos disponíveis para diagnóstico
- Encerra sem tentar gravar

### Gravação com FFmpeg

```bash
ffmpeg -f pulse -i "$INPUT_DEVICE" -ac 2 -c:a mp3 -q:a 0 "$OUTPUT_FILE"
```

- **-f pulse**: Usa PulseAudio como fonte
- **-i "$INPUT_DEVICE"**: Dispositivo detectado automaticamente
- **-ac 2**: Áudio estéreo (2 canais)
- **-c:a mp3**: Codec MP3
- **-q:a 0**: Qualidade máxima (0 é o melhor)

## 🛠️ Solução de Problemas

### Erro: "Nenhum dispositivo USB de áudio encontrado"

1. Verifique se o dispositivo USB está conectado
2. Liste todos os dispositivos disponíveis:

```bash
pactl list sources short
```

3. Procure por linhas com "usb" e ".monitor"
4. Se encontrar manualmente, você pode editar o script e definir diretamente:

```bash
INPUT_DEVICE="nome_do_seu_dispositivo.monitor"
```

### Verificar Dispositivos Manualmente

Para listar apenas dispositivos USB:

```bash
pactl list sources short | grep usb
```

### Múltiplos Dispositivos USB

Se você tiver vários dispositivos USB, o script usará o primeiro encontrado. Para escolher outro:

1. Liste os dispositivos: `pactl list sources short | grep usb`
2. Copie o nome do dispositivo desejado
3. Edite o script e substitua a linha de detecção automática pelo nome específico

## 💡 Dicas

- **Pausar e Retomar**: O FFmpeg não suporta pause nativamente. Para pausar, pare (Ctrl+C) e inicie uma nova gravação
- **Qualidade do Áudio**: A opção `-q:a 0` garante qualidade máxima. Para arquivos menores, use valores maiores (1-9)
- **Formato de Áudio**: Para gravar em WAV (sem compressão), altere a extensão e codec:
  ```bash
  OUTPUT_FILE="audio_pc_${TIMESTAMP}.wav"
  ffmpeg -f pulse -i "$INPUT_DEVICE" -ac 2 "$OUTPUT_FILE"
  ```

## 📝 Exemplos de Uso

### Gravação Básica
```bash
./gravar_audio.sh
# Pressione Ctrl+C quando quiser parar
```

### Gravar em Background
```bash
./gravar_audio.sh &
# Para parar: kill %1
```

### Gravar por Tempo Determinado
```bash
timeout 60 ./gravar_audio.sh  # Grava por 60 segundos
```

## 🔐 Permissões

O script não requer sudo/root. Ele usa apenas:
- Acesso ao PulseAudio (permissão de usuário normal)
- Permissão de escrita no diretório atual

## 📄 Licença

Script livre para uso pessoal e modificação.

---

**Criado para**: Debian/Ubuntu e distribuições baseadas  
**Testado com**: FFmpeg 4.x, PulseAudio 14.x+
