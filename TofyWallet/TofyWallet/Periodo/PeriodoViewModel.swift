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
    @Published var error: String?
    @Published var periodoFinalizado: Periodo?
    
    var crearPeriodoCancellable: Cancellable?
    var anadirMovimientoCancellable: Cancellable?
    var finalizarPeriodoCancellable: Cancellable?
    
    func getEstado(){
        if getUsuario().grupo == ""{
            estadoUsuario = .sinGrupo
        } else{
            if GrupoManager.shared.periodoActivo == nil || GrupoManager.shared.periodoActivo == ""{
                estadoUsuario = .sinPeriodoActivo
            } else{
                estadoUsuario = .conPeriodoActivo
            }
        }
    }
    
    func llamadaCrearPeriodo(titulo: String, ahorroEstimado: String) -> AnyPublisher<PeriodoRespuesta,Error>{
        return crearLlamada(url: crearPeriodoUrl,
                            parametros: [
                                "titulo":titulo,
                                "ahorroEstimado":ahorroEstimado,
                                "fechaInicio": Date().toString(),
                                "grupo":GrupoManager.shared.token ?? ""])
            .eraseToAnyPublisher()
    }
    
    func iniciarPeriodo(titulo: String, ahorroEstimado: String){
        crearPeriodoCancellable = llamadaCrearPeriodo(titulo: titulo,
                                                      ahorroEstimado: ahorroEstimado).sink(receiveCompletion: {
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
                                                        GrupoManager.shared.periodos?.append(response.periodo)
                                                        GrupoManager.shared.periodoActivo = response.periodo.token ?? ""
                                                        self.estadoUsuario = .conPeriodoActivo
                                                      })
    }
    
    func llamadaAnadirMovimiento(movimiento: Movimiento) -> AnyPublisher<MovimientoRespuesta,Error>{
        crearLlamada(url: anadirMovimientoUrl,
                     parametros: [
                        "descripcion":movimiento.descripcion ?? "",
                        "categoria":movimiento.categoria?.token ?? "",
                        "valor":movimiento.valor ?? "",
                        "tipo":movimiento.tipo ?? "",
                        "fecha":movimiento.fecha ?? "",
                        "periodo":movimiento.periodo ?? "",
                        "grupo":movimiento.grupo ?? ""
                     ]).eraseToAnyPublisher()
    }
    
    func anadirMovimiento(movimiento: Movimiento){
        anadirMovimientoCancellable = llamadaAnadirMovimiento(movimiento: movimiento)
            .sink(receiveCompletion: {
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
                GrupoManager.shared.guardarMovimiento(movimiento: response.movimiento)
            })
    }
    
    func llamadaFinalizarPeriodo(periodoToken: String, ahorroFinal: String) -> AnyPublisher<PeriodoRespuesta,Error>{
        crearLlamada(url: finalizarPeriodoUrl,
                     parametros: ["periodoToken":periodoToken,
                                  "grupo":getUsuario().grupo ?? "",
                                  "fechaFin": Date().toString(),
                                  "ahorroFinal":ahorroFinal])
            .eraseToAnyPublisher()
    }
    
    func finalizarPeriodo(periodoToken: String, movimientos: [Movimiento]){
        finalizarPeriodoCancellable = llamadaFinalizarPeriodo(periodoToken: periodoToken, ahorroFinal: calcularAhorroFinal(movimientos: movimientos))
            .sink(receiveCompletion: {
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
                GrupoManager.shared.finalizarPeriodo(periodoFinalizado: response.periodo)
                self.estadoUsuario = .sinPeriodoActivo
                self.periodoFinalizado = response.periodo
            })
    }
    
    func calcularAhorroFinal(movimientos: [Movimiento]) -> String{
        var ingresos: CGFloat = 0
        var gastos: CGFloat = 0
        
        for movimiento in movimientos{
            if movimiento.tipo == "Gasto"{
                gastos += (movimiento.valor ?? "").toNumber()
            }
            if movimiento.tipo == "Ingreso"{
                ingresos += (movimiento.valor ?? "").toNumber()
            }
        }
        
        return "\(ingresos - gastos)"
    }
    
    
}

struct PeriodoRespuesta: Codable{
    var periodo: Periodo
}

struct MovimientoRespuesta: Codable{
    var movimiento: Movimiento
}
