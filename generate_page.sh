#!/bin/sh
# Generuje stronę HTML z dynamicznymi danymi serwera

SERVER_IP=$(hostname -i 2>/dev/null || ip route get 1 | awk '{print $7; exit}' 2>/dev/null || echo "nieznany")
SERVER_HOST=$(hostname)
APP_VERSION=${VERSION:-"1.0.0"}

cat <<EOF
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informacje o serwerze</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e0e0e0;
        }
        .card {
            background: rgba(255,255,255,0.07);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 16px;
            padding: 48px 56px;
            max-width: 520px;
            width: 90%;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.4);
        }
        .logo {
            font-size: 48px;
            text-align: center;
            margin-bottom: 8px;
        }
        h1 {
            font-size: 1.6rem;
            text-align: center;
            color: #ffffff;
            margin-bottom: 32px;
            font-weight: 300;
            letter-spacing: 1px;
        }
        .info-row {
            display: flex;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }
        .info-row:last-child { border-bottom: none; }
        .label {
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: #90caf9;
            width: 140px;
            flex-shrink: 0;
        }
        .value {
            font-size: 1.05rem;
            color: #ffffff;
            font-family: 'Courier New', monospace;
            word-break: break-all;
        }
        .badge {
            display: inline-block;
            background: rgba(33,150,243,0.25);
            border: 1px solid rgba(33,150,243,0.5);
            border-radius: 20px;
            padding: 3px 12px;
            font-size: 0.85rem;
            color: #90caf9;
        }
        .footer {
            text-align: center;
            margin-top: 28px;
            font-size: 0.75rem;
            color: rgba(255,255,255,0.3);
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="logo">🐳</div>
        <h1>Informacje o serwerze</h1>

        <div class="info-row">
            <span class="label">Adres IP</span>
            <span class="value">${SERVER_IP}</span>
        </div>
        <div class="info-row">
            <span class="label">Hostname</span>
            <span class="value">${SERVER_HOST}</span>
        </div>
        <div class="info-row">
            <span class="label">Wersja aplikacji</span>
            <span class="value"><span class="badge">v${APP_VERSION}</span></span>
        </div>

        <div class="footer"> Laboratorium 5 &nbsp;|&nbsp; Docker Multi-Stage Build</div>
    </div>
</body>
</html>
EOF
