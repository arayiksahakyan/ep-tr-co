import os
from pathlib import Path

from flask import Flask, Response
from redis import Redis


app = Flask(__name__)


def _read_setting(name: str, file_name: str | None = None, default: str | None = None) -> str | None:
    value = os.getenv(name)
    if value:
        return value

    file_path = os.getenv(file_name or f"{name}_FILE")
    if file_path:
        path = Path(file_path)
        if path.exists():
            return path.read_text(encoding="utf-8").strip()

    return default


def _redis_client() -> Redis:
    ssl_mode = _read_setting("REDIS_SSL_MODE", default="True")

    return Redis(
        host=_read_setting("REDIS_URL", default="localhost"),
        port=int(_read_setting("REDIS_PORT", default="6380")),
        password=_read_setting("REDIS_PWD"),
        ssl=str(ssl_mode).lower() == "true",
        decode_responses=True,
        socket_connect_timeout=5,
        socket_timeout=5,
    )


@app.get("/")
def index() -> Response:
    creator = _read_setting("CREATOR", default="UNKNOWN")
    visits = _redis_client().incr(f"visits:{creator}")
    return Response(f"Hello from {creator}\nVisits: {visits}\n", mimetype="text/plain")


@app.get("/health")
def health() -> Response:
    return Response("OK\n", mimetype="text/plain")
