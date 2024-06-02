const pool = require('../connect');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Ganti 'your_secret_key' dengan kunci rahasia yang Anda tentukan
const secretKey = 'your_secret_key';

exports.register = async (req, res) => {
    const { username, email, password } = req.body;
    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const result = await pool.query(
            'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING *',
            [username, email, hashedPassword]
        );

        const user = result.rows[0];
        const token = jwt.sign({ userId: user.id}, secretKey, { expiresIn: '1h' });
        res.status(201).json({token, user});
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.registerAdmin = async (req, res) => {
    const { username, email, password } = req.body;
    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const result = await pool.query(
            'INSERT INTO users (username, email, password, is_admin) VALUES ($1, $2, $3, TRUE) RETURNING *',
            [username, email, hashedPassword]
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.login = async (req, res) => {
    const { email, password } = req.body;
    console.log(email);
    console.log(password);
    try {
        const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
        if (result.rows.length === 0) {
            return res.status(400).json({ error: 'User not found' });
        }

        const user = result.rows[0];
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return res.status(400).json({ error: 'Invalid credentials' });
        }

        const token = jwt.sign({ userId: user.id}, secretKey, { expiresIn: '1h' });
        res.json({ token, user });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
exports.update = async (req, res) => {
    const { id, username, email } = req.body;

    console.log(id);
    console.log(username);
    console.log(email);
    try {
        await pool.query('UPDATE users SET username = $2, email = $3 WHERE id = $1', [id, username, email])
        res.json({ message: 'User updated successfully' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.logout = (req, res) => {
    res.json({ message: 'Logout successful' });
};
