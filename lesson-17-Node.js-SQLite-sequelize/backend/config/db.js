import { Sequelize } from "sequelize";
import configData from "./config.json" with {type: "json"};

const env = process.env.NODE_ENV || "development";
const config = configData[env];

const sequelize = new Sequelize({
    storage: config.storage,
    dialect: config.dialect,
});

export default sequelize;