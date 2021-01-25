//
//  GrupoViewModel.swift
//  TofyWallet
//
//  Created by usuario on 24/1/21.
//

import Foundation
import SwiftUI
import Combine

enum GrupoEstado {
    case unirGrupo
    case anadirGrupo
    case conGrupo
}

class GrupoViewModel: ObservableObject{
    
    @Published var estado: GrupoEstado?
    @Published var grupo: Grupo?
    
    func getGrupoEstado(){
        if getUsuario().grupo != ""{
            estado = .unirGrupo
        } else {
            grupo = Grupo(token: "A34ADA",
                          nombre: "Lopez Garcia Family",
                          mienbros: [Usuario(email: "mikelsalazarlopez@gmail.com",
                                            pass: "asdfasd",
                                            token: "asdfas",
                                            nombre: "Mikel",
                                            grupo: "asdf",
                                            tipoSeguridad: .ninguna,
                                            pin: "asdf")],
                          categorias: [])
            estado = .conGrupo
        }
    }
    
    func unirGrupo(id: String){
        
    }
    
    func crearGrupo(nombre: String, ahorro: String){
        
    }
    
}
