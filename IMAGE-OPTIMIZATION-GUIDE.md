# Image Optimization Guide
## Explicit Dimensions, Lazy Loading, and Async Decoding

---

## 🎯 Why Image Optimization Matters

**Performance Impact:**
- Prevents layout shifts (CLS - Cumulative Layout Shift)
- Reduces initial page load time
- Improves perceived performance
- Enables browser to optimize rendering pipeline

---

## ✅ Required Image Attributes

### **1. Width and Height**
Always specify explicit dimensions to prevent layout shifts:

```html
<!-- ❌ BEFORE: No dimensions -->
<img src="product.jpg" alt="Product">

<!-- ✅ AFTER: With explicit dimensions -->
<img src="product.jpg" 
     alt="Product"
     width="800"
     height="600">
```

### **2. Loading="lazy"**
Defers loading of off-screen images:

```html
<img src="product.jpg" 
     alt="Product"
     width="800"
     height="600"
     loading="lazy">
```

**Note:** Don't use `loading="lazy"` on hero images or above-the-fold content!

### **3. Decoding="async"**
Allows browser to decode images off the main thread:

```html
<img src="product.jpg" 
     alt="Product"
     width="800"
     height="600"
     loading="lazy"
     decoding="async">
```

---

## 📋 Complete Image Optimization Template

```html
<!-- For images below the fold -->
<img src="path/to/image.jpg" 
     alt="Descriptive alt text"
     width="800"
     height="600"
     loading="lazy"
     decoding="async">

<!-- For hero/above-the-fold images -->
<img src="path/to/hero.jpg" 
     alt="Descriptive alt text"
     width="1920"
     height="1080"
     decoding="async">
```

---

## 🔍 Images to Optimize in Your Website

### **Priority 1: Hero Images**
```html
<!-- Home page hero -->
<img src="images/home-hero-banner.webp" 
     alt="Pak Plastic Industry Hero"
     width="1920"
     height="1080"
     decoding="async">
```

### **Priority 2: Product Images**
All product images in carousels and cards:
```html
<img src="images/products/pallet.jpg" 
     alt="Plastic Pallet"
     width="400"
     height="400"
     loading="lazy"
     decoding="async">
```

### **Priority 3: Industry Cards**
All industry showcase images:
```html
<img src="images/industries/automotive.jpg" 
     alt="Automotive Industry"
     width="600"
     height="400"
     loading="lazy"
     decoding="async">
```

### **Priority 4: Logo**
```html
<img src="images/logo.png" 
     alt="Pak Plastic Industry Logo"
     width="400"
     height="350"
     class="nav-logo-img">
```

---

## 🛠️ How to Find Actual Image Dimensions

### **Method 1: Using Browser DevTools**
1. Right-click on image → Inspect
2. Look at the "Rendered" dimensions in the inspector
3. Use those dimensions in your HTML

### **Method 2: Using Command Line (Mac/Linux)**
```bash
# Get image dimensions
file images/product.jpg

# Or use sips (Mac only)
sips -g pixelWidth -g pixelHeight images/product.jpg
```

### **Method 3: Using Image Editor**
Open image in Preview, Photoshop, or any image editor to see dimensions.

---

## 📊 Performance Impact

### **Before Optimization:**
- Layout shifts as images load
- Slower perceived performance
- Browser blocks rendering waiting for image dimensions

### **After Optimization:**
- ✅ Zero layout shifts
- ✅ Faster initial render
- ✅ Images load only when needed
- ✅ Smooth 60fps scrolling maintained

---

## 🚀 Implementation Checklist

- [ ] Add width/height to all `<img>` tags
- [ ] Add `loading="lazy"` to below-the-fold images
- [ ] Add `decoding="async"` to all images
- [ ] Keep hero images without `loading="lazy"`
- [ ] Test on mobile and desktop
- [ ] Verify no layout shifts using Chrome DevTools

---

## 📝 Example: Complete Product Card

```html
<div class="product-card-nexgen">
    <div class="product-image-nexgen">
        <img src="images/products/plastic-pallet-1200x800.jpg" 
             alt="Heavy Duty Plastic Pallet"
             width="1200"
             height="800"
             loading="lazy"
             decoding="async">
    </div>
    <div class="product-info-nexgen">
        <h3>Heavy Duty Plastic Pallet</h3>
        <p>Industrial grade plastic pallets for warehouse use</p>
    </div>
</div>
```

---

## ⚠️ Common Mistakes to Avoid

1. **Don't use `loading="lazy"` on hero images** - They should load immediately
2. **Don't use incorrect dimensions** - Use actual image dimensions
3. **Don't forget alt text** - Important for accessibility and SEO
4. **Don't use inline styles for dimensions** - Use HTML attributes instead

---

## 🎨 Responsive Images (Advanced)

For different screen sizes, use `srcset`:

```html
<img src="image-800.jpg"
     srcset="image-400.jpg 400w,
             image-800.jpg 800w,
             image-1200.jpg 1200w"
     sizes="(max-width: 600px) 400px,
            (max-width: 1200px) 800px,
            1200px"
     alt="Responsive Image"
     width="1200"
     height="800"
     loading="lazy"
     decoding="async">
```

---

Generated: March 5, 2026
