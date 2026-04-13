# Stage 1 - budowanie aplikacji
FROM alpine:3.19 AS builder

ARG VERSION=1.0.0

RUN apk add --no-cache bash
WORKDIR /build
COPY generate_page.sh .
RUN VERSION=${VERSION} sh generate_page.sh > /build/index.html

# Stage 2 - serwer HTTP
FROM nginx:alpine

COPY --from=builder /build/index.html /usr/share/nginx/html/index.html

EXPOSE 80

# Weryfikacja działania aplikacji
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
