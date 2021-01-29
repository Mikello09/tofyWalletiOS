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
        
        diasLabel = "\(components.day ?? 0) \(components.day == 0 ? "dia".localized : "dias".localized)"
    }
    
}

extension String{
    func toDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from:self)!
        return date
    }
}

extension Date{
    func toString() -> String{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: self)
        return "\(components.day ?? 0)-\(components.month ?? 0)-\(components.year ?? 0)"
    }
}
