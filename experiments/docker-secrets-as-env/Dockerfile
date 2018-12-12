FROM alpine

COPY docker-secrets-to-env-var.sh /
COPY entrypoint.sh /

RUN chmod +x docker-secrets-to-env-var.sh entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
