const bcrypt = require('bcryptjs')
const LocalStrategy = require('passport-local').Strategy

const User = require('../../controllers/user')

module.exports = function (passport) {
    passport.use(new LocalStrategy(
        { usernameField: 'email', passwordField: 'password' }, (email, password, done) => {
            User.consultar(email).then((usr) => {
                if (!usr) {
                    return done(null, false, {
                        message: 'User does not exist.\n'
                    })
                }
                if (bcrypt.compareSync(password, usr.password)) {
                    return done(null, usr)
                } else {
                    return done(null, false, { message: 'Invalid credentials.' })
                }
            }).catch(err => done(err))
        }
    ))

    passport.serializeUser((user, done) => {
        console.log('Serializing User: ', user.name)
        done(null, user.idUser)
    })

    passport.deserializeUser((id, done) => {
        User.consultar_id(id).then((user) => {
            console.log('Deserializing User: ', user.name)
            done(null, user);
        }).catch((err) => {
            console.log(err)
        })
    })

}
