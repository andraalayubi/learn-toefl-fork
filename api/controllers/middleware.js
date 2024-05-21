const jwt = require('jsonwebtoken');

// Ganti 'your_secret_key' dengan kunci rahasia yang sama yang digunakan di authController
const secretKey = 'your_secret_key';

exports.authMiddleware = (req, res, next) => {
    const token = req.header('Authorization').replace('Bearer ', '');
    if (!token) {
        return res.status(401).json({ error: 'No token, authorization denied' });
    }

    try {
        const decoded = jwt.verify(token, secretKey);
        req.user = decoded.userId;
        next();
    } catch (err) {
        res.status(401).json({ error: 'Token is not valid' });
    }
};
