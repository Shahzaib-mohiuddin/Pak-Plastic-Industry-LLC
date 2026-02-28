#!/bin/bash

# Minify CSS and JavaScript files using online tools or basic compression

echo "🔧 Minifying CSS and JavaScript..."
echo ""

# Simple CSS minification (remove comments, extra whitespace, newlines)
echo "Minifying styles.css..."
cat styles.css | \
  sed 's|/\*[^*]*\*\+\([^/*][^*]*\*\+\)*/||g' | \
  tr -s '\n' ' ' | \
  sed 's/  */ /g' | \
  sed 's/ *{ */{/g' | \
  sed 's/ *} */}/g' | \
  sed 's/ *: */:/g' | \
  sed 's/ *; */;/g' | \
  sed 's/ *, */,/g' | \
  sed 's/; *}/}/g' > styles.min.css

# Simple JS minification (remove comments and extra whitespace)
echo "Minifying script.js..."
cat script.js | \
  sed 's|//.*$||g' | \
  sed 's|/\*[^*]*\*\+\([^/*][^*]*\*\+\)*/||g' | \
  tr -s '\n' ' ' | \
  sed 's/  */ /g' > script.min.js

# Get file sizes
ORIGINAL_CSS=$(stat -f%z styles.css 2>/dev/null || stat -c%s styles.css)
MINIFIED_CSS=$(stat -f%z styles.min.css 2>/dev/null || stat -c%s styles.min.css)
ORIGINAL_JS=$(stat -f%z script.js 2>/dev/null || stat -c%s script.js)
MINIFIED_JS=$(stat -f%z script.min.js 2>/dev/null || stat -c%s script.min.js)

CSS_SAVED=$((ORIGINAL_CSS - MINIFIED_CSS))
JS_SAVED=$((ORIGINAL_JS - MINIFIED_JS))
TOTAL_SAVED=$((CSS_SAVED + JS_SAVED))

echo ""
echo "✅ Minification Complete!"
echo ""
echo "📊 Results:"
echo "CSS: $(numfmt --to=iec-i --suffix=B $ORIGINAL_CSS 2>/dev/null || echo "${ORIGINAL_CSS} bytes") → $(numfmt --to=iec-i --suffix=B $MINIFIED_CSS 2>/dev/null || echo "${MINIFIED_CSS} bytes") (saved $(numfmt --to=iec-i --suffix=B $CSS_SAVED 2>/dev/null || echo "${CSS_SAVED} bytes"))"
echo "JS:  $(numfmt --to=iec-i --suffix=B $ORIGINAL_JS 2>/dev/null || echo "${ORIGINAL_JS} bytes") → $(numfmt --to=iec-i --suffix=B $MINIFIED_JS 2>/dev/null || echo "${MINIFIED_JS} bytes") (saved $(numfmt --to=iec-i --suffix=B $JS_SAVED 2>/dev/null || echo "${JS_SAVED} bytes"))"
echo "Total saved: $(numfmt --to=iec-i --suffix=B $TOTAL_SAVED 2>/dev/null || echo "${TOTAL_SAVED} bytes")"
echo ""
echo "Next step: Update HTML files to use .min.css and .min.js"
