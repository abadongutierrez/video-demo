#!/bin/bash

echo "Compiling..."
coffee --compile --output ./public/lib/ ./public/src/
echo "Done!"