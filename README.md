# My Reading Hub 📚

A standalone, pure JavaScript web application for reading Markdown documentation. Fully responsive, mobile-first, and works entirely offline after initial load.

## ✨ Features

- 📖 **Rich Markdown Support** - Full Markdown rendering with code highlighting
- 🔍 **Full-Text Search** - Fuzzy search across all content
- 🌓 **Dark/Light Mode** - Dark theme by default with smooth transitions
- 📱 **Fully Responsive** - Mobile-first design that works on all devices
- ⌨️ **Keyboard Navigation** - Arrow keys to navigate between documents
- 🎨 **Modern UI** - Clean, GitHub-inspired interface
- 📦 **Offline-First** - All assets loaded locally, works without internet
- 📲 **Progressive Web App (PWA)** - Install on mobile/desktop, works offline
- 🎯 **Native Feel** - Standalone app experience with app icons
- 🔄 **Service Worker** - Automatic caching and offline support

## 🚀 Quick Start

### Prerequisites

- Node.js (for generating index)
- Any static file server (or use the provided method)

### Setup

1. **Clone or download the repository**

2. **Generate the content index** (if adding/modifying content):
   ```bash
   node generate-index.js
   ```

3. **Start a local server**:

   Using `npx serve` (recommended):
   ```bash
   npx serve .
   ```

   Using Python:
   ```bash
   python3 -m http.server 8000
   ```

   Using Node.js (http-server):
   ```bash
   npx http-server -p 8000
   ```

4. **Open in browser**:
   Navigate to `http://localhost:3000` (or the port shown by your server)

## 📁 Project Structure

```
my-reading-hub/
├── index.html              # Main HTML file
├── style.css               # Stylesheet with dark/light themes
├── marked.min.js          # Markdown parser
├── highlight.min.js       # Code syntax highlighter
├── highlight.css          # Code highlighting styles
├── generate-index.js      # Index generator script
├── manifest.json          # PWA manifest
├── README.md              # This file
└── content/
    ├── index.json         # Auto-generated index
    ├── java/
    │   ├── 01-intro.md
    │   └── 02-oop.md
    ├── spring-boot/
    │   ├── 01-setup.md
    │   └── 02-rest.md
    ├── python/
    │   ├── 01-basics.md
    │   └── 02-data-structures.md
    └── networking/
        ├── 01-tcp-ip.md
        └── 02-http.md
```

## 📝 Adding New Content

### 1. Create a New Folder

Create a new folder in `content/` with your topic name:

```bash
mkdir content/my-topic
```

### 2. Add Markdown Files

Create `.md` files in your topic folder. The first `# heading` will be used as the title:

```markdown
# My First Document

This is the content...

### Section

More content here.
```

### 3. Generate Index

Run the index generator:

```bash
node generate-index.js
```

The script will:
- Scan all folders in `content/`
- Extract titles from first `# heading` in each `.md` file
- Sort files naturally (01-, 02-, etc.)
- Generate `content/index.json`

### 4. Refresh Browser

Reload the page to see your new content.

## 🎨 Customization

### Changing Theme Colors

Edit CSS variables in `style.css`:

```css
:root {
    --bg-primary: #0d1117;
    --text-primary: #c9d1d9;
    /* ... other variables */
}

[class="light"] {
    --bg-primary: #ffffff;
    --text-primary: #1f2328;
    /* ... light theme variables */
}
```

### Modifying Layout

The layout uses flexbox and is fully responsive:

- Mobile: Hamburger menu, vertical file list
- Desktop: Fixed sidebar, horizontal file chips

## 📲 Installing as PWA

### On Mobile (iOS/Android)

1. Open the website in your browser
2. Tap the **Share** button
3. Select **Add to Home Screen** / **Install App**
4. The app will appear on your home screen with an icon

### On Desktop (Chrome/Edge)

1. Click the install icon in the address bar
2. Or go to browser menu → **Install My Reading Hub**
3. The app opens in a standalone window

### PWA Features

- ✅ Works offline after first visit
- ✅ Standalone window (no browser UI)
- ✅ App icon on home screen/launcher
- ✅ Fast loading with caching
- ✅ Full screen on mobile

## 🚢 Deployment

### GitHub Pages

1. Push repository to GitHub
2. Go to Settings → Pages
3. Select branch and folder
4. Your site will be at `https://username.github.io/repo-name`

### Netlify

1. Drag and drop the project folder to [netlify.com](https://netlify.com)
2. Or connect your GitHub repository
3. Deploy automatically

### Vercel

```bash
npm i -g vercel
vercel
```

### Any Static Host

Upload all files to any static hosting service (S3, Cloudflare Pages, etc.)

## 🛠️ Technical Details

### Technologies

- **Pure JavaScript** - No frameworks or build tools
- **Marked.js** - Markdown parsing
- **Highlight.js** - Syntax highlighting
- **CSS Variables** - Dynamic theming
- **Fetch API** - Loading content
- **localStorage** - Theme persistence

### Browser Support

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Mobile browsers

### Performance

- Lazy loading of markdown files
- Client-side caching
- Minimal dependencies
- Fast initial load

## 📱 Progressive Web App (PWA)

The app includes a basic PWA setup:

- `manifest.json` for app metadata
- Service worker stub (ready for caching)
- Can be installed on mobile devices

## ⌨️ Keyboard Shortcuts

- `←` (Left Arrow) - Previous document
- `→` (Right Arrow) - Next document
- Search box focuses automatically

## 🔧 Troubleshooting

### Content not loading

- Ensure you're running from a web server (not `file://`)
- Check that `content/index.json` exists
- Verify `.md` files are in correct folders

### Theme not persisting

- Check if `localStorage` is enabled in browser
- Clear browser cache and reload

### Search not working

- Wait for files to load
- Try a different search term
- Check browser console for errors

## 🤝 Contributing

Feel free to:

- Add more content
- Improve styles
- Enhance features
- Report issues

## 📄 License

MIT License - Use freely for personal or commercial projects.

## 🙏 Acknowledgments

- **Marked.js** - Markdown parser
- **Highlight.js** - Syntax highlighter
- **GitHub** - Dark theme inspiration

---

**Made with ❤️ for offline documentation reading**

