//
//  PeriodoViewModel.swift
//  TofyWallet
//
//  Created by usuario on 27/1/21.
//

import Foundation
import SwiftUI
import Combine


class PeriodoViewModel: ObservableObject{
    
    @Published var estadoUsuario: EstadoUsuario?
    
    func getEstado(){
        if getUsuario().grupo == ""{
            estadoUsuario = .sinGrupo
        } else{
            if GrupoManager.shared.periodoActivo == "" || GrupoManager.shared.periodoActivo == nil{
                estadoUsuario = .sinPeriodoActivo
            } else{
                estadoUsuario = .conPeriodoActivo
            }
        }
    }
    
    
}
