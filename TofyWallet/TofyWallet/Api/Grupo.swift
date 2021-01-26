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
    var miembros: [Usuario]?
    var categorias: [Categoria]?
}

struct Categoria: Codable, Hashable {
    var token: String?
    var titulo: String?
    var imagen: String?
    var tipo: String?
}

class GrupoManager{
    
    static var shared = GrupoManager()
    
    var grupo: Grupo = Grupo()

}
