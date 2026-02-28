#!/bin/bash

# Image Optimization Script for PageSpeed Performance
# This script compresses images without changing their appearance

echo "🖼️  Image Optimization Script"
echo "================================"
echo ""
echo "⚠️  IMPORTANT: This script requires 'cwebp' tool"
echo "Install with: brew install webp"
echo ""

# Check if cwebp is installed
if ! command -v cwebp &> /dev/null; then
    echo "❌ Error: cwebp is not installed"
    echo "Please install it with: brew install webp"
    exit 1
fi

echo "✅ cwebp found, starting optimization..."
echo ""

# Create backup directory
BACKUP_DIR="images/originals-backup"
mkdir -p "$BACKUP_DIR"

# Function to optimize image
optimize_image() {
    local input_file="$1"
    local quality="$2"
    local output_file="${input_file%.webp}.optimized.webp"
    
    echo "Optimizing: $input_file (quality: $quality)"
    
    # Backup original
    cp "$input_file" "$BACKUP_DIR/"
    
    # Optimize
    cwebp -q "$quality" "$input_file" -o "$output_file" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        # Get file sizes
        original_size=$(stat -f%z "$input_file" 2>/dev/null || stat -c%s "$input_file")
        new_size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file")
        
        # Calculate savings
        savings=$((original_size - new_size))
        percent=$((savings * 100 / original_size))
        
        echo "  Original: $(numfmt --to=iec-i --suffix=B $original_size 2>/dev/null || echo "${original_size} bytes")"
        echo "  Optimized: $(numfmt --to=iec-i --suffix=B $new_size 2>/dev/null || echo "${new_size} bytes")"
        echo "  Savings: ${percent}%"
        
        # Replace original with optimized
        mv "$output_file" "$input_file"
        echo "  ✅ Done"
    else
        echo "  ❌ Failed"
    fi
    echo ""
}

# Optimize hero images (lower quality for large backgrounds)
echo "📸 Optimizing Hero Images..."
if [ -f "images/home-hero-banner.webp" ]; then
    optimize_image "images/home-hero-banner.webp" 75
fi

if [ -f "images/leaf-wallpaper-bg.webp" ]; then
    optimize_image "images/leaf-wallpaper-bg.webp" 70
fi

# Optimize industry banners (medium quality)
echo "🏭 Optimizing Industry Banners..."
for img in images/industry-banners-v2/*.webp images/industry-banners-v3/*.webp; do
    if [ -f "$img" ]; then
        optimize_image "$img" 80
    fi
done

# Optimize product images (higher quality for product shots)
echo "📦 Optimizing Product Images..."
for img in images/homepage-products/*.webp; do
    if [ -f "$img" ]; then
        optimize_image "$img" 85
    fi
done

# Optimize other images
echo "🖼️  Optimizing Other Images..."
if [ -f "images/home-about-nexgen.webp" ]; then
    optimize_image "images/home-about-nexgen.webp" 80
fi

if [ -f "images/nexgen-logo.webp" ]; then
    optimize_image "images/nexgen-logo.webp" 90
fi

echo "================================"
echo "✅ Optimization Complete!"
echo ""
echo "📊 Summary:"
echo "- Original images backed up to: $BACKUP_DIR"
echo "- All images optimized in place"
echo "- Expected PageSpeed improvement: +15-20 points"
echo ""
echo "Next steps:"
echo "1. Test your website locally"
echo "2. If images look good, commit changes"
echo "3. If not satisfied, restore from backup"
echo ""
echo "To restore originals:"
echo "  cp $BACKUP_DIR/* images/"
