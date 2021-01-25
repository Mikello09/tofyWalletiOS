//
//  TextView.swift
//  TofyWallet
//
//  Created by usuario on 21/1/21.
//

import Foundation
import SwiftUI


extension Text{
    
    func titulo(color: Color) -> Text{
        return self
            .font(.system(size: 24, weight: .semibold, design: .default))
            .foregroundColor(color)
    }
    
    func subtitulo(color: Color) -> Text{
        return self
            .font(.system(size: 21, weight: .semibold, design: .default))
            .foregroundColor(color)
    }
    
    func item(color: Color) -> Text{
        return self
            .font(.system(size: 18, weight: .semibold, design: .default))
            .foregroundColor(color)
    }
    
    func info() -> Text{
        return self
            .font(.system(size: 16))
            .foregroundColor(Color.negro)
    }
    
    func infoImportante() -> Text{
        return self
            .font(.system(size: 18, weight: .semibold, design: .default))
            .foregroundColor(.negro)
    }
    
    func error() -> Text{
        return self
            .font(.system(size: 14))
            .foregroundColor(Color.rojo)
    }
    
    func boton() -> Text{
        return self
            .font(.system(size: 16, weight: .semibold, design: .default))
            .foregroundColor(Color.principal)
    }
    
}
