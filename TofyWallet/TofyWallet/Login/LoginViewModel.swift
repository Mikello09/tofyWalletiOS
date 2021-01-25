//
//  LoginViewModel.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import Foundation
import SwiftUI
import Combine


class LoginViewModel: ObservableObject{
    
    var cancelable: Cancellable?
    
    @Published var error: String?
    @Published var loginOk: Bool?
    
    
    func llamadaLogin(email: String, pass: String) -> AnyPublisher<LoginRespuesta, Error>{
         return crearLlamada(url: loginUrl,
                            parametros: [
                                "email": email,
                                "contrasena": pass])
            .eraseToAnyPublisher()
    }
    
    func login(email: String, pass: String){
        cancelable = llamadaLogin(email: email, pass: pass).sink(receiveCompletion: {
            switch $0{
            case .failure(let err):
                guard let error = err as? TofyError else {
                    self.error = "errorParseo".localized
                    return
                }
                self.error = error.reason
            case .finished:()
            }
        }, receiveValue: { response in
            guardarUsuario(email: response.usuario.email ?? "",
                           pass: response.usuario.pass ?? "",
                           token: response.usuario.token ?? "",
                           nombre: response.usuario.nombre ?? "",
                           grupo: response.usuario.grupo ?? "")
            self.loginOk = true
        })
    }
    
}

struct LoginRespuesta: Codable{
    var usuario: Usuario
}
