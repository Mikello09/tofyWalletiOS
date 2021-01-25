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
    
    func getGrupoEstado(){
        if getUsuario().grupo == ""{
            estado = .unirGrupo
        } else {
            estado = .conGrupo
        }
    }
    
    func unirGrupo(id: String){
        
    }
    
    func crearGrupo(nombre: String, ahorro: String){
        
    }
    
}
