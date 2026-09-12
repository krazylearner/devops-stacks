#!/bin/bash
# Serve MkDocs Material tracker on :8002 (pipx install)
exec pipx run --spec mkdocs-material mkdocs serve -a 0.0.0.0:8002 --livereload
