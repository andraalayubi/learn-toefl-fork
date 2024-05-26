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
        res.status(201).json(result.rows[0]);
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
        res.json({ token, isAdmin: user.is_admin, user });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
let loggedInUsers = {}; // Objek untuk menyimpan informasi pengguna yang sedang login

// exports.login = async (req, res) => {
//     console.log(email); // Cetak email pengguna ke konsol

//     const { email, password } = req.body;
//     try {
//         const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
//         if (result.rows.length === 0) {
//             return res.status(400).json({ error: 'User not found' });
//         }

//         const user = result.rows[0];
//         const isMatch = await bcrypt.compare(password, user.password);

//         if (!isMatch) {
//             return res.status(400).json({ error: 'Invalid credentials' });
//         }

//         const token = jwt.sign({ userId: user.id}, secretKey, { expiresIn: '1h' });
        
//         // Simpan informasi pengguna yang sedang login ke objek loggedInUsers
//         loggedInUsers = { token, isAdmin: user.is_admin, id: user.id };

//         res.json({ token, isAdmin: user.is_admin });
//     } catch (err) {
//         res.status(500).json({ error: err.message });
//     }
// };
exports.logout = (req, res) => {
    res.json({ message: 'Logout successful' });
};
