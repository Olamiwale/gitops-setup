const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello, Testing GitOps Pipeline with AWS Cloud Service!');
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});