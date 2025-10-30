# Quick Start Guide

## 🚀 Getting Started in 3 Steps

### Step 1: Start the Server

Open terminal in the project directory and run:

```bash
npx serve .
```

Or if you prefer Python:

```bash
python3 -m http.server 8000
```

### Step 2: Open in Browser

Navigate to:
- `http://localhost:3000` (if using npx serve)
- `http://localhost:8000` (if using Python)

### Step 3: Start Reading!

- Click a folder in the sidebar to see files
- Click a file to read
- Use arrow keys to navigate between files
- Search for content using the search bar
- Toggle dark/light mode with the moon/sun icon

## 📝 Adding Your Own Content

### Quick Steps:

1. Create a folder: `mkdir content/my-topic`
2. Add Markdown files: Create `.md` files with your content
3. Generate index: `node generate-index.js`
4. Refresh browser

Example:
```bash
mkdir content/docker
echo "# Docker Basics

Docker is a containerization platform..." > content/docker/01-intro.md
node generate-index.js
```

That's it! Your new content will appear in the app.

## 🎨 Features to Try

- **🌓 Dark/Light Mode**: Click the theme toggle in top-right
- **🔍 Search**: Type in the search bar to find content across all files
- **⌨️ Keyboard Navigation**: Press ← → to navigate between documents
- **📱 Mobile View**: Resize browser or open on phone to see mobile layout
- **📄 File Navigation**: Click chips at top to jump to any file

## 🛠️ Troubleshooting

**Page not loading?**
- Make sure you're accessing via `http://` not `file://`
- Check that server is running in terminal

**Content not showing?**
- Run `node generate-index.js` to regenerate index
- Refresh browser

**Search not working?**
- Wait a moment for files to load
- Try a different search term

---

**That's it! Enjoy your Reading Hub! 📚**

