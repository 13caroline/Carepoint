const jwt = require('jsonwebtoken');

function verifyAuth(token) {

    //console.log(token);

    log_result = jwt.verify(token, 'secret', function(err, tokendata) {
        if (err) {
            return false;
        }
        if (tokendata) {
            decodedToken = tokendata.username;
            //console.log(decodedToken);
            return decodedToken;
        }
    })

    return log_result;

}


function StartupAuth(app) {
    return new Promise((resolve, reject) => {
        try {
            app.get('/admin/login', async(req, res) => {
                //console.log(req.headers);

                const [, hash] = req.headers.authorization.split(' ')
                const [username, password] = Buffer.from(hash, 'base64')
                    .toString()
                    .split(':');
                console.log("username : " + username + " password : " + password);
               
                let token = jwt.sign({ username: username }, 'secret', { expiresIn: '3h' });
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.write(JSON.stringify({ token: token, user: username }));
                res.end();
                
            });
        } catch (err) {
            next(err);
        }
    });
}

module.exports.StartupAuth = StartupAuth;
module.exports.verifyAuth = verifyAuth;