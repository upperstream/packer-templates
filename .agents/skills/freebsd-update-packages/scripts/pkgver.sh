#!/bin/sh -e

# Handle help flag
if [ "${1:-}" = "-H" ] || [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
	cat <<-EOF
	Usage: $0 [packagesite.yaml|-]

	Read freebsd-*.pkr.hcl and parse provisioner sections to retrieve
	depending packages, then read packagesite.yaml to determine package
	versions available on the package repository.

	If no argument is given or '-' is specified, reads packagesite.yaml
	from standard input.

	Examples:
	  # FreeBSD (FreeBSD tar):
	  curl https://pkg.freebsd.org/FreeBSD:15:amd64/quarterly/packagesite.pkg |
	    tar -xf - -O packagesite.yaml | $0

	  # Linux (GNU tar):
	  curl https://pkg.freebsd.org/FreeBSD:15:amd64/quarterly/packagesite.pkg |
	    tar --zstd -xf - -O packagesite.yaml | $0

	  # From a local file:
	  $0 /path/to/packagesite.yaml
	EOF
	exit 0
fi

# Determine the packagesite file source
if [ $# -eq 0 ] || [ "${1:-}" = "-" ]; then
	# Read from stdin into a temporary file
	tmpfile=$(mktemp)
	trap 'rm -f "$tmpfile"' EXIT INT TERM
	cat > "$tmpfile"
	set -- "$tmpfile"
fi

for f in "$@"; do
	printf "### %s\n" "$f"
	sed -n 's/^.*"\([A-Z][A-Z_]*\)=\([A-Za-z0-9-]*\)-[0-9.]*[^"]*",.*$/s\/{.*"name":"\\(\2\\)".*"version":"\\([^"]*\\)",.*$\/\\1-\\2\/p/p' freebsd-*.pkr.hcl | \
	sort -u | \
	while read -r line; do
		sed -n "$line" "$f"
	done
done
