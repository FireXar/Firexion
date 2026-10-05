#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import socket, threading, select, signal, sys, time, getopt


# Listen
LISTENING_ADDR = '0.0.0.0'
if len(sys.argv) > 1:
    LISTENING_PORT = int(sys.argv[1])
else:
    LISTENING_PORT = 80


# Pass
PASS = ''
# CONST
BUFLEN = 4096 * 4
TIMEOUT = 60
DEFAULT_HOST = '127.0.0.1:22'


MSG = ('<span style=color: #ff0000;><strong>'
       '<span style="color: #ff0000;">C</span>'
       '<span style="color: #ff9900;">h</span>'
       '<span style="color: #008000;">u</span>'
       '<span style="color: #0000ff;">m</span>'
       '<span style="color: #ff0000;">o</span>'
       '<span style="color: #ff9900;">G</span>'
       '<span style="color: #008000;">H</span>'
       '<span style="color: #0000ff;">°</span>'
       '<span style="color: #ff0000;">P</span>'
       '<span style="color: #ff9900;">l</span>'
       '<span style="color: #008000;">u</span>'
       '<span style="color: #0000ff;">s</span>'
       '</strong></span>')


STATUS_RESP = '101'
FTAG = '\r\nContent-length: 999999999\r\n\r\nHTTP/1.1  Connection established\r\n\r\n'


STATUS_TXT = ('<font color="green">Web Socket Protocol</font>'
              if STATUS_RESP == '101'
              else '<font color="red">Connection established</font>')


RESPONSE = (
    "HTTP/1.1 " + STATUS_RESP + " " + STATUS_TXT + " " + MSG + " " + FTAG
).encode()




class Server(threading.Thread):
    def __init__(self, host, port):
        super().__init__()
        self.running = False
        self.host = host
        self.port = port
        self.threads = []
        self.threadsLock = threading.Lock()
        self.logLock = threading.Lock()


    def run(self):
        self.soc = socket.socket(socket.AF_INET)
        self.soc.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.soc.settimeout(2)
        self.soc.bind((self.host, int(self.port)))
        self.soc.listen(0)
        self.running = True


        try:
            while self.running:
                try:
                    c, addr = self.soc.accept()
                    c.setblocking(1)
                except socket.timeout:
                    continue


                conn = ConnectionHandler(c, self, addr)
                conn.start()
                self.addConn(conn)
        finally:
            self.running = False
            self.soc.close()


    def printLog(self, log):
        with self.logLock:
            print(log)


    def addConn(self, conn):
        with self.threadsLock:
            if self.running:
                self.threads.append(conn)


    def removeConn(self, conn):
        with self.threadsLock:
            if conn in self.threads:
                self.threads.remove(conn)


    def close(self):
        self.running = False
        with self.threadsLock:
            threads = list(self.threads)
            for c in threads:
                c.close()




class ConnectionHandler(threading.Thread):
    def __init__(self, socClient, server, addr):
        super().__init__()
        self.clientClosed = False
        self.targetClosed = True
        self.client = socClient
        self.server = server
        self.addr = addr
        self.client_buffer = b''
        self.log = f"Connection: {addr}"


    def close(self):
        try:
            if not self.clientClosed:
                self.client.shutdown(socket.SHUT_RDWR)
                self.client.close()
        except:
            pass
        self.clientClosed = True


        try:
            if not self.targetClosed:
                self.target.shutdown(socket.SHUT_RDWR)
                self.target.close()
        except:
            pass
        self.targetClosed = True


    def run(self):
        try:
            self.client_buffer = self.client.recv(BUFLEN)
            hostPort = self.findHeader(self.client_buffer, b'X-Real-Host') or DEFAULT_HOST
            split = self.findHeader(self.client_buffer, b'X-Split')
            if split:
                self.client.recv(BUFLEN)


            if hostPort:
                passwd = self.findHeader(self.client_buffer, b'X-Pass')
                if PASS and passwd == PASS:
                    self.method_CONNECT(hostPort)
                elif PASS and passwd != PASS:
                    self.client.send(b'HTTP/1.1 400 WrongPass!\r\n\r\n')
                elif hostPort.startswith('127.0.0.1') or hostPort.startswith('localhost'):
                    self.method_CONNECT(hostPort)
                else:
                    self.client.send(b'HTTP/1.1 403 Forbidden!\r\n\r\n')
            else:
                print('- No X-Real-Host!')
                self.client.send(b'HTTP/1.1 400 NoXRealHost!\r\n\r\n')


        except Exception as e:
            self.log += f' - error: {e}'
            self.server.printLog(self.log)
        finally:
            self.close()
            self.server.removeConn(self)


    def findHeader(self, head, header):
        try:
            head_str = head.decode(errors='ignore')
            header_str = header.decode()
            idx = head_str.find(header_str + ': ')
            if idx == -1:
                return ''
            val = head_str[idx:].split(': ', 1)[1].split('\r\n', 1)[0]
            return val.strip()
        except:
            return ''


    def connect_target(self, host):
        if ':' in host:
            h, p = host.split(':', 1)
            port = int(p)
        else:
            h, port = host, 22


        family, socktype, proto, _, address = socket.getaddrinfo(h, port)[0]
        self.target = socket.socket(family, socktype, proto)
        self.targetClosed = False
        self.target.connect(address)


    def method_CONNECT(self, path):
        self.log += f' - CONNECT {path}'
        self.connect_target(path)
        self.client.sendall(RESPONSE)
        self.client_buffer = b''
        self.server.printLog(self.log)
        self.doCONNECT()


    def doCONNECT(self):
        sockets = [self.client, self.target]
        count = 0
        while True:
            recv, _, err = select.select(sockets, [], sockets, 3)
            if err:
                break
            if recv:
                for in_ in recv:
                    try:
                        data = in_.recv(BUFLEN)
                        if data:
                            if in_ is self.target:
                                self.client.sendall(data)
                            else:
                                self.target.sendall(data)
                            count = 0
                        else:
                            return
                    except:
                        return
            count += 1
            if count == TIMEOUT:
                return




def print_usage():
    print("Usage: proxy.py -p <port>")
    print("       proxy.py -b <bindAddr> -p <port>")
    print("       proxy.py -b 0.0.0.0 -p 80")




def parse_args(argv):
    global LISTENING_ADDR, LISTENING_PORT
    try:
        opts, _ = getopt.getopt(argv, "hb:p:", ["bind=", "port="])
    except getopt.GetoptError:
        print_usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt == "-h":
            print_usage()
            sys.exit()
        elif opt in ("-b", "--bind"):
            LISTENING_ADDR = arg
        elif opt in ("-p", "--port"):
            LISTENING_PORT = int(arg)




def main(host=LISTENING_ADDR, port=LISTENING_PORT):
    print("\n\033[1;32mPROXY PYTHON3 WEBSOCKET ADMcgh\033[0m\n")
    print(f" IP: {LISTENING_ADDR}")
    print(f" PUERTO: {port}\n")


    server = Server(host, port)
    server.start()


    try:
        while True:
            time.sleep(2)
    except KeyboardInterrupt:
        print("\nParando servidor...")
        server.close()




if __name__ == "__main__":
    parse_args(sys.argv[1:])
    main()
