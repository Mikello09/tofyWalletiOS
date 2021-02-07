//
//  HomeViewModel.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import Foundation
import SwiftUI
import Combine


class HomeViewModel: ObservableObject{
    
    @Published var items: [HomeItem]?
    @Published var estadoUsuario: EstadoUsuario?
    
    func getItems(){
        var itemsToShow: [HomeItem] = []
        itemsToShow.append(.grupo)
        itemsToShow.append(.perfil)
        itemsToShow.append(.info)
        items = itemsToShow
    }
    
    func getEstado(){
        if getUsuario().grupo == ""{
            estadoUsuario = .sinGrupo
        } else{
            if GrupoManager.shared.periodoActivo == nil{
                estadoUsuario = .sinPeriodoActivo
            } else{
                estadoUsuario = .conPeriodoActivo
            }
        }
    }
    
}
