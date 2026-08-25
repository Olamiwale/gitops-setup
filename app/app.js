const express = require('express');

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello, Testing GitOps Pipeline with AWS Cloud Service!');
});

// Kubernetes liveness probe
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy'
  });
});

// Kubernetes readiness probe
app.get('/ready', (req, res) => {
  res.status(200).json({
    status: 'ready'
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});