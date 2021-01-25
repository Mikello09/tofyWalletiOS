//
//  CategoriasImagenesViewModel.swift
//  TofyWallet
//
//  Created by usuario on 25/1/21.
//

import Foundation
import SwiftUI
import Combine


enum CategoriaImage: String{
    case comida = "comida"
    case deporte = "deporte"
    case casa = "case"
    case persona = "persona"
    case ocio = "ocio"
    case restaurante = "restaurante"
    case telefono = "telefono"
    case transporte = "transporte"
    case coche = "coche"
    case viajes = "viajes"
    case amigos = "amigos"
    case hipoteca = "hipoteca"
    case medicina = "medicina"
    case libros = "libros"
    case entradas = "entradas"
    case estudio = "estudio"
    case musica = "musica"
    case ropa = "ropa"
    case regalos = "regalos"
    case juegos = "juegos"
    case herramientas = "herramientas"
    case bicicleta = "bicicleta"
    case interrogante = "interrogante"
    
    func getImage() -> String{
        switch self {
        case .comida: return "cart.fill"
        case .deporte: return "sportscourt.fill"
        case .casa: return "house.fill"
        case .persona: return "person.fill"
        case .ocio: return "die.face.5.fill"
        case .restaurante: return "ant.fill"
        case .telefono: return "phone.fill"
        case .transporte: return "tram.fill"
        case .coche: return "car.fill"
        case .viajes: return "airplane"
        case .amigos: return "person.3.fill"
        case .hipoteca: return "creditcard.fill"
        case .medicina: return "bandage.fill"
        case .libros: return "books.vertical.fill"
        case .entradas: return "ticket.fill"
        case .estudio: return "graduationcap.fill"
        case .musica: return "music.quarternote.3"
        case .ropa: return "eyebrow"
        case .regalos: return "gift.fill"
        case .juegos: return "gamecontroller.fill"
        case .herramientas: return "wrench.and.screwdriver"
        case .bicicleta: return "bicycle"
        case .interrogante: return "questionmark.circle.fill"
        }
    }
}

class CategoriasImagenesViewModel: ObservableObject{
    
    @Published var imagenes: [CategoriaImage] = []
    
    
    func getImagenes(){
        imagenes = [.comida,
                    .deporte,
                    .casa,
                    .persona,
                    .ocio,
                    .restaurante,
                    .telefono,
                    .transporte,
                    .coche,
                    .viajes,
                    .amigos,
                    .hipoteca,
                    .medicina,
                    .libros,
                    .entradas,
                    .estudio,
                    .musica,
                    .ropa,
                    .regalos,
                    .juegos,
                    .herramientas,
                    .bicicleta,
                    .interrogante]
    }
    
    
    
}
