var express = require('express');
var temporal = require('../model/temporal.model');
var tempoRouter = express.Router();


////TABLA TEMPORAL

//  GET
tempoRouter.get('/crearModelo', function (req, res) {

  temporal.createModel(function (result) {
    if (typeof result !== undefined) {

      res.json(result)
      //res.render('index.pug', { mensaje: "{\n" + "\t res:" + result +"\n}" });
    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});
//  GET
tempoRouter.get('/getDatatemp', function (req, res) {

  temporal.getDatatemp(function (result) {
    if (typeof result !== undefined) {


      res.json(result);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});



////  POST
tempoRouter.get('/insertData', function (req, res) {

  temporal.insertData(function (result) {
    if (typeof result !== undefined) {


      //res.render('index.pug', { mensaje: "{\n" + "\t res:" + result + "\n}" });
      res.json(result)
    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});



// DELETE
tempoRouter.get('/deleteTable', function (req, res) {

  temporal.deleteTable(function (result) {
    if (typeof result !== undefined) {

      res.json(result);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});






module.exports = tempoRouter;