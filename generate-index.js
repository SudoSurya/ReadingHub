#!/usr/bin/env node

/**
 * generate-index.js
 * 
 * Generates content/index.json by scanning the content directory recursively
 * and extracting titles from Markdown files. Titles are extracted from the
 * first # heading in each file.
 * 
 * Usage: node generate-index.js
 */

const fs = require('fs');
const path = require('path');

const CONTENT_DIR = path.join(__dirname, 'content');
const INDEX_FILE = path.join(CONTENT_DIR, 'index.json');

/**
 * Extract title from markdown file (first # heading)
 */
function extractTitle(filePath) {
    try {
        const content = fs.readFileSync(filePath, 'utf8');
        const lines = content.split('\n');
        
        for (const line of lines) {
            const trimmed = line.trim();
            if (trimmed.startsWith('# ')) {
                return trimmed.substring(2).trim();
            }
        }
        
        // Fallback to filename
        return path.basename(filePath, '.md');
    } catch (error) {
        console.error(`Error reading ${filePath}:`, error.message);
        return path.basename(filePath, '.md');
    }
}

/**
 * Natural sort comparison for filenames
 */
function naturalSort(a, b) {
    return a.localeCompare(b, undefined, { numeric: true, sensitivity: 'base' });
}

/**
 * Scan directory recursively and collect markdown files
 */
function scanDirectory(dirPath) {
    const items = [];
    const entries = fs.readdirSync(dirPath, { withFileTypes: true });
    
    for (const entry of entries) {
        const fullPath = path.join(dirPath, entry.name);
        
        if (entry.isDirectory()) {
            // Skip hidden directories
            if (!entry.name.startsWith('.')) {
                const folderData = scanDirectory(fullPath);
                items.push(folderData);
            }
        } else if (entry.isFile() && entry.name.endsWith('.md')) {
            // This is a markdown file
            const relativePath = path.relative(CONTENT_DIR, fullPath);
            const title = extractTitle(fullPath);
            
            items.push({
                name: entry.name,
                path: relativePath,
                title: title
            });
        }
    }
    
    return items;
}

/**
 * Main function to generate index
 */
function generateIndex() {
    console.log('🔍 Scanning content directory...');
    
    try {
        const index = [];
        const entries = fs.readdirSync(CONTENT_DIR, { withFileTypes: true });
        
        for (const entry of entries) {
            if (entry.isDirectory() && !entry.name.startsWith('.')) {
                const folderPath = path.join(CONTENT_DIR, entry.name);
                const files = [];
                
                // Get all .md files in this folder
                const mdFiles = fs.readdirSync(folderPath)
                    .filter(file => file.endsWith('.md'))
                    .sort(naturalSort);
                
                for (const file of mdFiles) {
                    const filePath = path.join(folderPath, file);
                    const relativePath = path.relative(CONTENT_DIR, filePath);
                    const title = extractTitle(filePath);
                    
                    files.push({
                        name: file,
                        path: relativePath,
                        title: title
                    });
                }
                
                if (files.length > 0) {
                    index.push({
                        name: entry.name,
                        path: entry.name,
                        files: files
                    });
                }
            }
        }
        
        // Sort folders alphabetically
        index.sort((a, b) => a.name.localeCompare(b.name));
        
        // Write index.json
        const jsonContent = JSON.stringify(index, null, 2);
        fs.writeFileSync(INDEX_FILE, jsonContent, 'utf8');
        
        console.log('✅ Generated content/index.json');
        console.log(`📁 Folders: ${index.length}`);
        console.log(`📄 Files: ${index.reduce((sum, folder) => sum + folder.files.length, 0)}`);
        
        // Print structure
        console.log('\n📚 Index Structure:');
        for (const folder of index) {
            console.log(`  ${folder.name}/`);
            for (const file of folder.files) {
                console.log(`    - ${file.name} → ${file.title}`);
            }
        }
        
    } catch (error) {
        console.error('❌ Error generating index:', error.message);
        process.exit(1);
    }
}

// Run if executed directly
if (require.main === module) {
    generateIndex();
}

module.exports = { generateIndex };

