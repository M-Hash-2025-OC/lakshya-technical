// backend.js
import dotenv from "dotenv";
dotenv.config();

console.log("GITHUB_TOKEN:", process.env.GITHUB_TOKEN);
console.log("GITHUB_ORG:", process.env.GITHUB_ORG);


import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import Issue from "./models/Issue.js";
import { fetchAllIssues } from "./fetchIssues.js";

dotenv.config();
const app = express();

// ----------------- MIDDLEWARE -----------------
app.use(express.json());
app.use(cors({ origin: "http://localhost:3000" })); // allow frontend

const PORT = process.env.PORT || 4000;

// ----------------- CHECK ENV -----------------
if (!process.env.MONGO_URI) {
  console.error("❌ MONGO_URI is missing in .env");
  process.exit(1);
}
if (!process.env.GITHUB_TOKEN) {
  console.error("❌ GITHUB_TOKEN is missing in .env");
  process.exit(1);
}
if (!process.env.GITHUB_ORG) {
  console.error("❌ GITHUB_ORG is missing in .env");
  process.exit(1);
}

// ----------------- MONGODB CONNECTION -----------------
mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("✅ MongoDB connected"))
  .catch(err => console.error("❌ MongoDB connection error:", err));

// ----------------- AUTO-FETCH ISSUES -----------------
const FETCH_INTERVAL = 20 * 1000; // 20 seconds

setInterval(async () => {
  console.log("⏳ Fetching GitHub issues automatically...");
  try {
    await fetchAllIssues();
    console.log("✅ Auto-fetch done");
  } catch (err) {
    console.error("❌ Error fetching issues:", err.message || err);
  }
}, FETCH_INTERVAL);

// ----------------- ROUTES -----------------

// GET all issues
app.get("/issues", async (req, res) => {
  try {
    const issues = await Issue.find().sort({ received_at: -1 });
    res.json(issues);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST: Mark issue as valid/invalid
app.post("/issues/:id/mark", async (req, res) => {
  const { id } = req.params;
  const { status, points } = req.body;

  try {
    const issue = await Issue.findById(id);
    if (!issue) return res.status(404).json({ error: "Issue not found" });
    if (issue.immutable) return res.status(400).json({ error: "Issue is immutable" });

    issue.status = status;
    issue.points = points;
    issue.immutable = true; // cannot be changed again

    await issue.save();
    res.json({ message: "✅ Issue updated successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ----------------- START SERVER -----------------
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
