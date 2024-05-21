const { Pool } = require('pg');

// Konfigurasi koneksi ke PostgreSQL
const pool = new Pool({
    user: 'postgres.yosszjrgmdntfbziqgbr',
    host: 'aws-0-ap-southeast-1.pooler.supabase.com',
    database: 'postgres',
    password: ',pBhwk#7P7A?KZZ', // Ganti dengan kata sandi PostgreSQL Anda
    port: 5432, // Port default PostgreSQL
});

module.exports = pool;