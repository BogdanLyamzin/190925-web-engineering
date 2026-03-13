import { DataTypes } from "sequelize";

import sequelize from "../config/db.js";

const Contact = sequelize.define(
    "contact", 
    {
        name: {
            type: DataTypes.STRING,
        },
        email: {
            type: DataTypes.STRING,
        }
    }
);

// Contact.sync({alter: true});

export default Contact;