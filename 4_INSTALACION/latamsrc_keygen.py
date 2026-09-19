#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 latamsrc_keygen.py - Servicio de Autenticación y Keygen Local (Puerto 8888)
==============================================================================
 Soporta la key fija: latamsrcddev
 Registra las IPs en /var/www/html/ChumoGH/checkIP.log
 Devuelve lista-arq para el instalador ADM
==============================================================================
"""
from http.server import HTTPServer, BaseHTTPRequestHandler
import datetime
import os
import sys

PORT = 8888
KEY_FIXED = "latamsrcddev"
LOG_PATH = "/var/www/html/ChumoGH/checkIP.log"

LISTA_ARQ = """cabecalho
menu
menu_credito
v-local.log
payloads
http-server.py
ultrahost
shadowsocks.sh
PDirect.py
PGet.py
POpen.py
PPriv.py
PPub.py
"""

class KeygenHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        client_ip = self.client_address[0]
        now = datetime.datetime.now().strftime("%d/%m/%Y")
        
        # Log de registro
        os.makedirs(os.path.dirname(LOG_PATH), exist_ok=True)
        try:
            with open(LOG_PATH, "a") as f:
                f.write(f"{client_ip} {KEY_FIXED} {now}\n")
        except Exception:
            pass

        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.end_headers()
        
        # Si la petición es un sondeo raíz de conectividad
        if self.path == "/" or self.path == "":
            self.wfile.write(b"OK KEYGEN LATAMSRC ONLINE")
            return
            
        # Si la petición solicita la lista de arquitectura
        self.wfile.write(LISTA_ARQ.encode("utf-8"))

    def do_POST(self):
        self.do_GET()

    def log_message(self, format, *args):
        # Silencioso
        return

def main():
    server = HTTPServer(("0.0.0.0", PORT), KeygenHandler)
    print(f"[*] Keygen/Autenticador latamsrc activo en puerto {PORT} (key fija: {KEY_FIXED})")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    main()
