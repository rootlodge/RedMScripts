const express = require('express');
const app = express();
const PORT = process.env.PORT || 3001;

// Define your contract data
const bounties = [
  {ID: 2,  Coords: { x: 489.53, y: 619.81, z: 111.7 }},
  {ID: 2,  Coords: { x: 516.53,   y: 621.81,   z: 111.7   }},
  {ID: 2,  Coords: { x: 516.53,   y: 619.81,   z: 111.7   }},
  {ID: 3,  Coords: { x: -423.75,  y: 1736.52,  z: 216.56  }},
  {ID: 3,  Coords: { x: -413.31,  y: 1752.52,  z: 216.25  }},
  {ID: 3,  Coords: { x: -397.92,  y: 1726.46,  z: 216.43  }},
  {ID: 4,  Coords: { x: -29.9,    y: 1227.25,  z: 172.98  }},
  {ID: 4,  Coords: { x: -17.65,   y: 1230.56,  z: 173.26  }},
  {ID: 5,  Coords: { x: 201.13,   y: 1001.63,  z: 189.77  }},
  {ID: 5,  Coords: { x: 223.16,   y: 987.52,   z: 190.89  }},
  {ID: 6,  Coords: { x: -156.23,  y: 1491.12,  z: 116.16  }},
  {ID: 7,  Coords: { x: -689.1,   y: 1042.07,  z: 135.0   }},
  {ID: 8,  Coords: { x: -948.0,   y: 2171.54,  z: 342.11  }},
  {ID: 8,  Coords: { x: -967.86,  y: 2182.34,  z: 340.86  }},
  {ID: 9,  Coords: { x: -1020.68, y: 1690.35,  z: 244.33  }},
  {ID: 10, Coords: { x: -552.95,  y: 2703.03,  z: 320.42  }},
  {ID: 10, Coords: { x: -541.7,   y: 2670.44,  z: 319.09  }},
  {ID: 10, Coords: { x: -556.19,  y: 2708.72,  z: 320.42  }},
  {ID: 11, Coords: { x: -1962.41, y: 2159.86,  z: 327.58  }},
  {ID: 12, Coords: { x: -1632.56, y: 1229.4,   z: 352.09  }},
  {ID: 12, Coords: { x: -1634.14, y: 1214.69,  z: 352.5   }},
  {ID: 12, Coords: { x: -1648.31, y: 1247.34,  z: 351.08  }},
  {ID: 13, Coords: { x: -1492.04, y: 1248.68,  z: 314.49  }},
  {ID: 13, Coords: { x: -1508.15, y: 1247.45,  z: 313.72  }},
  {ID: 13, Coords: { x: -1505.53, y: 1247.58,  z: 313.76  }},
  {ID: 14, Coords: { x: -1085.23, y: 706.71,   z: 104.49  }},
  {ID: 15, Coords: { x: -815.71,  y: 352.22,   z: 98.09   }},
  {ID: 15, Coords: { x: -860.24,  y: 335.94,   z: 96.42   }},
  {ID: 16, Coords: { x: -613.34,  y: -26.31,   z: 85.98   }},
  {ID: 16, Coords: { x: -629.76,  y: -60.95,   z: 82.86   }},
  {ID: 17, Coords: { x: -362.68,  y: -122.4,   z: 51.18   }},
  {ID: 17, Coords: { x: -344.13,  y: -157.94,  z: 50.71   }},
  {ID: 17, Coords: { x: -327.29,  y: -149.8,   z: 51.08   }},
  {ID: 17, Coords: { x: -360.85,  y: -116.76,  z: 47.6    }},
  {ID: 18, Coords: { x: -61.14,   y: -393.23,  z: 72.21   }},
  {ID: 19, Coords: { x: 900.69,   y: 261.53,   z: 116.0   }},
  {ID: 20, Coords: { x: 1114.8,   y: 488.62,   z: 97.28   }},
  {ID: 20, Coords: { x: 1122.96,  y: 469.77,   z: 97.02   }},
  {ID: 20, Coords: { x: 1178.78,  y: 430.47,   z: 92.78   }},
  {ID: 21, Coords: { x: 769.29,   y: 874.3,    z: 120.95  }},
  {ID: 21, Coords: { x: 776.87,   y: 850.21,   z: 118.9   }},
  // Add more contract data here as needed
];

// Endpoint to fetch contract data
app.get('/api/contracts', (req, res) => {
  //res.json(bounties);
  res.send({ bounties });
  successLog();
});

//success console log function
function successLog() {
  console.log('Success! The contract data has been fetched.');
}

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
