//
//  SinPeriodoView.swift
//  TofyWallet
//
//  Created by usuario on 27/1/21.
//

import SwiftUI

struct SinPeriodoView: View {
    
    @State var titulo: String = ""
    @State var ahorroEstimado: String = ""
    var iniciaPeriodo: (_ titulo: String, _ ahorroEstimado: String) -> ()
    
    var body: some View {
        VStack{
            HStack{
                Text("iniciaPeriodoInfo".localized)
                    .infoImportante()
                Spacer()
            }
            .padding(.leading)
            TextField("titulo".localized, text: $titulo)
                .keyboardType(.asciiCapable)
                .foregroundColor(.negro)
                .modifier(CustomEditText(imagen: "a"))
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 8)
            TextField("ahorroEstimado".localized, text: $ahorroEstimado)
                .keyboardType(.numberPad)
                .foregroundColor(.negro)
                .modifier(CustomEditText(imagen: "eurosign.square.fill"))
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 8)
            Button(action: {
                if puedeEmpezarPeriodo(){
                    iniciaPeriodo(titulo, ahorroEstimado)
                }
            }){EmptyView()}.buttonStyle(BotonPrincipal(text: "iniciaPeriodo".localized, enabled: puedeEmpezarPeriodo()))
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8)
        }
    }
    
    func puedeEmpezarPeriodo() -> Bool{
        return titulo != ""
    }
}
