#!/bin/bash
# ==============================================================================
#  ADMcgh - Wrapper del Instalador Original (setup)
# ==============================================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "${SCRIPT_DIR}/setup" --ADMcgh "$@"
