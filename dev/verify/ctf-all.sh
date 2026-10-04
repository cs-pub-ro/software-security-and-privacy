#!/usr/bin/env bash
#
# Run dev/verify/ctf.sh over every binary CTF challenge and print a pass/fail
# matrix. A challenge is any -full/ task directory that has the four
# build/publish/deploy/solve subdirectories.
#
# Usage: dev/verify/ctf-all.sh [content/labs/NN-...-full ...]
#   With no arguments, discovers every binary challenge under content/labs/.

set -uo pipefail

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"
ROOT=$(cd "$HERE/../.." && pwd)

discover() {
	# A directory with all four halves is a binary challenge.
	while IFS= read -r -d '' deploy; do
		d=$(dirname "$deploy")
		[ -d "$d/build" ] && [ -d "$d/publish" ] && [ -d "$d/solve" ] && printf '%s\n' "$d"
	done < <(find "$ROOT/content/labs" -type d -name deploy -path '*-full/*' -print0) | sort
}

targets=()
if [ $# -gt 0 ]; then
	targets=("$@")
else
	mapfile -t targets < <(discover)
fi

require_docker

declare -a results
rc_all=0
for chal in "${targets[@]}"; do
	rel=${chal#"$ROOT"/}
	if bash "$HERE/ctf.sh" "$chal"; then
		results+=("PASS  $rel")
	else
		results+=("FAIL  $rel")
		rc_all=1
	fi
done

log ""
step "Binary CTF verification matrix"
for r in "${results[@]}"; do
	case "$r" in
	PASS*) printf '  %s%s%s\n' "$C_GREEN" "$r" "$C_RESET" >&2 ;;
	*)     printf '  %s%s%s\n' "$C_RED" "$r" "$C_RESET" >&2 ;;
	esac
done
exit "$rc_all"
