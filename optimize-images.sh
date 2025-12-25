#!/bin/bash

# Image Optimization Script for Pak Plastic Industry Website
# This script converts images to WebP format and compresses them for faster loading
# 
# Prerequisites:
# - Install cwebp: brew install webp (macOS) or apt-get install webp (Linux)
# - Install ImageMagick: brew install imagemagick (macOS) or apt-get install imagemagick (Linux)
#
# Usage: ./optimize-images.sh

IMAGES_DIR="./images"
OUTPUT_DIR="./images/optimized"
QUALITY=80

echo "🖼️  Image Optimization Script for Pak Plastic Industry"
echo "======================================================="
echo ""

# Check if cwebp is installed
if ! command -v cwebp &> /dev/null; then
    echo "❌ cwebp is not installed. Install it with:"
    echo "   macOS: brew install webp"
    echo "   Linux: apt-get install webp"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "📁 Processing images from: $IMAGES_DIR"
echo "📁 Output directory: $OUTPUT_DIR"
echo "🎯 Quality setting: $QUALITY%"
echo ""

# Counter for processed files
processed=0
saved_bytes=0

# Process PNG files
echo "🔄 Converting PNG files to WebP..."
for file in "$IMAGES_DIR"/*.png "$IMAGES_DIR"/*.PNG; do
    if [ -f "$file" ]; then
        filename=$(basename "$file" | sed 's/\.[pP][nN][gG]$//')
        original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        
        # Convert to WebP
        cwebp -q $QUALITY "$file" -o "$OUTPUT_DIR/${filename}.webp" 2>/dev/null
        
        if [ -f "$OUTPUT_DIR/${filename}.webp" ]; then
            new_size=$(stat -f%z "$OUTPUT_DIR/${filename}.webp" 2>/dev/null || stat -c%s "$OUTPUT_DIR/${filename}.webp" 2>/dev/null)
            savings=$((original_size - new_size))
            saved_bytes=$((saved_bytes + savings))
            
            # Convert to human readable
            orig_kb=$((original_size / 1024))
            new_kb=$((new_size / 1024))
            
            echo "  ✅ ${filename}.png: ${orig_kb}KB → ${new_kb}KB"
            ((processed++))
        fi
    fi
done

# Process JPG/JPEG files
echo ""
echo "🔄 Converting JPG/JPEG files to WebP..."
for file in "$IMAGES_DIR"/*.jpg "$IMAGES_DIR"/*.jpeg "$IMAGES_DIR"/*.JPG "$IMAGES_DIR"/*.JPEG; do
    if [ -f "$file" ]; then
        filename=$(basename "$file" | sed 's/\.[jJ][pP][eE]*[gG]$//')
        original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        
        # Convert to WebP
        cwebp -q $QUALITY "$file" -o "$OUTPUT_DIR/${filename}.webp" 2>/dev/null
        
        if [ -f "$OUTPUT_DIR/${filename}.webp" ]; then
            new_size=$(stat -f%z "$OUTPUT_DIR/${filename}.webp" 2>/dev/null || stat -c%s "$OUTPUT_DIR/${filename}.webp" 2>/dev/null)
            savings=$((original_size - new_size))
            saved_bytes=$((saved_bytes + savings))
            
            # Convert to human readable
            orig_kb=$((original_size / 1024))
            new_kb=$((new_size / 1024))
            
            echo "  ✅ $(basename $file): ${orig_kb}KB → ${new_kb}KB"
            ((processed++))
        fi
    fi
done

# Summary
echo ""
echo "======================================================="
echo "📊 Optimization Complete!"
echo "   Files processed: $processed"
saved_mb=$((saved_bytes / 1024 / 1024))
saved_kb=$((saved_bytes / 1024))
if [ $saved_mb -gt 0 ]; then
    echo "   Total space saved: ${saved_mb}MB"
else
    echo "   Total space saved: ${saved_kb}KB"
fi
echo ""
echo "📝 Next Steps:"
echo "   1. Review optimized images in: $OUTPUT_DIR"
echo "   2. Replace original images with optimized versions"
echo "   3. Update HTML files to use .webp extension"
echo "   4. Use <picture> element for browser fallback support"
echo ""
echo "💡 Example HTML with fallback:"
echo '   <picture>'
echo '     <source srcset="images/optimized/image.webp" type="image/webp">'
echo '     <img src="images/image.png" alt="Description" loading="lazy">'
echo '   </picture>'
echo ""
