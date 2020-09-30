var express = require('express');
var temporal = require('../model/temporal.model');
var tempoRouter = express.Router();

tempoRouter.get('/crearModelo', function(req, res) {

    temporal.createModel(function(resultado) {
      if(typeof resultado !== undefined) {



        res.render('index.pug', { mensaje: "{\n" + "\t res: Tabla creada correctamente" +"\n}" });


      } else {
        res.json({"mensaje" : "No se pudo crear la tabla"});
      }
    });
  });


tempoRouter.get('/insertData', function(req, res) {

    temporal.insertData(function(resultado) {
      if(typeof resultado !== undefined) {


        res.render('index.pug', { mensaje: "{\n" + "\t res: Data insertada correctamente" +"\n}" });

      } else {
        res.json({"mensaje" : "No se pudo crear la tabla"});
      }
    });
  });

  tempoRouter.get('/getDatatemp', function(req, res) {

    temporal.getDatatemp(function(resultado) {
      if(typeof resultado !== undefined) {


        res.json(resultado);

      } else {
        res.json({"mensaje" : "No se pudo crear la tabla"});
      }
    });
  });



  



  module.exports = tempoRouter;