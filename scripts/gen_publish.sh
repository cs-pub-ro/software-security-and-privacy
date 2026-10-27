#!/usr/bin/env bash
#
# Regenerate the binary artifacts students receive, and mirror them into the
# `-live/` tree so they ship through a plain `git clone` (there is no zip
# archive any more).
#
# For each binary challenge (a `-full/<task>/` directory that has build/,
# publish/ and deploy/), this:
#   1. compiles the challenge in its build/ image, exactly as a deployment does;
#   2. copies the built executable into publish/ and the sibling -live/ task;
#   3. for a challenge that ships a libc (publish/ already carries libc.so.6),
#      extracts the 32-bit libc.so.6 from the deploy image's base — the same
#      libc the deployed binary runs against — into publish/ and -live/.
#
# The point is that the shipped binary and libc are the ones the deployment
# runs: a return-to-libc exploit needs the target's exact libc offsets, so a
# mismatched libc would make it fail. Run this whenever a challenge is rebuilt.
#
# Usage: scripts/gen_publish.sh [content/labs/NN-...-full/<task> ...]
#   With no arguments, every binary challenge under content/labs/ is processed.

set -euo pipefail

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ROOT=$(cd "$HERE/.." && pwd)

log() { printf '%s\n' "$*" >&2; }

dockerfile_arg() {
	# dockerfile_arg <dockerfile> <ARG name> -> default value, or empty
	sed -n "s/^ARG ${2}=\"\\{0,1\\}\\([^\"]*\\)\"\\{0,1\\}.*/\\1/p" "$1" | head -n1
}

base_image() {
	# first FROM in a Dockerfile, ARG refs left as-is
	sed -n 's/^FROM \([^ ]*\).*/\1/p' "$1" | head -n1
}

discover() {
	while IFS= read -r -d '' deploy; do
		d=$(dirname "$deploy")
		[ -d "$d/build" ] && [ -d "$d/publish" ] && printf '%s\n' "$d"
	done < <(find "$ROOT/content/labs" -type d -name deploy -path '*-full/*' -print0) | sort
}

process() {
	local chal full_task name live exec_name builder
	chal=$1
	full_task=$(cd "$chal" && pwd)
	name=$(basename "$full_task")
	# -full/<task> -> -live/<task>
	live=$(printf '%s' "$full_task" | sed 's#-full/#-live/#')
	if [ ! -d "$live" ]; then
		log "SKIP $name: no -live sibling ($live)"
		return
	fi

	exec_name=$(dockerfile_arg "$full_task/deploy/Dockerfile" EXEC_NAME)
	exec_name=${exec_name:-vuln}

	log "==> $name (exec=$exec_name)"

	# 1. Compile in the build/ image, exactly as a deployment does.
	builder="genpublish-$name-builder"
	docker build -q -t "$builder" "$full_task/build" >/dev/null
	docker run --rm -v "$full_task/build:/build" "$builder" make >/dev/null
	docker rmi "$builder" >/dev/null 2>&1 || true

	# 2. Built executable -> publish/ and -live/ always, and the reference
	#    solve/ when it carries a copy (it must attack the same binary).
	cp "$full_task/build/$exec_name" "$full_task/publish/$exec_name"
	cp "$full_task/build/$exec_name" "$live/$exec_name"
	chmod 755 "$full_task/publish/$exec_name" "$live/$exec_name"
	if [ -e "$full_task/solve/$exec_name" ]; then
		cp "$full_task/build/$exec_name" "$full_task/solve/$exec_name"
		chmod 755 "$full_task/solve/$exec_name"
	fi
	log "    shipped $exec_name"

	# 3. Ship the matching libc only for challenges that already ship one.
	if [ -f "$full_task/publish/libc.so.6" ]; then
		local base
		base=$(base_image "$full_task/deploy/Dockerfile")
		docker run --rm "$base" sh -c '
			apt-get -yqq update >/dev/null 2>&1 &&
			apt-get -yqq install libc6-i386 >/dev/null 2>&1 &&
			cat "$(readlink -f "$(dpkg -L libc6-i386 | grep -m1 "/libc\.so\.6$")")"
		' > "$full_task/publish/libc.so.6"
		if [ ! -s "$full_task/publish/libc.so.6" ]; then
			log "    ERROR: libc.so.6 came back empty from $base"
			return 1
		fi
		cp "$full_task/publish/libc.so.6" "$live/libc.so.6"
		[ -e "$full_task/solve/libc.so.6" ] && cp "$full_task/publish/libc.so.6" "$full_task/solve/libc.so.6"
		log "    shipped libc.so.6 (from $base + libc6-i386)"
	fi

	# Clean build intermediates so the working tree stays tidy.
	rm -f "$full_task/build/$exec_name" "$full_task"/build/*.o 2>/dev/null || true
}

main() {
	local targets=()
	if [ $# -gt 0 ]; then
		targets=("$@")
	else
		mapfile -t targets < <(discover)
	fi
	for chal in "${targets[@]}"; do
		process "$chal"
	done
	log "done"
}

main "$@"
