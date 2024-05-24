const express = require('express');
const bodyParser = require('body-parser');
const pool = require('./connect');
const app = express();
const port = 3000;
// const ip = '192.168.100.6';
const ip = 'localhost';
const authRoutes = require('./auth');

// Middleware untuk parsing body permintaan
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/api/auth', authRoutes);

app.get('/', (req, res) => {
    res.send('Hello World!');
});
// Endpoint untuk mendapatkan data video berdasarkan ID
app.get('/practice', async (req, res) => {
    // const { id } = req.params;
    try {
        const { rows } = await pool.query("SELECT qc.name, qc.reading_text, json_agg( json_build_object('question', q.question_text, 'answers', ( SELECT json_agg( json_build_object('answer_text', a.answer_text, 'correct', (a.id = q.correct_answer_id))) FROM Answer a WHERE a.question_id = q.id ))) AS questions FROM Question_Category qc JOIN Question q ON qc.id = q.question_category_id GROUP BY qc.id, qc.name, qc.reading_text ORDER BY qc.name;"
        );
        res.json(rows);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});
app.get('/video/all/:id', async (req, res) => {
    const { id } = req.params;  
    try {
        const { rows } = await pool.query("SELECT VideoCategory.id AS vid, VideoCategory.name AS category_name, Video.id, Video.name, Video.url FROM SubCategory JOIN VideoCategory ON SubCategory.id = VideoCategory.subCategory_id JOIN Video ON VideoCategory.id = Video.video_category_id WHERE SubCategory.id = $1", [id]);
        // console.log(rows);

        function transformData(data) {
            const result = [];
          
            data.forEach(item => {
              const existingCategory = result.find(category => category.vid === item.vid && category.category_name === item.category_name);
          
              if (existingCategory) {
                existingCategory.videos.push({
                  id: item.id,
                  name: item.name,
                  url: item.url
                });
              } else {
                result.push({
                  vid: item.vid,
                  category_name: item.category_name,
                  videos: [
                    {
                      id: item.id,
                      name: item.name,
                      url: item.url
                    }
                  ]
                });
              }
            });
          
            return result;
          }

        const result = transformData(rows);
        // console.log(result);
        res.json(result);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.get('/video/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const { rows } = await pool.query('SELECT * FROM Video WHERE id = $1', [id]);
        res.json(rows[0]);
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Menjalankan server pada port tertentu
app.listen(port, () => {
    console.log(`Server berjalan di http://${ip}:${port}`);
});

module.exports = app;