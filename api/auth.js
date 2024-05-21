const express = require('express');
const router = express.Router();
const authController = require('./controllers/auth');
const { authMiddleware } = require('./controllers/middleware');

router.post('/register', authController.register);
router.post('/registerAdmin', authController.registerAdmin);
router.post('/login', authController.login);
router.post('/logout', authMiddleware, authController.logout);

module.exports = router;
