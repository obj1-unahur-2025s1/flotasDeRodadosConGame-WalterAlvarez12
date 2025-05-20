import wollok.game.*

class Corsa {
   var property color 
   var position = new Position(x=4, y=7)
   const pasoPor = []
   // game.at(0,0)
   method capacidad() = 4
   method valocidadMaxima() = 150
   method peso() = 1300
   
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
  var property empleados = 0

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
}
