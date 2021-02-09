//
//  HistoricoView.swift
//  TofyWallet
//
//  Created by usuario on 22/1/21.
//

import SwiftUI

struct HistoricoView: View {
    
    @ObservedObject var viewModel: HistoricoViewModel = HistoricoViewModel()
    
    //YEARS
    @State var years: [Int] = []
    @State var yearSelected: Int = 0
    
    //CATEGORIAS
    @State var categorias: [Categoria] = []
    @State var categoriaSelected: Int = 0
    
    //BARRAS
    
    @State var barras: [BarrasChart] = []
    
    @Binding var showLoader: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Group{
                    HStack{
                        Text("ano".localized)
                            .setStyle(font: .semibold, size: 16, color: .negro)
                            .padding([.leading, .top])
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 0){
                            ForEach(Array(years.enumerated()), id: \.offset){ offset, year in
                                SelectableBoxItem(selectedIndex: $yearSelected,
                                                  index: offset,
                                                  seleccionado: yearSelected,
                                                  titulo: "\(year)",
                                                  imagen: "")
                            }
                        }
                    }
                }
                Group{
                    HStack{
                        Text("elegirGrafico".localized)
                            .setStyle(font: .semibold, size: 16, color: .negro)
                            .padding([.leading])
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 0){
                            ForEach(Array(categorias.enumerated()), id: \.offset){ offset, categoria in
                                SelectableBoxItem(selectedIndex: $categoriaSelected,
                                                  index: offset,
                                                  seleccionado: categoriaSelected,
                                                  titulo: categoria.titulo ?? "",
                                                  imagen: categoria.imagen?.toSystemImage() ?? "")
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .onAppear{
            viewModel.getYears()
        }
        .onReceive(viewModel.$years){ value in
            if let anos = value{
                self.years = anos
            }
        }
        .onReceive(GrupoManager.shared.$categorias){ value in
            if let categoriasGrupo = value{
                self.categorias = categoriasGrupo
            }
        }
        .onReceive(GrupoManager.shared.$periodos){ value in
            
        }
    }
    
    func calculateBarras(){
        var barrasAmostrar: [BarrasChart] = []
        
        self.barras = barrasAmostrar
    }
    
    func yearSelected(index: Int){
        yearSelected = index
    }
    
    func categoriaSelected(index: Int){
        categoriaSelected = index
    }
}
