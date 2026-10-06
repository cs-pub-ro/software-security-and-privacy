#!/bin/sh
# AppArmor enforces at the path level, but loading a profile needs a host with
# the AppArmor LSM active and privileges this sandbox does not have. So this
# only checks the reference profile PARSES; enforcement is a manual step on a
# host with AppArmor (deploy-to-apparmor loads it there).
set -e
apparmor_parser -Q apparmor-exec
echo "OK: profile parses (not loaded here; enforce on a host with AppArmor via deploy-to-apparmor)"
