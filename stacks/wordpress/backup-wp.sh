#!/bin/bash
# backup-wp.sh - backup WordPress DB + files
# usage: ./backup-wp.sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
DATE=$(date +%F)
# Load secrets from .env (gitignored) — never hardcode
# shellcheck disable=SC1091
[ -f "$DIR/.env" ] && set -a && . "$DIR/.env" && set +a
: "${WP_DB_USER:?set WP_DB_USER in stacks/wordpress/.env or Portainer env override}"
: "${WP_DB_PASSWORD:?set WP_DB_PASSWORD in stacks/wordpress/.env}"
: "${WP_DB_NAME:=wp}"
echo "[1/3] dumping mysql $WP_DB_NAME -> $DIR/backup-wp-$DATE.sql"
docker exec wp-db mysqldump -u"$WP_DB_USER" -p"$WP_DB_PASSWORD" "$WP_DB_NAME" > "$DIR/backup-wp-$DATE.sql" 2>/dev/null || echo "note: empty DB before install - dump may be empty, ok"
echo "[2/3] tarring wp_data volume -> $DIR/backup-wp-files-$DATE.tgz"
docker run --rm -v wordpress_wp_data:/src -v "$DIR":/dst alpine tar czf /dst/backup-wp-files-$DATE.tgz -C /src .
echo "[3/3] listing:"
ls -lh "$DIR"/backup-wp-*
echo "done. to restore DB: cat backup-wp-DATE.sql | docker exec -i wp-db mysql -u\"\$WP_DB_USER\" -p\"\$WP_DB_PASSWORD\" \"\$WP_DB_NAME\""
