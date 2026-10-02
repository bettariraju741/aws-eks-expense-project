const express = require("express");
const path = require("path");

const app = express();

const PORT = process.env.PORT || 3000;
const BACKEND_URL =
    process.env.BACKEND_URL || "http://expense-backend.expense.svc.cluster.local:8080";

// Basic HTTP security headers
app.disable("x-powered-by");

app.use((req, res, next) => {
    res.setHeader("X-Content-Type-Options", "nosniff");
    res.setHeader("X-Frame-Options", "DENY");
    res.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
    res.setHeader("Strict-Transport-Security", "max-age=31536000");
    next();
});

app.use(express.json());

// Forward API requests to the backend service
app.use("/api", async (req, res) => {
    try {
        const targetUrl = `${BACKEND_URL}${req.originalUrl}`;

        const response = await fetch(targetUrl, {
            method: req.method,
            headers: {
                "Content-Type": req.headers["content-type"] || "application/json"
            },
            body: ["GET", "HEAD"].includes(req.method)
                ? undefined
                : JSON.stringify(req.body)
        });

        const responseBody = await response.text();

        res.status(response.status);

        const contentType = response.headers.get("content-type");
        if (contentType) {
            res.set("Content-Type", contentType);
        }

        res.send(responseBody);
    } catch (error) {
        console.error("Backend proxy error:", error.message);
        res.status(502).json({
            message: "Unable to connect to backend service"
        });
    }
});

// Serve frontend static files
app.use(express.static(path.join(__dirname, "public")));

app.get("/health", (req, res) => {
    res.json({
        status: "UP",
        service: "expense-frontend"
    });
});

app.listen(PORT, () => {
    console.log(`Frontend running on port ${PORT}`);
});
