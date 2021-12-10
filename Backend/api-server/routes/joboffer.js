const express = require('express');
const router = express.Router();
const axios = require('axios');
const config = require('../models/Config/API_info'); 

const auth = require('../authorization/auth');

const jobOffer_controller = require('../controllers/joboffer');

router.post('/new', auth.checkAdminOrUserOrSP, (req, res, next) => {
    jobOffer = jobOffer_controller.newJob(req.body); 
    res.send('success')
})

module.exports = router;