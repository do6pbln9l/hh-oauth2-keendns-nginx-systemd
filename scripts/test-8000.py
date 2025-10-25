#!/usr/bin/env python3
"""
Простой HTTP-сервер для тестирования OAuth callback
Запуск: python3 test-8000.py
"""
import urllib.parse
from http.server import BaseHTTPRequestHandler, HTTPServer

class CallbackHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed = urllib.parse.urlsplit(self.path)
        if parsed.path == '/callback':
            query = urllib.parse.parse_qs(parsed.query)
            code = query.get('code', [''])[0]
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain; charset=utf-8')
            self.end_headers()
            self.wfile.write(f'✓ Callback OK\nAuthorization code: {code}'.encode())
        else:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b'✓ Server is running')

if __name__ == '__main__':
    print('Starting test server on http://0.0.0.0:8000')
    HTTPServer(('0.0.0.0', 8000), CallbackHandler).serve_forever()
