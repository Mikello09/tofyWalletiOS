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
    
    //PERIODO ACTIVO
    @State var barras: [BarraItem] = [BarraItem(titulo: "Ingresos", valor: 1200, color: .verde),
                                      BarraItem(titulo: "Gastos", valor: 200, color: .rojo)]
    @State var periodo: Periodo = Periodo(titulo: "Enero 2021", ahorroEstimado: "300", fechaInicio: "01-01-2021", fechaFin: "")
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    if estado == .sinGrupo{
                        SinGrupoView()
                    } else if estado == .sinPeriodoActivo{
                        SinPeriodoView(iniciaPeriodo: iniciaPeriodo)
                    } else {
                        PeriodoActivoView(periodo: periodo, barras: $barras, finalizarPeriodo: finalizarPeriodo)
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
    
    func iniciaPeriodo(titulo: String, ahorroEstimado: String){
        showLoader = true
        viewModel.iniciarPeriodo(titulo: titulo, ahorroEstimado: ahorroEstimado)
    }
    
    func finalizarPeriodo(){
        
    }
}
