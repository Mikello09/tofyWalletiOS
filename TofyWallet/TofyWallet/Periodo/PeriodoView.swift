//
//  Periodo.swift
//  TofyWallet
//
//  Created by usuario on 22/1/21.
//

import SwiftUI

struct PeriodoView: View {
    
    @ObservedObject var viewModel: PeriodoViewModel = PeriodoViewModel()
    
    @State var estado: EstadoUsuario = .sinGrupo
    
    @Binding var showLoader: Bool
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    if estado == .sinGrupo{
                        SinGrupoView()
                    } else if estado == .sinPeriodoActivo{
                        
                    } else {
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250)
            }
            .background(Color.blanco)
            .cornerRadius(5.0)
            .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
            .padding()
            if estado == .conPeriodoActivo{
                
            }
            Spacer()
        }
        .onAppear{
            viewModel.getEstado()
        }
        .onReceive(viewModel.$estadoUsuario){ value in
            if let estadoUsuario = value{
                self.estado = estadoUsuario
            }
        }
    }
}
