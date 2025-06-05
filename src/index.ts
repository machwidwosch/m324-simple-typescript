import express from 'express';

const app = express();
const port = process.env.PORT || 3000;

// Eine einfache Route
app.get('/', (_req, res) => {
  res.send('Hello from TypeScript + Express!');
});

// Server starten
app.listen(port, () => {
  console.log(`🚀 Server läuft auf http://localhost:${port}`);
});
