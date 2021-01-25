//
//  CategoriasImagenPopup.swift
//  TofyWallet
//
//  Created by usuario on 25/1/21.
//

import SwiftUI

struct CategoriasImagenPopup: View {
    
    @ObservedObject var viewModel: CategoriasImagenesViewModel = CategoriasImagenesViewModel()
    
    @Binding var imagenPopupShowed: Bool
    @State var imagenes: [CategoriaImage] = []
    var imagenSeleccionada: (_ imagen: CategoriaImage) -> ()
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color.grisTransparente
                VStack{
                    Spacer()
                    VStack{
                        Text("eligeImagenCategoria".localized)
                            .info()
                            .padding()
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), alignment: .center), count: 4)){
                                ForEach(imagenes, id: \.self){ imagen in
                                    VStack{
                                        VStack{
                                            Image(systemName: imagen.getImage())
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                                .foregroundColor(.principal)
                                        }
                                        .frame(width: 50, height: 50)
                                    }
                                    .background(Color.blanco)
                                    .cornerRadius(5.0)
                                    .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                                    .padding()
                                    .onTapGesture {
                                        self.imagenSeleccionada(imagen)
                                        self.imagenPopupShowed.toggle()
                                    }
                                }
                            }
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
        .onAppear{
            viewModel.getImagenes()
        }
        .onReceive(viewModel.$imagenes){ value in
            self.imagenes = value
        }
    }
}
