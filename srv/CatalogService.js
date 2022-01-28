module.exports = cds.service.impl( async function(){

    const {
        EmployeeSet, POs
    } = this.entities;

    this.before('UPDATE', EmployeeSet, (req,res) => {
        console.log("aaya kya", req.data.salaryAmount);
        if(parseFloat(req.data.salaryAmount) >= 1000000){
            req.error(500, "salary must be below 1 mn");
            //res.send("Dude, not allowed salary");
        }
    });

});