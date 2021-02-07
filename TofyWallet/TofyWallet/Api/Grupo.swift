//
//  Grupo.swift
//  TofyWallet
//
//  Created by usuario on 25/1/21.
//

import Foundation
import SwiftUI

enum TipoCategoria: String{
    case gasto = "Gasto"
    case ingreso = "Ingreso"
}

struct Grupo: Codable {
    var token: String?
    var nombre: String?
    var ahorro: String?
    var periodoActivo: String?
    var miembros: [Usuario]?
    var categorias: [Categoria]?
    var periodos: [Periodo]?
}

struct Categoria: Codable, Hashable {
    var token: String?
    var titulo: String?
    var imagen: String?
    var tipo: String?
}

struct Periodo: Codable, Hashable{
    var token: String?
    var titulo: String?
    var ahorroEstimado: String?
    var fechaInicio: String?
    var fechaFin: String?
    var ahorroFinal: String?
    var movimientos: [Movimiento]?
}

struct Movimiento: Codable, Hashable{
    var token: String?
    var descripcion: String?
    var valor: String?
    var categoria: Categoria?
    var fecha: String?
    var tipo: String?
    var periodo: String?
    var grupo: String?
}


class GrupoManager: ObservableObject{
    
    static var shared = GrupoManager()
    
    @Published var token: String?
    @Published var nombre: String?
    @Published var ahorro: String?
    @Published var periodoActivo: String?
    @Published var miembros: [Usuario]?
    @Published var categorias: [Categoria]?
    @Published var periodos: [Periodo]?
    
    func guardarGrupo(grupo: Grupo){
        self.token = grupo.token
        self.nombre = grupo.nombre
        self.ahorro = grupo.ahorro
        self.periodoActivo = grupo.periodoActivo
        self.miembros = grupo.miembros
        self.categorias = grupo.categorias
        self.periodos = grupo.periodos
    }
    
    func updateCategorias(categoria: Categoria){
        if self.categorias != nil {
            var categoriasNuevas = self.categorias!
            categoriasNuevas.append(categoria)
            self.categorias = categoriasNuevas
        } else {
            self.categorias = [categoria]
        }
    }
    
    func guardarMovimiento(movimiento: Movimiento){
        let periodosActualizados = self.periodos?.map({ (periodo) -> Periodo in
            if periodo.token == movimiento.periodo{
                var periodoActualizado = periodo
                periodoActualizado.movimientos?.append(movimiento)
                return periodoActualizado
            } else {
                return periodo
            }
        })
        self.periodos = periodosActualizados
    }
    
    func finalizarPeriodo(periodoFinalizado: Periodo){
        self.periodoActivo = ""
        let periodosActualizados = self.periodos?.map({ (periodo) -> Periodo in
            if periodo.token == periodoFinalizado.token{
                var periodoActualizado = periodo
                periodoActualizado.fechaFin = periodoFinalizado.fechaFin
                return periodoActualizado
            } else {
                return periodo
            }
        })
        self.periodos = periodosActualizados
    }

}
