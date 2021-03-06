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
    
    var crearGrupoCancelable: Cancellable?
    var anadirCategoriaCancelable: Cancellable?
    var editarCategoriaCancellable: Cancellable?
    var unirGrupoCancellable: Cancellable?
    var abandonarCancellable: Cancellable?
    
    @Published var estado: GrupoEstado?
    @Published var error: String?
    
    func getGrupoEstado(){
        if getUsuario().grupo == ""{
            estado = .unirGrupo
        } else {
            estado = .conGrupo
        }
    }
    
    func llamadaUnirGrupo(id: String) -> AnyPublisher<GrupoRespuesta,Error>{
        return crearLlamada(url: unirGrupoUrl,
                            parametros: [
                                "grupoToken":id,
                                "usuarioToken":getUsuario().token ?? ""])
            .eraseToAnyPublisher()
    }
    
    func unirGrupo(id: String){
        unirGrupoCancellable = llamadaUnirGrupo(id: id).sink(receiveCompletion: {
            switch $0{
            case .failure(let err):
                guard let error = err as? TofyError else {
                    self.error = "errorParseo".localized
                    return
                }
                self.error = error.reason
            case .finished:()
            }
        }, receiveValue: { respuesta in
            guardarGrupo(grupo: respuesta.grupo.token ?? "")
            GrupoManager.shared.guardarGrupo(grupo: respuesta.grupo)
            self.estado = .conGrupo
        })
    }
    
    func llamadaCrearGrupo(nombre: String, ahorro: String) -> AnyPublisher<GrupoRespuesta,Error>{
        return crearLlamada(url: crearGrupoUrl,
                            parametros: [
                                "nombre":nombre,
                                "ahorro":ahorro,
                                "usuarioToken":getUsuario().token ?? ""])
            .eraseToAnyPublisher()
    }
    
    func crearGrupo(nombre: String, ahorro: String){
        crearGrupoCancelable = llamadaCrearGrupo(nombre: nombre,
                                                 ahorro: ahorro).sink(receiveCompletion: {
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
                                                    guardarGrupo(grupo: response.grupo.token ?? "")
                                                    GrupoManager.shared.guardarGrupo(grupo: response.grupo)
                                                    self.estado = .conGrupo
                                                 })
    }
    
    func llamadaAddCategoria(categoria: Categoria) -> AnyPublisher<CategoriaRespuesta,Error>{
        return crearLlamada(url: anadirCategoriaUrl,
                            parametros: [
                                "titulo":categoria.titulo ?? "",
                                "imagen":categoria.imagen ?? "",
                                "tipo":categoria.tipo ?? "",
                                "grupo":getUsuario().grupo ?? ""])
            .eraseToAnyPublisher()
    }
    
    func addCategoria(categoria: Categoria){
        anadirCategoriaCancelable = llamadaAddCategoria(categoria: categoria).sink(receiveCompletion: {
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
            GrupoManager.shared.updateCategorias(categoria: response.categoria)
        })
    }
    
    func llamadaEditarCategoria(categoria: Categoria) -> AnyPublisher<CategoriaRespuesta,Error>{
        return crearLlamada(url: editarCategoriaUrl,
                            parametros: [
                                "titulo":categoria.titulo ?? "",
                                "imagen":categoria.imagen ?? "",
                                "tipo":categoria.tipo ?? "",
                                "grupo":getUsuario().grupo ?? "",
                                "token":categoria.token ?? ""])
            .eraseToAnyPublisher()
    }
    
    func editarCategoria(categoria: Categoria){
        editarCategoriaCancellable = llamadaEditarCategoria(categoria: categoria).sink(receiveCompletion: {
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
            let nuevasCategorias = GrupoManager.shared.categorias!.map({(categoria) -> Categoria in
                if categoria.token != response.categoria.token{
                    return categoria
                } else {
                    return response.categoria
                }
            })
            GrupoManager.shared.categorias = nuevasCategorias
        })
    }
    
    func llamadaAbandonarGrupo() -> AnyPublisher<LoginRespuesta,Error>{
        return crearLlamada(url: abandonarGrupoUrl,
                            parametros: [
                                "usuarioToken":getUsuario().token ?? ""])
            .eraseToAnyPublisher()
    }
    
    func abandonarGrupo(){
        abandonarCancellable = llamadaAbandonarGrupo().sink(receiveCompletion: {
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
            guardarGrupo(grupo: "")
            self.estado = .unirGrupo
        })
    }
    
}

struct GrupoRespuesta: Codable{
    var grupo: Grupo
}

struct CategoriaRespuesta: Codable{
    var categoria: Categoria
}
