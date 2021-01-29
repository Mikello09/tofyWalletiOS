//
//  ElegirCategoriaView.swift
//  TofyWallet
//
//  Created by usuario on 29/1/21.
//

import SwiftUI

struct ElegirCategoriaView: View {
    
    @Binding var categoriaElegida: Categoria?
    @Binding var isPresenting: Bool
    
    @State var categorias: [Categoria] = []
    
    var body: some View {
        VStack{
            Text("elegirCategoria".localized)
                .padding()
            ScrollView(.vertical, showsIndicators: false){
                ForEach(categorias, id: \.self){ categoria in
                    CategoriaItem(categoria: categoria)
                        .onTapGesture {
                            self.categoriaElegida = categoria
                            self.isPresenting = false
                        }
                }
            }
            Spacer()
        }
        .onReceive(GrupoManager.shared.$categorias){ value in
            if let categoriasGrupo = value{
                self.categorias = categoriasGrupo
            }
        }
    }
}
