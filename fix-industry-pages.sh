#!/bin/bash

# Script to fix scroll lag on all industry pages by optimizing inline CSS

INDUSTRY_DIR="/Users/eapple/Desktop/Pak_Plastic_Industry/industries"

# Array of industry page files
PAGES=(
    "automotive-industry.html"
    "food-processing-industry.html"
    "logistics-e-commerce-industry.html"
    "petro-chemical-industry.html"
    "pharmaceuticals.html"
    "retail-industry.html"
    "waste-management.html"
)

echo "🚀 Optimizing industry pages for smooth scrolling..."

for page in "${PAGES[@]}"; do
    FILE="$INDUSTRY_DIR/$page"
    
    if [ -f "$FILE" ]; then
        echo "  ✓ Optimizing $page"
        
        # Replace transition: all with GPU-accelerated transitions
        sed -i '' 's/transition: all 0\.3s ease;/transform: translateZ(0);\
            backface-visibility: hidden;\
            transition: transform 300ms cubic-bezier(0.16, 1, 0.3, 1),\
                        background-color 300ms cubic-bezier(0.16, 1, 0.3, 1);/g' "$FILE"
        
        # Fix transform properties to include translateZ(0)
        sed -i '' 's/transform: translateX(\([^)]*\));/transform: translateX(\1) translateZ(0);/g' "$FILE"
        sed -i '' 's/transform: translateY(\([^)]*\));/transform: translateY(\1) translateZ(0);/g' "$FILE"
        
        # Fix transition: transform to use premium easing
        sed -i '' 's/transition: transform 0\.3s ease;/transform: translateZ(0);\
            transition: transform 300ms cubic-bezier(0.16, 1, 0.3, 1);/g' "$FILE"
        
        # Fix transition: color
        sed -i '' 's/transition: color 0\.3s ease;/transition: color 150ms cubic-bezier(0.16, 1, 0.3, 1);/g' "$FILE"
        
    else
        echo "  ✗ File not found: $page"
    fi
done

echo "✅ All industry pages optimized!"
