//
//  ApiManager.swift
//  TofyWallet
//
//  Created by usuario on 21/1/21.
//

import Foundation
import SwiftUI
import Combine

let baseUrl: String = "https://tofyserver.herokuapp.com"
let loginUrl: String = "\(baseUrl)/usuario/doLogin"
let crearGrupoUrl: String = "\(baseUrl)/grupo/crearGrupo"
let getGrupoUrl: String = "\(baseUrl)/grupo/getGrupo"
let anadirCategoriaUrl: String = "\(baseUrl)/grupo/addCategoria"
let editarCategoriaUrl: String = "\(baseUrl)/grupo/editarCategoria"
let unirGrupoUrl: String = "\(baseUrl)/grupo/unirGrupo"
let abandonarGrupoUrl: String = "\(baseUrl)/grupo/abandonarGrupo"

let crearPeriodoUrl: String = "\(baseUrl)/periodo/crearPeriodo"//titulo,ahorroEstimado,fechaInicio,grupo
let finalizarPeriodoUrl: String = "\(baseUrl)/periodo/finalizarPeriodo"//periodoToken,grupo,fechaFin
let anadirMovimientoUrl: String = "\(baseUrl)/periodo/addMovimiento"//

let SESION: URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    
func crearLlamada<T:Decodable>(url: String,
                               parametros: [String:Any]) -> AnyPublisher<T,Error>{
    SESION.dataTaskPublisher(for: createRequest(url: url,
                                                parametros: parametros))
        .mapError{ error -> Error in
            return error
        }
        .tryMap{ result in
            print(url)
            print("\(String(decoding: result.data , as: UTF8.self))")
            
            guard let response = result.response as? HTTPURLResponse else {
                throw TofyError(reason: "Error de respuesta")
            }
            do {
                if response.statusCode == 200 {
                    let value = try newJSONDecoder().decode(T.self, from: result.data)
                    return value
                } else {
                    let errorValue = try newJSONDecoder().decode(TofyError.self, from: result.data)
                    throw errorValue
                }
            }
            
        }
        .eraseToAnyPublisher()
}

func createRequest(url: String,
                   parametros: [String:Any]) -> URLRequest{
    
    let urlComponents = NSURLComponents(string: url)!
    
    
    
    var urlRequest = URLRequest(url: urlComponents.url!)
    urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    urlRequest.httpMethod = "POST"
    
    //Cabecera
    urlRequest.setValue("AAAAA", forHTTPHeaderField: "authtoken")
    
    //Parametros
    var paramsString = ""
    for (param,value) in parametros{
        paramsString.append("\(param)=\(value)&")
    }
    urlRequest.httpBody = paramsString.data(using: String.Encoding.utf8)
    
    return urlRequest
}
    
struct TofyError: Codable, Error{
    var reason: String
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
