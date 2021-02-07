//
//  PeriodoActivoViewModel.swift
//  TofyWallet
//
//  Created by usuario on 29/1/21.
//

import Foundation
import SwiftUI
import Combine


class PeriodoActivoViewModel: ObservableObject{
    
    @Published var diasLabel: String?
    
    func calcularDiasLabel(fechaInicio: String){
        let hoy = Date()
        let inicio = fechaInicio.toDate()
        
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: inicio)
        let date2 = calendar.startOfDay(for: hoy)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        diasLabel = "\(components.day ?? 0)"
    }
    
}
