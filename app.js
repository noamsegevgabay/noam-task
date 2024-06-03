const http = require('http');

// Create a simple HTTP server
const server = http.createServer((req, res) => {
  try {
    // Introduce a runtime error
    if (req.url === '/error') {
      throw new Error('This is a test error');
    }

    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello, cloudrideee :)!\n');
  } catch (err) {
    // Log the error to CloudWatch Logs
    console.error(err);
    
    // Respond with an error message
    res.writeHead(500, { 'Content-Type': 'text/plain' });
    res.end('Internal Server Error\n');
  }
});

// Listen on port 80
const PORT = process.env.PORT || 80;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
