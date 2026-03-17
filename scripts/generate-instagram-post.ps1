Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$outputDir = Join-Path $root "social"
$outputPath = Join-Path $outputDir "instagram-lanzamiento-web.png"
$logoPath = Join-Path $root "images\\logo.png"

if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$width = 1080
$height = 1350

$bitmap = New-Object System.Drawing.Bitmap $width, $height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

try {
    $backgroundRect = New-Object System.Drawing.Rectangle 0, 0, $width, $height
    $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        $backgroundRect,
        [System.Drawing.Color]::FromArgb(255, 4, 10, 22),
        [System.Drawing.Color]::FromArgb(255, 0, 0, 0),
        90
    )
    $graphics.FillRectangle($bgBrush, $backgroundRect)
    $bgBrush.Dispose()

    $graphics.FillEllipse((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(80, 59, 130, 246))), -80, -40, 520, 520)
    $graphics.FillEllipse((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(45, 249, 115, 22))), 620, 960, 380, 380)
    $graphics.FillEllipse((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(20, 255, 255, 255))), 760, 120, 160, 160)

    $borderPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(60, 147, 197, 253)), 2
    $graphics.DrawRectangle($borderPen, 38, 38, $width - 76, $height - 76)
    $borderPen.Dispose()

    if (Test-Path $logoPath) {
        $logo = [System.Drawing.Image]::FromFile($logoPath)
        $graphics.DrawImage($logo, 86, 92, 170, 170)
        $logo.Dispose()
    }

    $pillRect = New-Object System.Drawing.RectangleF 86, 300, 500, 56
    $pillBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(42, 147, 197, 253))
    $pillPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(90, 147, 197, 253)), 1.5
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $radius = 26
    $diameter = $radius * 2
    $x = [int]$pillRect.X
    $y = [int]$pillRect.Y
    $w = [int]$pillRect.Width
    $h = [int]$pillRect.Height
    $path.AddArc($x, $y, $diameter, $diameter, 180, 90)
    $path.AddArc($x + $w - $diameter, $y, $diameter, $diameter, 270, 90)
    $path.AddArc($x + $w - $diameter, $y + $h - $diameter, $diameter, $diameter, 0, 90)
    $path.AddArc($x, $y + $h - $diameter, $diameter, $diameter, 90, 90)
    $path.CloseFigure()
    $graphics.FillPath($pillBrush, $path)
    $graphics.DrawPath($pillPen, $path)
    $pillBrush.Dispose()
    $pillPen.Dispose()
    $path.Dispose()

    $brandFont = New-Object System.Drawing.Font("Segoe UI Semibold", 22, [System.Drawing.FontStyle]::Regular)
    $headlineFont = New-Object System.Drawing.Font("Segoe UI", 78, [System.Drawing.FontStyle]::Bold)
    $subFont = New-Object System.Drawing.Font("Segoe UI", 28, [System.Drawing.FontStyle]::Regular)
    $ctaFont = New-Object System.Drawing.Font("Segoe UI Semibold", 24, [System.Drawing.FontStyle]::Regular)
    $footerFont = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Regular)

    $whiteBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(245, 248, 255))
    $blueBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(193, 220, 255))
    $mutedBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(205, 214, 228))
    $accentBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(249, 115, 22))

    $graphics.DrawString("NUEVO LANZAMIENTO", $brandFont, $blueBrush, 110, 311)

    $headlineRect = New-Object System.Drawing.RectangleF 86, 410, 910, 360
    $headlineFormat = New-Object System.Drawing.StringFormat
    $headlineFormat.Alignment = [System.Drawing.StringAlignment]::Near
    $headlineFormat.LineAlignment = [System.Drawing.StringAlignment]::Near
    $graphics.DrawString("Ya tenemos`npagina web", $headlineFont, $whiteBrush, $headlineRect, $headlineFormat)
    $headlineFormat.Dispose()

    $subRect = New-Object System.Drawing.RectangleF 92, 820, 860, 170
    $subText = "Ahora puedes conocer nuestros servicios, ver lo que hacemos y escribirnos de forma directa."
    $graphics.DrawString($subText, $subFont, $mutedBrush, $subRect)

    $graphics.FillRectangle((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(28, 255, 255, 255))), 86, 1040, 908, 116)
    $graphics.FillRectangle((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 249, 115, 22))), 86, 1040, 12, 116)
    $graphics.DrawString("Descúbrela y conversemos sobre tu proyecto", $ctaFont, $whiteBrush, 126, 1078)

    $graphics.DrawString("Nexus Digital", $footerFont, $blueBrush, 86, 1218)
    $graphics.DrawString("Desarrollo web, software y automatización", $footerFont, $mutedBrush, 86, 1254)

    $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
}
finally {
    $graphics.Dispose()
    $bitmap.Dispose()
}

Write-Output $outputPath
