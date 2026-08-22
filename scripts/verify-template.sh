#!/usr/bin/env bash
set -euo pipefail

template_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cna_root="${CNA_CS_ROOT:-$(cd "$template_root/../cna-cs" 2>/dev/null && pwd || true)}"
dotnet_command="${DOTNET_COMMAND:-dotnet}"

if [[ -z "$cna_root" || ! -f "$cna_root/src/CNA.XnaCompat/CNA.XnaCompat.csproj" ]]; then
  echo "Set CNA_CS_ROOT to a cna-cs checkout before running this verifier." >&2
  exit 2
fi

verification_root="$(mktemp -d)"
trap 'rm -rf "$verification_root"' EXIT

export DOTNET_CLI_HOME="$verification_root/dotnet-home"
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1

"$dotnet_command" new install "$template_root"
"$dotnet_command" new cna-game --name GeneratedCnaGame --output "$verification_root/GeneratedCnaGame"

generated_root="$verification_root/GeneratedCnaGame"
if [[ -e "$generated_root/Directory.Build.props" || -d "$generated_root/scripts" ]]; then
  echo "Generated output contains repository-only template infrastructure." >&2
  exit 1
fi
if grep -Fq '..\cna-cs' "$generated_root/GeneratedCnaGame.csproj"; then
  echo "Generated project contains a repository-specific sibling path." >&2
  exit 1
fi

"$dotnet_command" build "$verification_root/GeneratedCnaGame/GeneratedCnaGame.csproj" \
  -p:CnaCsRoot="$cna_root" -m:1

if [[ "${CNA_TEMPLATE_RUN_SMOKE:-0}" == "1" ]]; then
  "$dotnet_command" run \
    --project "$verification_root/GeneratedCnaGame/GeneratedCnaGame.csproj" \
    -p:CnaCsRoot="$cna_root" --no-build -- --smoke-test
fi
