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
}

struct Categoria: Codable, Hashable {
    var token: String?
    var titulo: String?
    var imagen: String?
    var tipo: String?
}

struct Periodo: Codable, Hashable{
    var titulo: String?
    var ahorroEstimado: String?
    var fechaInicio: String?
    var fechaFin: String?
}

class GrupoManager: ObservableObject{
    
    static var shared = GrupoManager()
    
    
    @Published var token: String?
    @Published var nombre: String?
    @Published var ahorro: String?
    @Published var periodoActivo: String?
    @Published var miembros: [Usuario]?
    @Published var categorias: [Categoria]?
    
    func guardarGrupo(grupo: Grupo){
        self.token = grupo.token
        self.nombre = grupo.nombre
        self.ahorro = grupo.ahorro
        self.periodoActivo = grupo.periodoActivo
        self.miembros = grupo.miembros
        self.categorias = grupo.categorias
    }
    
    func updateAhorro(ahorro: String){
        self.ahorro = ahorro
    }
    
    func updatePeriodoActivo(periodoActivo: String){
        self.periodoActivo = periodoActivo
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

}
