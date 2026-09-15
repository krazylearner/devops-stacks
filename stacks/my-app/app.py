"""my-app Day38 - tiny stdlib HTTP, no deps."""
import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

VERSION = os.getenv("APP_VERSION", "v1")
GIT_SHA = os.getenv("GIT_SHA", "local")


class H(BaseHTTPRequestHandler):
    def do_GET(self):  # noqa: N802
        if self.path == "/healthz":
            body = b"ok"
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return
        payload = json.dumps({"app": "my-app", "version": VERSION, "sha": GIT_SHA}).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def log_message(self, *a):  # quiet
        pass


if __name__ == "__main__":
    port = int(os.getenv("PORT", "8000"))
    print(f"my-app {VERSION} sha={GIT_SHA} on :{port}", flush=True)
    HTTPServer(("0.0.0.0", port), H).serve_forever()
