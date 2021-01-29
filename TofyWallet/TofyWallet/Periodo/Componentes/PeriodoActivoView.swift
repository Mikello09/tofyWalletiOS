//
//  PeriodoActivoView.swift
//  TofyWallet
//
//  Created by usuario on 29/1/21.
//

import SwiftUI

struct PeriodoActivoView: View {
    
    @ObservedObject var viewModel: PeriodoActivoViewModel = PeriodoActivoViewModel()
    
    var periodo: Periodo
    @Binding var barras: [BarraItem]
    var finalizarPeriodo: () -> ()
    
    @State var diasLabel: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Text(periodo.titulo ?? "")
                        .infoImportante()
                    Spacer()
                    Text(diasLabel)
                        .setStyle(font: .semibold, size: 16, color: .negro)
                    Text("\("desde".localized) \(periodo.fechaInicio ?? "")")
                        .setStyle(font: .regular, size: 16, color: .negro)
                }
                .padding(8)
                HStack{
                    VStack{
                        BarrasChart(values: $barras)
                            .padding([.leading, .bottom], 8)
                    }
                    .frame(width: geometry.size.width * 0.6)
                    .frame(maxHeight: .infinity)
                    Spacer()
                    VStack{
                        HStack{
                            Text("ahorroEstimado".localized)
                                .setStyle(font: .semibold, size: 14, color: .negro)
                            Spacer()
                        }
                        Text(periodo.ahorroEstimado ?? "")
                            .setStyle(font: .regular, size: 16, color: .negro)
                        HStack{
                            Text("ahorroActual".localized)
                                .setStyle(font: .semibold, size: 14, color: .negro)
                            Spacer()
                        }
                        Text(String(format: "%.2f", barras[0].valor - barras[1].valor))
                            .setStyle(font: .regular, size: 16, color: .negro)
                        Spacer()
                        Button(action: {
                            
                        }){EmptyView()}.buttonStyle(BotonEliminar(text: "Fin periodo"))
                        .padding(8)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear{
            viewModel.calcularDiasLabel(fechaInicio: periodo.fechaInicio ?? "")
        }
        .onReceive(viewModel.$diasLabel){ value in
            if let dias = value{
                self.diasLabel = dias
            }
        }
    }
}
