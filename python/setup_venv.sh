#!/bin/bash

set -e

ROOT="$PWD"

# is uv installed?
if ! uv --version; then
    echo "uv package manager must be installed"
fi

# remove old venv if it exists
VENV_DIR="$ROOT/.venv"
if [[ -d "$VENV_DIR" ]]; then
    if ! rm -rf "$VENV_DIR"; then
        echo "Failed to remove old venv"
        exit 1
    fi
fi

# create venv
if ! uv venv; then
    echo "uv virtual environment creation failed"
    exit 1
fi

# activate venv
if ! . .venv/bin/activate; then
    echo "Error activating venv"
    exit 1
fi

# activate venv (we know works) and install deps in same subshell
. .venv/bin/activate && uv pip install -e "."
if [[ "$?" != 0 ]]; then
    echo "Error installing deps with uv"
fi

echo "Successfully created virtual env and installed dependencies"
echo "To activate venv:"
echo
echo ". .venv/bin/activate"
echo
