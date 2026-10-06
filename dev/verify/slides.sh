#!/usr/bin/env bash
#
# Render the Quarto slide decks to reveal.js HTML in a container with Quarto, to
# confirm they build. Host needs only Docker. The generated .html files are
# git-ignored; this script removes them afterwards so the tree stays clean.
#
# Usage: dev/verify/slides.sh [path]   (path relative to repo root; default: all
#        lectures). e.g. dev/verify/slides.sh content/lectures/08-system-isolation-full
#
# Exit status: 0 if every deck under the path rendered, non-zero otherwise.

set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"
root=$(cd "$HERE/../.." && pwd)
rel="${1:-content/lectures}"
require_docker

img="ssp-quarto-runner"
docker build -q -t "$img" - >/dev/null <<'DF'
FROM debian:13
ARG QV=1.5.57
RUN apt-get -yqq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -yqq install --no-install-recommends curl ca-certificates \
 && curl -fsSL -o /tmp/q.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QV}/quarto-${QV}-linux-amd64.deb" \
 && DEBIAN_FRONTEND=noninteractive apt-get -yqq install --no-install-recommends /tmp/q.deb \
 && rm -rf /tmp/q.deb /var/lib/apt/lists/*
DF

log ""
step "rendering slide decks under $rel"
set +e
out=$(docker run --rm -e HOME=/tmp -v "$root:/repo" -w /repo "$img" \
	bash scripts/render_slides.sh "/repo/$rel" 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2
# clean the generated (git-ignored) HTML so the working tree stays tidy
find "$root/$rel" -type d -name slides -prune -exec find {} -name '*.html' -delete \; 2>/dev/null || true

if [ "$rc" -eq 0 ]; then
	pass "all decks under $rel rendered"
	exit 0
fi
fail "a deck under $rel failed to render (exit $rc)"
exit 1
