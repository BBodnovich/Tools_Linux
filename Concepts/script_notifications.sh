# Inspiration credit goes to github.com/glennj
# Plan to tweak this for personal use

log() { printf '%(%F %T)T - %s\n' -1 "$*"; }
warn() { log "$*" >&2; return 1; }
die() { warn "$*"; exit 1; }


(( $# == 1 )) || die "Usage: example usage message here"
