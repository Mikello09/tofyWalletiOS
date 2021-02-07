//
//  Extensions.swift
//  TofyWallet
//
//  Created by usuario on 21/1/21.
//

import Foundation
import SwiftUI

extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func toCategoriaTipo() -> TipoCategoria{
        switch self {
        case "Gasto":
            return .gasto
        default:
            return .ingreso
        }
    }
    
    func toDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from:self) ?? Date()
        return date
    }
    
    func toDateStringFormat() -> String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        let showDate = inputFormatter.date(from: self)
        inputFormatter.locale = .init(identifier: "es_ES")
        inputFormatter.dateFormat = "MMM dd, yy"
        let resultString = inputFormatter.string(from: showDate ?? Date())
        return resultString
    }
    
    func toNumber() -> CGFloat{
        guard let number = NumberFormatter().number(from: self) else {
            return 0
        }
        return CGFloat(truncating: number)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension Date{
    func toString() -> String{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: self)
        return "\(components.day ?? 0)-\(components.month ?? 0)-\(components.year ?? 0)"
    }
}
