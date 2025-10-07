# ===================================================
# PowerShell Script: One-Click Install TailwindCSS v4.x (for Vite + React)
# ===================================================

Write-Host "🌿 Starting TailwindCSS v4 installation..." -ForegroundColor Cyan

# -----------------------------
# 1️⃣ Verify project folder
# -----------------------------
$projectPath = Get-Location
if (-Not (Test-Path "$projectPath\package.json")) {
    Write-Host "❌ package.json not found! Please run this script inside your Vite + React project folder."
    exit
}

# -----------------------------
# 2️⃣ Install TailwindCSS + PostCSS + Autoprefixer
# -----------------------------
Write-Host "📦 Installing TailwindCSS, PostCSS and Autoprefixer..."
pnpm add -D tailwindcss postcss autoprefixer

# -----------------------------
# 3️⃣ Create tailwind.config.js
# -----------------------------
Write-Host "🛠️ Creating tailwind.config.js..."
@"
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@ | Out-File -Encoding utf8 "$projectPath\tailwind.config.js"

# -----------------------------
# 4️⃣ Create postcss.config.js
# -----------------------------
Write-Host "🧩 Creating postcss.config.js..."
@"
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
"@ | Out-File -Encoding utf8 "$projectPath\postcss.config.js"

# -----------------------------
# 5️⃣ Create src/index.css
# -----------------------------
Write-Host "🎨 Creating src/index.css..."
$srcPath = "$projectPath\src"
if (-Not (Test-Path $srcPath)) {
    New-Item -ItemType Directory -Path $srcPath | Out-Null
}
@"
@tailwind base;
@tailwind components;
@tailwind utilities;
"@ | Out-File -Encoding utf8 "$srcPath\index.css"

# -----------------------------
# 6️⃣ Add import './index.css' to main.jsx
# -----------------------------
$mainFile = "$srcPath\main.jsx"
if (Test-Path $mainFile) {
    $content = Get-Content $mainFile
    if (-not ($content -match "import './index.css'")) {
        Write-Host "🧷 Injecting import './index.css' into main.jsx..."
        $newContent = @("import './index.css';") + $content
        $newContent | Set-Content -Encoding utf8 $mainFile
    }
} else {
    Write-Host "⚠️ src/main.jsx not found, skipping import injection."
}

# -----------------------------
# 7️⃣ Done
# -----------------------------
Write-Host "`n✅ TailwindCSS v4 setup completed successfully!"
Write-Host "👉 You can now start your app with: pnpm run dev" -ForegroundColor Green
