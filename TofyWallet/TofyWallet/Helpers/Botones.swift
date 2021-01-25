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

struct BotonCambianteConImagen: ButtonStyle{

    var texto: String
    var seleccionado: Bool
    var imagen: String

    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            if seleccionado{
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.principal, lineWidth: 1)
                    .foregroundColor(.blanco)
            } else {
                Rectangle()
                    .cornerRadius(3)
                    .shadow(radius: 3)
                    .foregroundColor(.blanco)
            }
            VStack{
                Image(imagen)
                    .resizable()
                    .frame(width: 32, height: 32)
                Text(texto)
                    .info()
                    .foregroundColor(.negro)
                    .font(.custom("SourceSansPro-SemiBold", size: 18.0))
                    .multilineTextAlignment(.center)
            }
            
        }
        .frame(height: BUTTON_HEIGHT*2)
    }
}
