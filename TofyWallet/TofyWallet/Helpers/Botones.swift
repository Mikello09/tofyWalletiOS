//
//  Botones.swift
//  TofyWallet
//
//  Created by usuario on 21/1/21.
//

import Foundation
import SwiftUI


let BUTTON_HEIGHT: CGFloat = 48

struct BotonPrincipal: ButtonStyle {
    
    var text = ""
    var enabled = true
    var color : UIColor = .white
    

    init(text: String, enabled : Bool) {
        
        self.text = text
        self.enabled = enabled
        
        if enabled {
            self.color = UIColor.principal
        }else {
            self.color = UIColor.gris
        }
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(CGFloat(3.0))
                .foregroundColor(Color.init(self.color))
            
            Text(text)
                .foregroundColor(.blanco)
                .font(.system(size: 18, weight: .bold, design: .default))
        }.frame(height: BUTTON_HEIGHT)
    }
}
