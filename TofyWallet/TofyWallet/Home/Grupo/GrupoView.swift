//
//  GrupoView.swift
//  TofyWallet
//
//  Created by usuario on 24/1/21.
//

import SwiftUI

struct GrupoView: View {
    
    @ObservedObject var viewModel: GrupoViewModel = GrupoViewModel()
    
    @State var estado: GrupoEstado?
    
    //UNIR GRUPO
    @State var idGrupo: String = ""
    @State var errorUnirGrupo: String = ""
    
    //CREAR GRUPO
    @State var nombreGrupo: String = ""
    @State var ahorroInicial: String = ""
    @State var errorCrearGrupo: String = ""
    
    @State var showLoader: Bool = false
    
    var body: some View {
        BaseView(showLoader: $showLoader, content:
            VStack{
                if estado == nil{
                    EmptyView()
                } else {
                    if estado! != .conGrupo{
                        Text("uneteOcrea".localized)
                            .info()
                            .padding()
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                        HStack{
                            Button(action: {
                                estado = .unirGrupo
                            }){EmptyView()}.buttonStyle(BotonCambianteConImagen(texto: "unete".localized,
                                                                       seleccionado: estado! == .unirGrupo,
                                                                       imagen: "add_to_group"))
                            .padding()
                            Button(action: {
                                estado = .anadirGrupo
                            }){EmptyView()}.buttonStyle(BotonCambianteConImagen(texto: "crea".localized,
                                                                       seleccionado: estado! == .anadirGrupo,
                                                                       imagen: "add_group"))
                            .padding()
                        }
                        if estado == .unirGrupo{//UNIR GRUPO
                            TextField("idGrupo".localized, text: $idGrupo)
                                .foregroundColor(.negro)
                                .modifier(CustomEditText(imagen: "tag.fill"))
                                .padding([.leading, .trailing])
                            HStack{
                                Text(errorUnirGrupo)
                                    .error()
                                    .padding(.leading)
                                Spacer()
                            }
                            Button(action: {
                                if idGrupo != ""{
                                    viewModel.unirGrupo(id: idGrupo)
                                }
                            }){EmptyView()}.buttonStyle(BotonPrincipal(text: "guardar".localized, enabled: idGrupo != ""))
                            .padding([.leading, .trailing])
                        } else {//AÑADIR GRUPO
                            TextField("nombreGrupo".localized, text: $nombreGrupo)
                                .foregroundColor(.negro)
                                .modifier(CustomEditText(imagen: "a"))
                                .padding([.leading, .trailing])
                            TextField("ahorroInicial".localized, text: $ahorroInicial)
                                .keyboardType(.decimalPad)
                                .foregroundColor(.negro)
                                .modifier(CustomEditText(imagen: "eurosign.square.fill"))
                                .padding([.leading, .trailing])
                            HStack{
                                Text(errorCrearGrupo)
                                    .error()
                                    .padding(.leading)
                                Spacer()
                            }
                            Button(action: {
                                if nombreGrupo != ""{
                                    viewModel.crearGrupo(nombre: nombreGrupo, ahorro: ahorroInicial)
                                }
                            }){EmptyView()}.buttonStyle(BotonPrincipal(text: "guardar".localized, enabled: nombreGrupo != ""))
                            .padding([.leading, .trailing])
                        }
                    } else {//CON GRUPO
                         
                    }
                }
                Spacer()
            },
                 titulo: "grupo".localized
        )
        .onAppear{
            viewModel.getGrupoEstado()
        }
        .onReceive(viewModel.$estado){ value in
            estado = value
        }
    }
}

struct GrupoView_Previews: PreviewProvider {
    static var previews: some View {
        GrupoView()
    }
}
