

var express = require('express');
var consulta = require('../model/consulta.model');
var consultaRouter = express.Router();


// CONSULTA 1
consultaRouter.get('/consulta1', function (req, res) {

  consulta.consulta1(function (result) {
    if (typeof result !== undefined) {

      res.json(result);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});

// CONSULTA 2
consultaRouter.get('/consulta2', function (req, res) {

  consulta.consulta2(function (result) {
    if (typeof result !== undefined) {

      res.json(result);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});


// CONSULTA 3
consultaRouter.get('/consulta3', function (req, res) {

  consulta.consulta3(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});




// CONSULTA 4
consultaRouter.get('/consulta4', function (req, res) {

  consulta.consulta4(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});



// CONSULTA 4
consultaRouter.get('/consulta5', function (req, res) {

  consulta.consulta5(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});



// CONSULTA 6
consultaRouter.get('/consulta6', function (req, res) {

  consulta.consulta6(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});




// CONSULTA 7
consultaRouter.get('/consulta7', function (req, res) {

  consulta.consulta7(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});

// CONSULTA 7
consultaRouter.get('/consulta8', function (req, res) {

  consulta.consulta8(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});

// CONSULTA 7
consultaRouter.get('/consulta9', function (req, res) {

  consulta.consulta9(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});




// CONSULTA 10
consultaRouter.get('/consulta10', function (req, res) {

  consulta.consulta10(function (result) {
    if (typeof result !== undefined) {
      res.json(result[0]);

    } else {
      res.json({ "mensaje": "No se pudo crear la tabla" });
    }
  });
});

module.exports = consultaRouter;
