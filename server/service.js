const database = require("./database");

exports.getItemsByType = function(type){
	return database.execute("SELECT * FROM item WHERE type = ?", [type]);
};

exports.getItems = function(){
	return database.execute("SELECT * FROM item");
};

exports.saveItem = async function(item) {
	const result = await database.execute("INSERT INTO item (type, description) VALUES ?", [[[item.type, item.description]]]);
	return result.insertId;
};

exports.deleteItem = async function(id){
	return await database.execute("DELETE FROM item WHERE id = ?", [id]);
};