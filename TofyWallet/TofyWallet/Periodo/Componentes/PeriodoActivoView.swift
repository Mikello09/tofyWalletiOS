//
//  PeriodoActivoView.swift
//  TofyWallet
//
//  Created by usuario on 29/1/21.
//

import SwiftUI

struct PeriodoActivoView: View {
    
    @ObservedObject var viewModel: PeriodoActivoViewModel = PeriodoActivoViewModel()
    
    @Binding var periodo: Periodo
    @Binding var barras: [BarraItem]
    @Binding var anadirMovimiento: Bool
    var finalizarPeriodo: () -> ()
    
    @State var diasLabel: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Text(periodo.titulo ?? "")
                        .infoImportante()
                    Spacer()
                    Text("\("desde".localized): ")
                        .setStyle(font: .regular, size: 16, color: .negro)
                    + Text("\(periodo.fechaInicio?.toDateStringFormat() ?? "")")
                        .setStyle(font: .semibold, size: 16, color: .negro)
                    Button(action: {
                        finalizarPeriodo()
                    }){EmptyView()}.buttonStyle(BotonFin(text: "fin".localized))
                }
                .padding([.leading, .trailing, .top],8)
                HStack{
                    VStack{
                        BarrasChart(values: $barras)
                            .padding(.leading, 8)
                        Spacer()
                        HStack{
                            Text("\("ahorroEstimado".localized): ")
                                .setStyle(font: .regular, size: 14, color: .negro)
                            + Text("\(periodo.ahorroEstimado ?? "") €")
                                .setStyle(font: .semibold, size: 14, color: .negro)
                            Spacer()
                        }
                        .padding([.leading, .bottom],8)
                    }
                    .frame(width: geometry.size.width * 0.6)
                    .frame(maxHeight: .infinity)
                    Spacer()
                    VStack{
                        Spacer()
                        ZStack{
                            Image("calendar_icon")
                                .resizable()
                                .foregroundColor(.principal)
                                .frame(width: 60, height: 60)
                            Text(diasLabel)
                                .setStyle(font: .heavy, size: 24, color: .principal)
                                .padding(.top, 4)
                        }
                        Spacer()
                        Button(action: {
                            anadirMovimiento = true
                        }){EmptyView()}.buttonStyle(BotonPrincipal(text: "Añadir \n movimiento", enabled: true))
                        .padding([.leading, .trailing],8)
                        .padding(.bottom, 36)
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
