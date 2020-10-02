var express = require('express');
var temporal = require('../model/temporal.model');
var tempoRouter = express.Router();


////TABLA TEMPORAL

//  GET
tempoRouter.get('/crearTemporal', function (req, res) {

  temporal.createTemporal(function (result) {
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
tempoRouter.get('/cargarTemporal', function (req, res) {

  temporal.cargarTemporal(function (result) {
    if (typeof result !== undefined) {


      //res.render('index.pug', { mensaje: "{\n" + "\t res:" + result + "\n}" });
      res.json(result)
    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});



// DELETE
tempoRouter.get('/eliminarTemporal', function (req, res) {

  temporal.eliminarTemporal(function (result) {
    if (typeof result !== undefined) {

      res.json(result);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});






module.exports = tempoRouter;