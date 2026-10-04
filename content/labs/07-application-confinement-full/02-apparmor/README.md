# AppArmor

`apparmor-exec` is the reference profile that allows `a.txt` and denies `b.txt`; `deploy-to-apparmor` loads it.
AppArmor keys on the executable's path, so moving or copying the binary escapes the profile unless the profile covers the new path.
See the [task](../../07-application-confinement-live/02-apparmor/README.md).
