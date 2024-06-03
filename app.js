const http = require('http');

// Create a simple HTTP server
const server = http.createServer((req, res) => {
  // Introduce a runtime error
  if (req.url === '/error') {
    throw new Error('This is a test error');
  }
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello, cloudride :)!\n');
});

// Listen on port 80
const PORT = process.env.PORT || 80;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

// Handle uncaught exceptions
process.on('uncaughtException', (err) => {
  console.error('Uncaught exception:', err);
});
