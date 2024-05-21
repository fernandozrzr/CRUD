const express = require("express");
const mongoose = require("mongoose");
const app = express();
const Product = require("./product");
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const productData = [];

// mongodb+srv://fernandozrzr:<0RQGSZVOxUW0LJSZ>@clusterfirstly.vnw21jo.mongodb.net/?retryWrites=true&w=majority&appName=Clusterfirstly

// connect to mongoose

mongoose.connect("mongodb+srv://fernandozrzr:0RQGSZVOxUW0LJSZ@clusterfirstly.vnw21jo.mongodb.net/firstly", {
})
    .then(() => {
        console.log("Connected to MongoDB");
    })
    .catch((err) => {
        console.error("Failed to connect to MongoDB:", err);
    });

// Post API
app.post("/api/add_product", async (req, res) => {
    console.log("Result", req.body);

    let data = Product(req.body);
    try {
        let dataToStore = await data.save();
        res.status(200).json(dataToStore);
    } catch (error) {
        res.status(400).json({ "message": error.message });
    }
    // const pdata = {
    //     id: productData.length + 1,
    //     name: req.body.pname,
    //     price: req.body.pprice,
    //     description: req.body.pdescription
    // };

    // productData.push(pdata);
    // console.log("Final", pdata);

    // res.status(200).send({
    //     "status code": 200,
    //     message: "Product added successfully",
    //     product: pdata
    // });
});

//get api
app.get("/api/get_product", async (req, res) => {

    try {
        let data = await Product.find();
        res.status(200).json(data);
    } catch (error) {
        res.status(400).json({ "message": error.message });
    }
    //console.log('Raw data:'${res.body}');
    // if (productData.length > 0) {
    //     res.status(200).send({
    //         "status code": 200,
    //         "message": "Product found",
    //         "products": productData
    //     });
    // }
    // else {
    //     res.status(404).send({
    //         "status code": 404,
    //         "message": "No product found",
    //         "products": []
    //     });
    // }
});

//put api (update every field)
/*app.put("/api/update_product/:id", (req, res) => {
    let id = req.params.id * 1; //convert string to number
    let productToUpdate = productData.find((product) => product.id === id);
    let index = productData.indexOf(productToUpdate);
    
    productData[index] = req.body;
    res.status(200).send({
        "status code": 200,
        "message": "Product updated successfully",
        "product": productData[index]
    });

}); */

app.put("/api/update_product/:id", async (req, res) => {

    let id = req.params.id;
    let updatedData = req.body;
    let options = { new: true };


    try {
        const data = await Product.findByIdAndUpdate(id, updatedData, options);
        res.status(200).send(data);
    } catch (error) {
        res.status(400).send({ "message": error.message });
    }
    // Convert the id to a number
    //let id = req.params.id * 1; //convert string to number
    // let productToUpdate = productData.find((product) => product.id === id);
    // let index = productData.indexOf(productToUpdate);

    // const { pname, pprice, pdescription } = req.body;
    // if (!pname || !pprice || !pdescription) {
    //     console.log(`pname: ${pname}, pprice: ${pprice}, pdescription: ${pdescription}`);
    //     return res.status(400).send({
    //         "status code": 400,
    //         "message": "Missing required fields: pname, pprice, pdescription"
    //     });
    // }

    // // Update the product
    // productToUpdate.name = pname;
    // productToUpdate.price = pprice;
    // productToUpdate.description = pdescription;

    // Send a success response
    // res.status(200).send({
    //     "status code": 200,
    //     "message": "Product updated successfully",
    //     "product": productToUpdate
    // });
});

//delete api

app.delete("/api/delete_product/:id", async (req, res) => {
    let id = req.params.id;
    try {
        const data = await Product.findByIdAndDelete(id);
        res.status(200).json({ 'status': "Deleted successfully ${data.pname} from database" })
    } catch (error) {
        res.status(204).json({ "message": error.message });
    }

    // let id = req.params.id * 1; //convert string to number
    // let productToDelete = productData.find((product) => product.id === id);
    // let index = productData.indexOf(productToDelete);

    // productData.splice(index, 1);
    // res.status(204).send({
    //     "status code": 204,
    //     "message": "Product deleted successfully",
    //     "product": productToDelete
    // });
});

app.listen(2000, () => {
    console.log("Server is running on port 2000");
});