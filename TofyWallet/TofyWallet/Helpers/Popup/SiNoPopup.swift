//
//  SiNoPopup.swift
//  TofyWallet
//
//  Created by usuario on 27/1/21.
//

import SwiftUI

struct SiNoPopup: View {
    
    var titulo: String
    var si: () -> ()
    var no: ()->()
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color.grisTransparente
                VStack{
                    Spacer()
                    VStack{
                        Text(titulo)
                            .info()
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .padding([.top, .leading, .trailing])
                        HStack{
                            Button(action: {
                                si()
                            }){EmptyView()}.buttonStyle(BotonEleccion(text: "si".localized, color: .rojo))
                            .padding()
                            Button(action: {
                                no()
                            }){EmptyView()}.buttonStyle(BotonEleccion(text: "no".localized, color: .verde))
                            .padding()
                        }
                    }
                    .background(Color.blanco)
                    .cornerRadius(3)
                    Spacer()
                }
                .padding()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
