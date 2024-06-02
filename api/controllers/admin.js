const router = require('express').Router();
const pool = require('../connect');

router.post('/video/add', async (req, res) => {
    const { name, url, categoryId } = req.body;
  
    try {
      // Memeriksa apakah kategori video ada
      const categoryQuery = 'SELECT id FROM VideoCategory WHERE id = $1';
      const categoryValues = [categoryId];
      const categoryResult = await pool.query(categoryQuery, categoryValues);
  
      if (categoryResult.rows.length === 0) {
        return res.status(400).json({ error: 'Invalid video category' });
      }
  
      // Memasukkan video baru ke database
      const insertQuery = 'INSERT INTO Video (name, url, video_category_id) VALUES ($1, $2, $3)';
      const insertValues = [name, url, categoryId];
      const insertResult = await pool.query(insertQuery, insertValues);
  
      res.status(200).json(insertResult.rows[0]);
    } catch (error) {
      console.error('Error executing query', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

router.put('/video/update/:id', async (req, res) => {
    const { id } = req.params;
    const { name, url, categoryId } = req.body;
  
    try {
      // Memeriksa apakah video ada
      const checkQuery = 'SELECT id FROM Video WHERE id = $1';
      const checkValues = [id];
      const checkResult = await pool.query(checkQuery, checkValues);
      if (checkResult.rows.length === 0) {
        return res.status(404).json({ error: 'Video not found' });
      }
  
      // Memeriksa apakah kategori video ada
      const categoryQuery = 'SELECT id FROM VideoCategory WHERE id = $1';
      const categoryValues = [categoryId];
      const categoryResult = await pool.query(categoryQuery, categoryValues);
      if (categoryResult.rows.length === 0) {
        return res.status(400).json({ error: 'Invalid video category' });
      }
  
      // Memperbarui data video
      const updateQuery = 'UPDATE Video SET name = $1, url = $2, video_category_id = $3 WHERE id = $4';
      const updateValues = [name, url, categoryId, id];
      const updateResult = await pool.query(updateQuery, updateValues);
  
      res.status(200).json(updateResult.rows[0]);
    } catch (error) {
      console.error('Error executing query', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

router.delete('/video/delete/:id', async (req, res) => {
    const { id } = req.params;
  
    try {
      // Memeriksa apakah video ada
      const checkQuery = 'SELECT id FROM Video WHERE id = $1';
      const checkValues = [id];
      const checkResult = await pool.query(checkQuery, checkValues);
      if (checkResult.rows.length === 0) {
        return res.status(404).json({ error: 'Video not found' });
      }
  
      // Menghapus video
      const deleteQuery = 'DELETE FROM Video WHERE id = $1';
      const deleteValues = [id];
      const deleteResult = await pool.query(deleteQuery, deleteValues);
  
      res.status(200).json({ message: 'Video deleted successfully' });
    } catch (error) {
      console.error('Error executing query', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

  module.exports = router;