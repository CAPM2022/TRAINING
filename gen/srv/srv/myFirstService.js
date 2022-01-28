const myFirstService = function(srv) {
    srv.on('hello', (req) => {
        return  "Hello " + req.data.to + "!";
    });
}
module.exports = myFirstService