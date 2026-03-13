import express from "express";
import sequelize from "../config/db.js";

import User from "../models/User.js";
import Contact from "../models/Contact.js";

const app = express();
const port = Number(process.env.PORT) || 3000;

app.get("/", (req, res)=> {
    res.send("Server config successfully");
})

app.listen(port, async ()=> {
    
    try {
        await sequelize.authenticate();
        console.log("Successfully connect database");
        console.log(`Server running on port ${port}!`);
        // await User.create({name: "Bogdan", email: "bogdan@gmail.com"});
        // const users = await User.findAll();
        // console.log(users);
        // const user = await User.findOne({
        //     where: {
        //         email: "bogdan@gmail.com"
        //     }
        // });
        // console.log(user);
        // await User.update({name: "Bogdan Lyamzin"}, {
        //     where: {
        //         id: 1
        //     }
        // });
        // await User.destroy({
        //     where: {
        //         id: 1
        //     }
        // })
    }
    catch(error) {
        console.error(`Database connection failed`, error);
    }
})