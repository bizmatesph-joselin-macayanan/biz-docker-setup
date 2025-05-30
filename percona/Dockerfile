FROM --platform=linux/amd64 percona:ps-8.0.40-31

USER root

# Enable Percona repositories
RUN percona-release enable-only tools release \
    && percona-release enable pxb-80

# Install dependencies
RUN curl -Lf -o /tmp/libev.rpm https://downloads.percona.com/downloads/packaging/libev-4.33-5.el9.x86_64.rpm \
    && rpm -i /tmp/libev.rpm \
    && microdnf install -y percona-xtrabackup-80 qpress zstd

# Copy the restore script and set permissions
COPY ./restore-backup.sh /
RUN chmod +x /restore-backup.sh

# Create necessary directories
RUN mkdir -p /var/backup /var/lib/mysql \
    && chown -R mysql:mysql /var/backup /var/lib/mysql

USER mysql
