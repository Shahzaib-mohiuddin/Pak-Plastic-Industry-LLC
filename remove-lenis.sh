#!/bin/bash

echo "Removing Lenis smooth scroll from all HTML files..."

# Find all HTML files and remove Lenis script tag
find /Users/eapple/Desktop/Pak_Plastic_Industry -name "*.html" -type f | while read file; do
    # Remove the Lenis script line
    sed -i '' '/<script src="https:\/\/unpkg\.com\/lenis@1\.1\.18\/dist\/lenis\.min\.js"/d' "$file"
    echo "✓ Processed: $(basename "$file")"
done

echo ""
echo "========================================="
echo "Lenis script removed from all HTML files"
echo "========================================="
