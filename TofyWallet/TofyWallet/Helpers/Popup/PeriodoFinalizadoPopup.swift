//
//  PeriodoFinalizadoPopup.swift
//  TofyWallet
//
//  Created by Marilyn Mishelle Garcia Tenesaca on 7/2/21.
//

import SwiftUI

struct PeriodoFinalizadoPopup: View {
    
    var periodo: Periodo?
    @Binding var periodoFinalizadoPopupShowed: Bool
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color.grisTransparente
                VStack{
                    Spacer()
                    VStack{
                        Text("periodoFinalizado".localized)
                            .setStyle(font: .semibold, size: 28, color: .principal)
                            .padding()
                        HStack{
                            Text(periodo?.fechaInicio?.toDateStringFormat() ?? "")
                                .setStyle(font: .semibold, size: 18, color: .negro)
                            +
                            Text(" -> ")
                                .setStyle(font: .regular, size: 18, color: .negro)
                            +
                                Text(periodo?.fechaFin?.toDateStringFormat() ?? "")
                                .setStyle(font: .semibold, size: 18, color: .negro)
                        }
                        .padding([.leading, .trailing])
                        Text("ahorroEstimado".localized)
                            .setStyle(font: .regular, size: 18, color: .negro)
                            .padding(.top, 8)
                        Text("\(periodo?.ahorroEstimado ?? "")€")
                            .setStyle(font: .semibold, size: 18, color: .negro)
                        Text("ahorroFinal".localized)
                            .setStyle(font: .regular, size: 18, color: .negro)
                            .padding(.top,8)
                        Text("\(periodo?.ahorroFinal ?? "")€")
                            .setStyle(font: .semibold, size: 21, color: .verde)
                        Button(action: {
                            periodoFinalizadoPopupShowed = false
                        }){EmptyView()}.buttonStyle(BotonPrincipal(text: "aceptar".localized, enabled: true))
                        .padding()
                    }
                    .background(Color.blanco)
                    .cornerRadius(3)
                    Spacer()
                }
                .padding()
                LottieView(name: "congratulation", play: .constant(1), loopFinished: nil )
                    .onTapGesture {
                        periodoFinalizadoPopupShowed = false
                    }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
