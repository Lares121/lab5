# Sprawozdanie – Laboratorium 5
## Wieloetapowe budowanie obrazów Docker

---

## Treść pliku Dockerfile

```dockerfile
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
```

---

## Budowanie obrazu

```
docker build --build-arg VERSION=2.0.0 -t lab5:v2.0.0 .
```

```
[+] Building 6.4s (15/15) FINISHED                                                                 docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                               0.1s
 => [internal] load metadata for docker.io/library/alpine:3.19                                                     2.0s
 => [internal] load metadata for docker.io/library/nginx:alpine                                                    2.0s
 => [builder 1/5] FROM docker.io/library/alpine:3.19                                                              0.9s
 => [builder 2/5] RUN apk add --no-cache bash                                                                      1.6s
 => [builder 3/5] WORKDIR /build                                                                                   0.2s
 => [builder 4/5] COPY generate_page.sh .                                                                          0.1s
 => [builder 5/5] RUN VERSION=2.0.0 sh generate_page.sh > /build/index.html                                        0.4s
 => [stage-1 2/2] COPY --from=builder /build/index.html /usr/share/nginx/html/index.html                           0.1s
 => exporting to image                                                                                             0.5s
 => => naming to docker.io/library/lab5:v2.0.0                                                                     0.0s
```

---

## Uruchomienie kontenera

```
docker run -d --name lab5 -p 8080:80 lab5:v2.0.0
```

```
d4e8d5e1173743068399d8c9d47d301cff36af75d4255e13b0c2e5746f1b2cf7
```

---

## Potwierdzenie działania kontenera

```
docker ps
```

```
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                    PORTS                                     NAMES
d4e8d5e11737   lab5:v2.0.0   "/docker-entrypoint.…"   53 seconds ago   Up 52 seconds (healthy)   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   lab5
```

Status `(healthy)` potwierdza poprawne działanie mechanizmu HEALTHCHECK.

---

## Weryfikacja aplikacji przez curl

```
curl http://localhost:8080
```

```
StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html>
                    <html lang="pl">
                    <head>
                        <meta charset="UTF-8">
                        <title>Informacje o serwerze</title>
                        ...
```

Aplikacja zwraca kod `200 OK` i wyświetla stronę HTML z adresem IP serwera, nazwą hosta oraz wersją aplikacji `v2.0.0`.

---

## Zrzut ekranu – przeglądarka

<!-- Wstaw zrzut ekranu z http://localhost:8080 -->

---

## Zatrzymanie kontenera

```
docker stop lab5
docker rm lab5
```
