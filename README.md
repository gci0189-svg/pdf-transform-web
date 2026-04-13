# DocFlow — 文件轉換平台

支援 PDF↔Word、PDF→PPT、PDF→Excel、圖片轉換、PDF 壓縮/合併/分割、OCR 辨識。

---

## 🚀 部署到 Railway（5 分鐘完成）

### 步驟一：上傳到 GitHub

```bash
# 在本機建立 repo
git init
git add .
git commit -m "init: DocFlow converter"

# 推送到 GitHub（先在 github.com 建立新 repo）
git remote add origin https://github.com/你的帳號/docflow.git
git push -u origin main
```

### 步驟二：Railway 部署

1. 前往 [railway.app](https://railway.app) → 登入 GitHub
2. 點擊 **New Project** → **Deploy from GitHub repo**
3. 選擇剛才建立的 repo
4. Railway 自動偵測 `Dockerfile` 並開始 build（約 5–8 分鐘，因為要裝 libreoffice）
5. Build 完成後點擊 **Settings** → **Networking** → **Generate Domain**
6. 複製產生的網址（例如 `https://docflow-production.up.railway.app`）

### 步驟三：更新前端 API 網址

打開 `index.html`，找到第 3 行：

```javascript
const API_BASE = "http://localhost:8000";
```

改為：

```javascript
const API_BASE = "https://docflow-production.up.railway.app";
```

再 commit 推送，Railway 自動重新部署。

---

## 📁 專案結構

```
docflow/
├── main.py           ← FastAPI 後端（9 個 API）
├── index.html        ← 前端網頁
├── requirements.txt  ← Python 套件
├── Dockerfile        ← 容器設定（含系統套件）
├── railway.toml      ← Railway 部署設定
└── README.md
```

---

## 🔌 API 端點一覽

| 方法 | 路徑 | 功能 |
|------|------|------|
| GET  | `/` | 前端網頁 |
| GET  | `/api/health` | 健康檢查 |
| POST | `/api/convert/pdf-to-word` | PDF → DOCX |
| POST | `/api/convert/word-to-pdf` | DOCX → PDF |
| POST | `/api/convert/pdf-to-ppt` | PDF → PPTX |
| POST | `/api/convert/pdf-to-excel` | PDF → XLSX |
| POST | `/api/convert/image` | 圖片格式轉換 |
| POST | `/api/pdf/compress` | PDF 壓縮 |
| POST | `/api/pdf/merge` | PDF 合併 |
| POST | `/api/pdf/split` | PDF 分割 |
| POST | `/api/convert/ocr` | OCR 文字辨識 |

互動式 API 文件：`https://你的網址/docs`

---

## 💻 本機開發

```bash
# 安裝系統依賴（Ubuntu/Debian）
sudo apt install libreoffice ghostscript poppler-utils \
    tesseract-ocr tesseract-ocr-chi-tra tesseract-ocr-chi-sim

# 安裝 Python 套件
pip install -r requirements.txt

# 啟動（自動 reload）
uvicorn main:app --reload --port 8000
```

---

## ⚠️ Railway 免費額度說明

- 每月 $5 美金用量（約 500 小時執行時間）
- 超過後服務暫停直到下個月
- 升級 Pro 方案可取得更多資源
- 建議設定 **Sleep on Inactivity**（閒置自動休眠省用量）
