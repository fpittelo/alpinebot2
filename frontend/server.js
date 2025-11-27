const express = require('express');
const path = require('path');
const app = express();
const port = process.env.PORT || 3000;

// Serve static files from the current directory (which will be 'dist' in production)
const fs = require('fs');

// Debug logging
console.log('Server starting...');
console.log('__dirname:', __dirname);
try {
  console.log('Contents of __dirname:', fs.readdirSync(__dirname));
  if (fs.existsSync(path.join(__dirname, 'assets'))) {
    console.log('Contents of assets:', fs.readdirSync(path.join(__dirname, 'assets')));
  } else {
    console.log('Assets directory not found!');
  }
} catch (e) {
  console.error('Error listing directories:', e);
}

// Log all requests
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

app.use(express.static(__dirname));

// Handle SPA routing: return index.html for any unknown route
app.get('*', (req, res) => {
  console.log('Serving index.html for:', req.url);
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
