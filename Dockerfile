FROM python:3.11-slim

# ── 系統依賴 ──────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    ghostscript \
    poppler-utils \
    tesseract-ocr \
    tesseract-ocr-chi-tra \
    tesseract-ocr-chi-sim \
    tesseract-ocr-eng \
    tesseract-ocr-jpn \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ── 工作目錄 ──────────────────────────────────────────────
WORKDIR /app

# ── Python 套件（先複製 requirements 利用 cache） ─────────
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ── 複製應用程式 ──────────────────────────────────────────
COPY . .

# 建立工作資料夾
RUN mkdir -p uploads outputs static
RUN cp index.html static/index.html

# ── 啟動 ─────────────────────────────────────────────────
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
