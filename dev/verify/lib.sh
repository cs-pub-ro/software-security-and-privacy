# Shared helpers for the containerised verification harness.
#
# Sourced, not executed. Everything here runs through Docker, so the only host
# tools needed are docker and coreutils; no language toolchain is installed on
# the host (see dev/verify/README.md).

# Colours only on a terminal.
if [ -t 1 ]; then
	C_RED=$'\033[31m'; C_GREEN=$'\033[32m'; C_YELLOW=$'\033[33m'
	C_BOLD=$'\033[1m'; C_RESET=$'\033[0m'
else
	C_RED=''; C_GREEN=''; C_YELLOW=''; C_BOLD=''; C_RESET=''
fi

log()  { printf '%s\n' "$*" >&2; }
step() { printf '%s==>%s %s\n' "$C_BOLD" "$C_RESET" "$*" >&2; }
pass() { printf '%sPASS%s %s\n' "$C_GREEN" "$C_RESET" "$*" >&2; }
fail() { printf '%sFAIL%s %s\n' "$C_RED" "$C_RESET" "$*" >&2; }
warn() { printf '%sWARN%s %s\n' "$C_YELLOW" "$C_RESET" "$*" >&2; }

# Parse a `KEY="value"` or `KEY=value` build ARG out of a Dockerfile.
dockerfile_arg() {
	local file=$1 name=$2
	grep -oP "ARG ${name}=\"?\K[^\"]+" "$file" 2>/dev/null | head -n1
}

# Parse the xinetd `port = NNNNN` a challenge listens on inside its container.
xinetd_port() {
	grep -oP '^\s*port\s*=\s*\K[0-9]+' "$1" 2>/dev/null | head -n1
}

# Require docker, and a reachable daemon.
require_docker() {
	command -v docker >/dev/null 2>&1 || { fail "docker is not installed"; exit 2; }
	docker info >/dev/null 2>&1 || { fail "the docker daemon is not reachable"; exit 2; }
}
