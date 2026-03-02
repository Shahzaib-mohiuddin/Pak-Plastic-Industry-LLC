#!/bin/bash

# Advanced Image Optimization Script for PageSpeed Performance
# This script creates responsive image versions and optimizes compression

echo "🚀 Starting Advanced Image Optimization..."

# Check if required tools are installed
command -v cwebp >/dev/null 2>&1 || { echo "❌ cwebp is required but not installed. Install with: brew install webp"; exit 1; }

# Create responsive images directory
mkdir -p images/responsive

# Function to create responsive versions
create_responsive_images() {
    local input_file=$1
    local output_base=$2
    local quality=${3:-75}
    
    echo "Processing: $input_file"
    
    # Create different sizes for responsive images
    # Small (420x280 for industry banners)
    cwebp -q $quality -resize 420 0 "$input_file" -o "${output_base}-420w.webp"
    
    # Medium (840x560 for 2x displays)
    cwebp -q $quality -resize 840 0 "$input_file" -o "${output_base}-840w.webp"
    
    # Original size with better compression
    cwebp -q $quality "$input_file" -o "${output_base}-original.webp"
}

# Optimize industry banner images (these are the largest)
echo "📸 Optimizing industry banners..."
for img in images/industry-banners-v2/*.webp; do
    if [ -f "$img" ]; then
        filename=$(basename "$img" .webp)
        create_responsive_images "$img" "images/responsive/industry-v2-$filename" 75
    fi
done

for img in images/industry-banners-v3/*.webp; do
    if [ -f "$img" ]; then
        filename=$(basename "$img" .webp)
        create_responsive_images "$img" "images/responsive/industry-v3-$filename" 75
    fi
done

# Optimize homepage product images
echo "📦 Optimizing product images..."
for img in images/homepage-products/*.webp; do
    if [ -f "$img" ]; then
        filename=$(basename "$img" .webp)
        # Products need smaller sizes (229x229)
        cwebp -q 80 -resize 229 0 "$img" -o "images/responsive/product-$filename-229w.webp"
        cwebp -q 80 -resize 458 0 "$img" -o "images/responsive/product-$filename-458w.webp"
    fi
done

# Optimize background images
echo "🖼️  Optimizing background images..."
if [ -f "images/leaf-wallpaper-bg.webp" ]; then
    # Create desktop and mobile versions
    cwebp -q 70 -resize 1920 0 "images/leaf-wallpaper-bg.webp" -o "images/responsive/leaf-bg-1920w.webp"
    cwebp -q 70 -resize 1280 0 "images/leaf-wallpaper-bg.webp" -o "images/responsive/leaf-bg-1280w.webp"
    cwebp -q 70 -resize 768 0 "images/leaf-wallpaper-bg.webp" -o "images/responsive/leaf-bg-768w.webp"
fi

if [ -f "images/home-hero-banner.webp" ]; then
    # Hero needs multiple sizes
    cwebp -q 75 -resize 1920 0 "images/home-hero-banner.webp" -o "images/responsive/hero-1920w.webp"
    cwebp -q 75 -resize 1280 0 "images/home-hero-banner.webp" -o "images/responsive/hero-1280w.webp"
    cwebp -q 75 -resize 768 0 "images/home-hero-banner.webp" -o "images/responsive/hero-768w.webp"
fi

# Optimize logo
echo "🏢 Optimizing logo..."
if [ -f "images/nexgen-logo.webp" ]; then
    cwebp -q 85 -resize 400 0 "images/nexgen-logo.webp" -o "images/responsive/logo-400w.webp"
    cwebp -q 85 -resize 200 0 "images/nexgen-logo.webp" -o "images/responsive/logo-200w.webp"
fi

echo "✅ Image optimization complete!"
echo "📊 Responsive images created in images/responsive/"
echo ""
echo "Next steps:"
echo "1. Update HTML to use responsive images with srcset"
echo "2. Test on different screen sizes"
echo "3. Verify PageSpeed Insights improvements"
