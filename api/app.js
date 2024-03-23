const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Define your contract data
const bounties = [
  { ID: 22, Coords: { x: 776.87, y: 850.21, z: 118.9 } },
  // Add more contract data here as needed
];

// Endpoint to fetch contract data
app.get('/api/contracts', (req, res) => {
  res.json(bounties);
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
