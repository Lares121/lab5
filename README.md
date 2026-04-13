# Lab5 - Wieloetapowe budowanie obrazów Docker

## Pliki
- `Dockerfile` - definicja obrazu (2 etapy)
- `generate_page.sh` - skrypt generujący stronę HTML

## Instrukcja

### 1. Budowanie obrazu
```bash
docker build --build-arg VERSION=2.0.0 -t lab5:v2.0.0 .
```

### 2. Uruchomienie kontenera
```bash
docker run -d --name lab5 -p 8080:80 lab5:v2.0.0
```

### 3. Weryfikacja działania
```bash
# Status kontenera (sprawdź czy HEALTHCHECK pokazuje "healthy")
docker ps

# Test przez curl
curl http://localhost:8080
```

### 4. Zatrzymanie i usunięcie kontenera
```bash
docker stop lab5
docker rm lab5
```
