//
//  InitialViewModel.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import Foundation
import SwiftUI
import Combine

enum TipoInicio{
    case login
    case main
}

class InitialViewModel: ObservableObject{
    
    var getGrupoCancelable: Cancellable?
    @Published var inicio: TipoInicio?
    @Published var error: String?
    
    func initApp(){
        if getUsuario().token != ""{
            if getUsuario().grupo != ""{
                getGrupoCancelable = llamadaGetGrupo().sink(receiveCompletion: {
                    switch $0{
                    case .failure(let err):
                        guard let error = err as? TofyError else {
                            self.error = "errorParseo".localized
                            return
                        }
                        self.error = error.reason
                    case .finished: ()
                    }
                }, receiveValue: { response in
                    GrupoManager.shared.grupo = response.grupo
                    self.inicio = .main
                })
            } else {
                inicio = .main
            }
        } else {
            inicio = .login
        }
    }
    
    func llamadaGetGrupo() -> AnyPublisher<GrupoRespuesta,Error>{
        return crearLlamada(url: getGrupoUrl,
                     parametros: [
                        "usuarioToken": getUsuario().token ?? ""
                     ]).eraseToAnyPublisher()
    }
    
}
