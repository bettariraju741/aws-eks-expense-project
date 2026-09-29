const express = require("express");
const path = require("path");

const app = express();

const PORT = process.env.PORT || 3000;

app.use(express.json());

app.use(express.static(
    path.join(__dirname, "public")
));

app.get("/health", (req, res) => {
    res.json({
        status: "UP",
        service: "expense-frontend"
    });
});

app.listen(PORT, () => {
    console.log(`Frontend running on port ${PORT}`);
});
