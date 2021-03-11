//
//  HistoricoViewModel.swift
//  TofyWallet
//
//  Created by Mikel on 9/2/21.
//

import Foundation
import Combine
import SwiftUI


class HistoricoViewModel: ObservableObject{
    
    @Published var years: [Int]?
    @Published var generalCategorias: [Categoria]?
    
    
    func getYears(){
        var anos: [Int] = []
        for periodo in GrupoManager.shared.periodos ?? []{
            let ano = periodo.fechaInicio?.toDate().getYearFromDate() ?? 0
            if anos.isEmpty{
                anos.append(ano)
            } else {
                if !anos.contains(ano){
                    anos.append(ano)
                }
            }
        }
        self.years = anos
    }
    
    func getGeneralCategorias(){
        var general: [Categoria] = []
        general.append(Categoria(token: "ahorro", titulo: "Ahorro", imagen: "", tipo: ""))
        general.append(Categoria(token: "gasto", titulo: "Gasto", imagen: "", tipo: ""))
        general.append(Categoria(token: "ingreso", titulo: "Ingreso", imagen: "", tipo: ""))
        self.generalCategorias = general
    }
    
    func getGraficoColor(index: Int) -> Color{
        switch index {
        case 0: return .azul
        case 1: return .amarillo
        case 2: return .rosa
        case 3: return .gris
        case 4: return .morado
        case 5: return .turquesa
        case 6: return .azulOscuro
        case 7: return .naranja
        case 8: return .piel
        case 9 : return .blanco
        case 10: return .marron
        case 11: return .verdeFosforito
        default:return .negro
        }
    }
}
