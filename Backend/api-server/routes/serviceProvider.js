const express = require('express');
const router = express.Router();
const auth = require('../authorization/auth');

const ServiceProvider = require('../controllers/serviceProvider');
const User = require('../controllers/user');

/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

//Obter os horários de um serviceProvider especifico com o ID
 router.get('/horarios', (req, res) => {
    var iden = req.query.id;

    ServiceProvider.get_horarios(iden)
    .then((categories) => {
        let ocupSchd = categories[0].occupiedSchedule
        if(ocupSchd != null){
            let os_size = Object.keys(ocupSchd).length

            for(let i = 0; i < os_size; i++){
                let slot = ocupSchd[i]
                let ids = slot.idCategory
            
                let split = ids.split(',')
                let split_2 = split[0].split('[')
                split[0] = split_2[split_2.length - 1]
                let split_3 = split[split.length - 1].split(']')
                split[split.length - 1] = split_3[0]
            
                slot = split
                ocupSchd[i].idCategory = slot
            }
            categories[0].occupiedSchedule = ocupSchd
        }
        //console.log(categories)
        res.status(200).jsonp({categories: categories})
    })
    .catch((err) => res.status(400).jsonp("Error obtaining Provider: " + err));
 })

// List a Service Provider given it's id
router.get('/', (req, res, next) => {
    
    var iden = req.query.id;

    ServiceProvider.sp_profile(iden)
    .then((profile) => {
        ServiceProvider.get_reviews(iden)
        .then((reviews) => {
            ServiceProvider.get_only_categories(iden)
            .then((categories) => {
                res.status(200).jsonp({
                    ServiceProvider: profile,
                    reviews: reviews,
                    categories: categories
                })
            })
            .catch((err) => res.status(400).jsonp("Error obtaining Provider: " + err));
        })
        .catch((err) => res.status(400).jsonp("Error obtaining Provider: " + err));
    })
    .catch((err) => res.status(400).jsonp("Error obtaining Provider: " + err));
})

// Consult a ServiceProvider given its id
router.get('/:id', function(req, res, next) {
    console.log(req.body)
    console.log(req.params.id)
    ServiceProvider.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});

//Obter toda a informação referente a um service provider
/*router.get('/profile/', (req, res, next) => {
})
*/
/****************************************************************************************
 *                                   POST
 ****************************************************************************************/

// Insert a new ServiceProvider
router.post('/', function(req, res) {
    console.log(req.body)
    ServiceProvider.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(400).jsonp({ error: e }))
});

router.post('/requests', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token)
    User.consult(email)
    .then((usr) => {
        ServiceProvider.getRequestedSlots(usr.idUser)
        .then((slots) => {
            jsonSize = Object.keys(slots).length

            for(let i = 0; i < jsonSize; i++) {
                let nomes = slots[i].array_categories
                const filter_nomes = nomes.filter(ct => ct != '\n')
                let arrSize = filter_nomes.length
                for(let j = 0; j < arrSize; j++) {
                    filter_nomes[j] = filter_nomes[j].replace(/(\r\n|\n|\r)/gm, "")
                }
                slots[i].array_categories = filter_nomes
            }
            //console.log(slots)
            res.status(200).jsonp({slots: slots})
        })
        .catch((err) => {res.status(400).jsonp({ error : err })})
    })
})

router.post('/getCategorias', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token)
    User.consult(email)
    .then((user) => {
        ServiceProvider.get_only_categories(user.idUser)
        .then((categories) => res.status(200).jsonp({categories : categories}))
        .catch((err) => res.status(400).jsonp({error : err}))
    })
    .catch((err) => res.status(400).jsonp({error : err}))
})

/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/

router.put('/regHorario', auth.checkSubscription, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token)
    User.consult(email)
    .then((usr) => {
        var uid = usr.idUser;
        var dateBegin = req.body.dateBegin;
        var dateEnd = req.body.dateEnd;
        var text = '{"date_end": "'+dateEnd+'",' + '"date_begin": "'+dateBegin+'"}'
        console.log(text)
        ServiceProvider.addHorario(uid, text)
        .then((upd) => {
            
            if(upd[0].can_add == 1)
                res.status(200).jsonp({ message: "Success!" })
            else    
                res.status(400).jsonp({ error: "Slot do Hórario já se encontra ocupado." })
    })
        .catch((err) => {res.status(400).jsonp({ error : err })})
    })
    .catch((err) => res.status(400).jsonp({ error : err }))
})

router.put('/remHorario', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token)
    User.consult(email)
    .then((usr) => {
        var text = '{"date_end": "'+req.body.dateEnd+'",' + '"date_begin": "'+req.body.dateBegin+'"}'
        ServiceProvider.remHorario(usr.idUser,  text)
        .then((upd) => {res.status(200).jsonp({ message: "success" })})
        .catch((err) => {res.status(400).jsonp({ error : err })})
    })
})

router.put('/newSlot', auth.validToken, (req,res) => {
    email = auth.getEmailFromJWT(req.body.token)
    User.consult(email)
    .then((usr) => {
        var uid = usr.idUser;
        var dateBegin = req.body.dateBegin;
        var dateEnd = req.body.dateEnd;
        var r_categories = req.body.categories;
        var d = new Date();
        var ymd = d.getFullYear() + "-" + (('0'+(d.getMonth()+1)).slice(-2)) + "-" + (('0'+(d.getDate()+1)).slice(-2));
        var hms = d.getHours() + ":" + (('0'+d.getMinutes()).slice(-2)) + ":" + (('0'+d.getSeconds()).slice(-2));
        var postDate = ymd + " " + hms;
        var occupied = "0";
        let text = '{"id": "'+uid+'",' +
                   '"date_end": "'+dateEnd+'",' +
                   '"occupied": "'+occupied+'",' +
                   '"date_begin": "'+dateBegin+'",' +
                   '"idCategory": "['+r_categories+']",'+
                   '"date_requested": "'+postDate+'"}';
        ServiceProvider.addSlot(req.body.spId, text)
        .then((upd) => {res.status(200).jsonp({ message: "success" })})
        .catch((err) => {res.status(400).jsonp({ error : err })})  
    })
    .catch((err) => {res.status(400).jsonp({ error : err })})    
})

router.put('/remSlot', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token)
    
    let text = '{"id": "'+req.body.id+'",' +
    '"date_end": "'+req.body.dateEnd+'",' +
    '"occupied": "'+req.body.occupied+'",' +
    '"date_begin": "'+req.body.dateBegin+'",' +
    '"idCategory": "['+req.body.categories+']",'+
    '"date_requested": "'+req.body.postDate+'"}';

    User.consult(email)
    .then((usr) => {
        ServiceProvider.remSlot(usr.idUser, text)
        .then((upd) => {res.status(200).jsonp({ message: "success" })})
        .catch((err) => {res.status(400).jsonp({ error : err })})
    })
    .catch((err) => {res.status(400).jsonp({ error : err })})
})

router.put('/acceptSlot', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token);
    
    let text = '{"id": "'+req.body.id+'",' +
    '"date_end": "'+req.body.dateEnd+'",' +
    '"occupied": "'+req.body.occupied+'",' +
    '"date_begin": "'+req.body.dateBegin+'",' +
    '"idCategory": "['+req.body.categories+']",'+
    '"date_requested": "'+req.body.postDate+'"}';

    intermediateJson = JSON.parse(text);
    intermediateJson["occupied"] = '1';
    finalJson = JSON.stringify(intermediateJson)
    
    User.consult(email)
    .then((usr) => {
        ServiceProvider.verify(usr.idUser, text)
        .then((value) => {
            if(value[0].can_accept == 1){
                ServiceProvider.remSlot(usr.idUser, text)
                .then((upd) => {
                    ServiceProvider.addSlot(usr.idUser, finalJson)
                    .then((done) => res.status(200).jsonp({ message: "success" }))
                    .catch((err) => {res.status(400).jsonp({ error : err })})
                })
                .catch((err) => {res.status(400).jsonp({ error : err })})
            }
            else{
                res.status(400).jsonp({ error : "Slot já preenchido com outro trabalho!" })
            }
        })
        .catch((err) => {res.status(400).jsonp({ error : err })})
    })
    .catch((err) => {res.status(400).jsonp({ error : err })})
})

router.put('/addCategoria', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token);
    User.consult(email)
    .then((usr) => {
        ServiceProvider.get_categories(usr.idUser)
        .then((cats) => {
            experience = cats[0].experience
            ServiceProvider.addCategoria(usr.idUser, req.body.categoria, experience, req.body.price)
            .then((finish) => res.status(200).jsonp({message: "success!"}))
            .catch(e => res.status(400).jsonp({ error: e }))
        })
        .catch(e => res.status(400).jsonp({ error: e }))
    })
    .catch(e => res.status(400).jsonp({ error: e }))
})

router.put('/remCategoria', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token);
    User.consult(email)
    .then((usr) => {
        ServiceProvider.remCategoria(usr.idUser, req.body.categoria)
        .then((finish) => res.status(200).jsonp({message: "success!"}))
        .catch(e => res.status(400).jsonp({ error: e }))
    })
    .catch(e => res.status(400).jsonp({ error: e }))
})

router.put('/updCategoria', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token);
    User.consult(email)
    .then((usr) => {
        ServiceProvider.updateCategoria(usr.idUser, req.body.categoria, req.body.price)
        .then((finish) => res.status(200).jsonp({message: "success!"}))
        .catch(e => res.status(400).jsonp({ error: e }))
    })
    .catch(e => res.status(400).jsonp({ error: e }))
})

// Update an ServiceProvider
router.put('/:id', function(req, res, next) {
    ServiceProvider.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(400).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a ServiceProvider given its id
router.delete('/:id', function(req, res, next) {
    ServiceProvider.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});

module.exports = router;