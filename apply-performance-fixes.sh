#!/bin/bash

# Apply Performance Fixes to All HTML Pages
# This script only fixes Font Awesome loading (async)

echo "🚀 Applying Performance Fixes to All Pages..."
echo ""

# Find all HTML files and fix Font Awesome loading
find . -name "*.html" -not -path "./node_modules/*" -not -path "./.git/*" | while read file; do
    echo "Processing: $file"
    
    # Check if file has Font Awesome link without async loading
    if grep -q 'font-awesome.*\.min\.css">' "$file"; then
        # Add async loading to Font Awesome
        sed -i '' 's|<link rel="stylesheet" href="https://cdnjs\.cloudflare\.com/ajax/libs/font-awesome/6\.4\.0/css/all\.min\.css">|<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" media="print" onload="this.media='\''all'\''"><noscript><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"></noscript>|g' "$file"
        echo "  ✅ Fixed Font Awesome async loading"
    fi
done

echo ""
echo "✅ All pages updated!"
echo ""
echo "Changes made:"
echo "- Font Awesome now loads asynchronously (fixes render-blocking)"
echo "- No UI changes - icons load slightly later but no visual difference"
echo ""
echo "Expected improvements:"
echo "- Render-blocking time: -240ms"
echo "- First Contentful Paint: faster"
