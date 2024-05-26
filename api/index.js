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

app.get('/practice/all/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const query = `
    SELECT qg.question_category, qg.id, qg.name, qu.nilai, COUNT(q.id) AS jumlah_question
    FROM Question_Group qg
    LEFT JOIN Question q ON qg.id = q.question_group_id
    LEFT JOIN Question_User qu ON qu.question_group_id = qg.id
    AND qu.user_id = $1
    GROUP BY qg.question_category, qg.id, qg.name, qu.nilai
    ORDER BY qg.id ASC;
    `;
    const result = await pool.query(query, [id]);

    const formattedData = result.rows.reduce((acc, row) => {
      const { question_category, id, name, jumlah_question, nilai } = row;
      const groupIndex = acc.findIndex(group => group.question_category === question_category);

      if (groupIndex === -1) {
        acc.push({ question_category, data: [{ id, name, jumlah_question, nilai }] });
      } else {
        acc[groupIndex].data.push({ id, name, jumlah_question, nilai });
      }

      return acc;
    }, []);

    res.json(formattedData);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Endpoint /practice/all
app.get('/practice/all', async (req, res) => {
  try {
    const query = `
      SELECT qg.question_category, qg.id, qg.name, COUNT(q.id) AS jumlah_question
      FROM Question_Group qg
      LEFT JOIN Question q ON qg.id = q.question_group_id
      GROUP BY qg.question_category, qg.id, qg.name
      ORDER BY qg.id ASC;;
    `;
    const result = await pool.query(query);

    const formattedData = result.rows.reduce((acc, row) => {
      const { question_category, id, name, jumlah_question } = row;
      const groupIndex = acc.findIndex(group => group.question_category === question_category);

      if (groupIndex === -1) {
        acc.push({ question_category, data: [{ id, name, jumlah_question }] });
      } else {
        acc[groupIndex].data.push({ id, name, jumlah_question });
      }

      return acc;
    }, []);

    res.json(formattedData);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Endpoint /practice/:id
app.get('/practice/:id', async (req, res) => {
  const questionGroupId = req.params.id;
  try {
    const query = `
    SELECT qg.id, qg.name, qg.reading_text, qg.question_category, q.id, q.question_text,
    (SELECT ro.answer_text FROM ReadingOptions ro WHERE ro.question_id = q.id AND ro.is_correct = true) AS correct_answer,
    array_agg(ro.answer_text) AS answer_options
  FROM Question_Group qg
  LEFT JOIN Question q ON qg.id = q.question_group_id
  LEFT JOIN ReadingOptions ro ON q.id = ro.question_id
  WHERE qg.id = $1
  GROUP BY qg.name, qg.reading_text, qg.question_category, q.id, q.question_text;
    `;
    const result = await pool.query(query, [questionGroupId]);
    console.log(result.rows);

    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Question group not found' });
    } else {
      const formattedData = {
        id: result.rows[0].id, 
        name: result.rows[0].name,
        reading_text: result.rows[0].reading_text,
        question_category: result.rows[0].question_category,
        questions: result.rows.map(row => ({
          id: row.id,
          question_text: row.question_text,
          correct_answer: row.correct_answer,
          answer_options: row.answer_options
        }))
      };
      res.json(formattedData);
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/nilai', async (req, res) => {
  const { question_id, user_id, nilai } = req.body;

  try {
    const query = `
      INSERT INTO Question_User (question_id, user_id, nilai)
      VALUES ($1, $2, $3)
      ON CONFLICT (question_id, user_id) DO UPDATE SET nilai = $3;
    `;
    await pool.query(query, [question_id, user_id, nilai]);
    res.status(200).json({ message: 'Nilai berhasil disimpan' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
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
