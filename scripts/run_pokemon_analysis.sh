#!/usr/bin/env bash
# Run the Pokémon Name & Physique analysis

set -euo pipefail

echo "[$(date)] Starting Pokémon Name & Physique Analysis..."
Rscript pokemon_name_physique_analysis.R
echo "[$(date)] Analysis complete."
