const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// MongoDB Connection
mongoose.connect("mongodb+srv://<username>:<password>@cluster.mongodb.net/busTracking", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Define Schema
const BusAlertSchema = new mongoose.Schema({
  message: String,
  timestamp: { type: Date, default: Date.now },
});

const BusAlert = mongoose.model("BusAlert", BusAlertSchema);

// API Route to Get Alerts
app.get("/alerts", async (req, res) => {
  const alerts = await BusAlert.find();
  res.json(alerts);
});

// API Route to Add Alert
app.post("/alerts", async (req, res) => {
  const newAlert = new BusAlert({ message: req.body.message });
  await newAlert.save();
  res.json({ status: "Alert Added" });
});

app.listen(5000, () => console.log("Server started on port 5000"));
