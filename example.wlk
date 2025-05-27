import wollok.game.*

class Corsa {
   var property color 
   method initialize() {
    if(not coloresValidos.listaDeColores().contains(color)) {
      self.error(color.toString() + "el auto no tiene un color valido")
    }
   }
   var position = new Position(x=4, y=7)
   const pasoPor = []
   // game.at(0,0)
   method capacidad() = 4
   method velocidadMaxima() = 150
   method peso() = 1300
   
}

object coloresValidos {
  const property listaDeColores = #{"rojo", "verde", "azul", "blanco"}
}


class Kwid {
  var property tieneTanqueAdicional 
  

  method capacidad() = if(tieneTanqueAdicional) 3 else 4
  method velocidadMaxima() = if(tieneTanqueAdicional) 110 else 120

  method peso() = 1200 + if(tieneTanqueAdicional) 150 else 0

  method color() = "azul"
}

object trafic {
  var property interior = comodo
  var property motor = pulenta
  method capacidad() = interior.capacidad()
  method velocidadMaxima() = motor.velocidad()
  method peso() = 4000 + interior.peso() + motor.peso()
  method color() = "blanco"


}


class Especial {
  var property capacidad
  var property peso
  var property color
    method initialize() {
    if(not coloresValidos.listaDeColores().contains(color)) {
      self.error(color.toString() + "el auto no tiene un color valido")
    }
   }
  const  velocidadMaxima
  method velocidadMaxima() = 
    velocidadMaxima.min(topeVelocidadMaxima.tope())
}
// const especial1 = new Especial(capacidad= 5, peso=1000,)

// const especial1 = new Especial(capacidad= 4, peso= 1500, color = "verde", velocidadMaxima=210)

// const especial2 = new Especial(capacidad= 4, peso= 1500, color = "azul", velocidadMaxima=180)
// especial1.veocidadMaxima(300) no cambia porque es una constante



object topeVelocidadMaxima {
  var property tope = 200

}
object pulenta {
  method peso() = 800
  method velocidad() = 130
}

object bataton {
  method peso() = 500
  method velocidad() = 80
}

object comodo {
  method capacidad() = 5
  method peso() = 700
}

object popular {
  method capacidad() = 12
  method peso() = 1000
}

class Dependencia {
  const flota = []
  const pedidos = #{}
  var property empleados = 0

  method agregarPedido(unPedido) {
    pedidos.add(unPedido)
  }

  method quitarPedido(unPedido) {
    pedidos.remove(unPedido)
  }

  method agregarAFlota(rodado) {
    flota.add(rodado)
  }

  method quitarDeFlota(rodado) {
    flota.remove(rodado)
  }

  method pesoTotalDeFlota() = flota.sum({r=>r.peso()})

  method estaBienEquipada() = self.tieneAlMenosRodados(5) && self.todosVanAlMenosA100()

  method tieneAlMenosRodados(cantidad) = flota.size() >= cantidad
  method todosVanAlMenosA100() = flota.all({r=>r.velocidadMaxima() >= 100})
  method capacidadTotalEnColor(color) =
    self.rodadosDeColor(color).sum({r=>r.capacidad()})
  method rodadosDeColor(color) = flota.filter({r=>r.color() == color})
  method colorDelRodadoMasRapido() = self.rodadoMasRapido().color()
  method rodadoMasRapido() = flota.max({r=>r.velocidadMaxima()})
  method capacidadFaltante() = (empleados - self.capacidadDeLaFlota()).max(0)
  method capacidadDeLaFlota() = flota.sum({r=>r.capacidad()})
  
  method esGrande() = empleados >= 40 && self.tieneAlMenosRodados(3)
  method totalPasajerosEnPedidos() = pedidos.sum({p=>p.cantidadDePasajeros()})
  method pedidosNoPuedenSerSatisfechos() = pedidos.filter({p=> self.todosPuedenSatisfacerElPedido(p)})
  method todosPuedenSatisfacerElPedido(unPedido) = flota.any({r=>!unPedido.esSatisfactorio(r)})
  method todosLosPedidosTienenIncompatible(unColor) =
  pedidos.all({p=> p.coloresIncompatibles().contains(unColor)})
  method relajarTodosLosPedidos() {
    pedidos.forEach({p=>p.relajar()})
  
  }
}


// ETAPA 2

class Pedidos {
  var property distanciaARecorrer
  var tiempoMaximo
  var property cantidadDePasajeros
  var property rodado
  const property coloresIncompatibles = #{}
  method initialize() {
  if(distanciaARecorrer  <= 0) {
    self.error("el Valor:" + distanciaARecorrer.toString() + "el valor debe ser positivo")
  }
  if(tiempoMaximo  <= 0) {
    self.error("el Valor:" + tiempoMaximo.toString() + "el valor debe ser positivo")
  }

  if(cantidadDePasajeros  <= 0) {
    self.error("el Valor:" + cantidadDePasajeros.toString() + "el valor debe ser positivo")
  }

  }
  method velocidadRequerida() = distanciaARecorrer / tiempoMaximo
// const pedido1= new Pedido(distancia=5, tiempoMaximo= 4, cantidadDePasajeros= 5, )
  method esSatisfactorio() {
    return 
    rodado.velocidadMaxima() > self.velocidadRequerida() + 10 and
    rodado.capacidad() >= self.cantidadDePasajeros() and
    !self.coloresIncompatibles().contains(rodado.color())
  }


  method agregarColorIncompatible(unColor) {
    coloresIncompatibles.add(unColor)
  }
  
  method eliminarColorIncompatible(unColor) {
    if(!coloresIncompatibles.contains(unColor)){
       self.error("El color" + unColor + " " + "no estaba incluido en la lista")

    }
    coloresIncompatibles.remove(unColor)
  }

  method acelerar() {
    tiempoMaximo = 1.max(tiempoMaximo - 1)
  }

  method relajar() {
    tiempoMaximo = tiempoMaximo + 1
  }
}  
