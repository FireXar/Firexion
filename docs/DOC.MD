# Guía de Trabajo con Bash en Windows (CHUMOPLUS)

Esta documentación explica cómo trabajar de forma **segura, rápida y sin riesgo de dañar archivos del sistema** utilizando Bash en Windows dentro de este directorio.

---

## 1. Información del Entorno

- **Ruta Windows**: `C:\xampp\htdocs\pkdlatamsrc\CHUMOPLUS`
- **Ruta en Bash**: `/c/xampp/htdocs/pkdlatamsrc/CHUMOPLUS`
- **Ejecutable de Bash detectado**: `E:\Git\bin\bash.exe` (y `E:\Git\git-bash.exe`)
- **Versión de Bash**: `5.3.15(2)-release` (x86_64-pc-cygwin)

---

## 2. Cómo abrir Bash en este directorio

Tienes 4 opciones fáciles según tu preferencia:

### Opción A: Con el acceso rápido creado (Recomendado)
Haz doble clic en el archivo [abrir_bash.bat](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/abrir_bash.bat) ubicado en esta misma carpeta. Abrirá la ventana de Git Bash posicionada directamente aquí.

### Opción B: Desde el Explorador de Windows
1. Haz clic derecho en un espacio vacío dentro de la carpeta `CHUMOPLUS`.
2. Selecciona **"Open Git Bash here"** o **"Git Bash aquí"**.

### Opción C: Desde una terminal de Git Bash ya abierta
Si ya tienes la consola de Git Bash abierta en tu carpeta de usuario (`~`), escribe:
```bash
cd /c/xampp/htdocs/pkdlatamsrc/CHUMOPLUS
```

### Opción D: Desde PowerShell o CMD de Windows
Puedes ejecutar directamente cualquier script `.sh` sin cambiar de terminal ejecutando:
```powershell
& "E:\Git\bin\bash.exe" hola_mundo.sh
```

---

## 3. Script de Prueba Ejecutado

Se ha creado y probado con éxito el script [hola_mundo.sh](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/hola_mundo.sh):

```bash
#!/usr/bin/env bash
# Script de bienvenida y prueba segura en Windows
set -euo pipefail

echo "=========================================="
echo "         ¡Hola Mundo desde Bash!          "
echo "=========================================="
echo "Directorio actual : $(pwd)"
echo "Usuario           : $(whoami)"
echo "Versión de Bash   : $BASH_VERSION"
echo "Fecha y hora      : $(date)"
echo "=========================================="
echo "Estado: Ejecución exitosa y segura."
```

Para volver a ejecutarlo cuando quieras en Git Bash:
```bash
bash hola_mundo.sh
```
o
```bash
chmod +x hola_mundo.sh
./hola_mundo.sh
```

---

## 4. Reglas de Oro para Trabajar de Forma SEGURA en Windows

Al usar Bash en Windows, la consola tiene acceso a los discos de tu sistema (`/c/`, `/e/`, etc.). Para evitar pérdidas accidentales de datos o dañar el sistema operativo, sigue estas directrices:

### 1. Cuidado con las Rutas Absolutas y Raíz (`/`)
- En Bash en Windows:
  - `/c/` es tu disco `C:\` (donde están Windows, XAMPP, Archivos de Programa, etc.).
  - `/` representa la raíz del emulador de Git/Cygwin (normalmente `E:\Git`).
- **NUNCA ejecutes**: `rm -rf /` ni `rm -rf /*` ni `rm -rf /c/*`.

### 2. Prevención con el comando `rm` (Eliminar archivos)
- **Siempre verifica antes de borrar masivamente**:
  ```bash
  # En vez de hacer rm directamente:
  # 1. Primero lista lo que va a borrar:
  ls *.tmp
  # 2. Si es correcto, borra de forma segura con confirmación interactiva:
  rm -i *.tmp
  ```
- Si usas variables en rutas a borrar, valida que no estén vacías:
  ```bash
  # PELIGROSO: Si RUTA está vacía, borraría la raíz:
  # rm -rf "$RUTA/*"

  # SEGURO:
  if [ -n "${RUTA:-}" ] && [ -d "$RUTA" ]; then
      rm -rf "${RUTA:?error}/"*
  fi
  ```

### 3. Usa siempre `set -euo pipefail` al inicio de tus scripts
Colocar estas banderas al inicio de cualquier script `.sh` evita desastres:
- `-e`: Detiene el script inmediatamente si un comando falla (evita que un comando con error cause que el siguiente comando dañe algo).
- `-u`: Da error si usas una variable no definida (evita borrar rutas vacías).
- `-o pipefail`: Si una tubería (`cmd1 | cmd2`) falla en el primer paso, se detecta el fallo.

### 4. Formato de Saltos de Línea (LF vs CRLF)
- Windows usa saltos de línea `CRLF` (`\r\n`), mientras que Bash espera `LF` (`\n`).
- Si al ejecutar un script obtienes errores como:
  ```text
  bash: ./script.sh: /bin/bash^M: bad interpreter: No such file or directory
  o
  command not found: $'\r'
  ```
- **Solución**: En tu editor (VS Code, Cursor, Notepad++, etc.), cambia el fin de línea de **CRLF** a **LF** en la barra inferior, o ejecuta en Bash:
  ```bash
  dos2unix script.sh
  ```

---

## 5. Plantilla Recomendada para Nuevos Scripts

Cuando quieras crear un nuevo script en este directorio, usa esta estructura base segura:

```bash
#!/usr/bin/env bash
# ==============================================================================
# Nombre: mi_nuevo_script.sh
# Propósito: [Breve descripción]
# ==============================================================================

# Modo estricto y seguro:
set -euo pipefail

# Asegurar que siempre corra en la carpeta del propio script:
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "[INFO] Iniciando tarea en: $SCRIPT_DIR"

# Tu lógica aquí...

echo "[OK] Tarea completada sin errores."
```
