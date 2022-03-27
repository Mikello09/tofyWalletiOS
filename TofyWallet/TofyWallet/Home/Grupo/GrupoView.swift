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
    
    //GRUPO
    @State var grupo: Grupo = Grupo()
    @State var preguntaAbandornarGrupo: Bool = false
    
    //BASEVIEW
    @State var showLoader: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        BaseView(showLoader: $showLoader, showError: $showError, errorMessage: $errorMessage,  content:
            ZStack{
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
                                        showLoader = true
                                        viewModel.unirGrupo(id: idGrupo)
                                    }
                                }){EmptyView()}.buttonStyle(BotonPrincipal(text: "unirBoton".localized, enabled: idGrupo != ""))
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
                                        showLoader = true
                                        viewModel.crearGrupo(nombre: nombreGrupo, ahorro: ahorroInicial)
                                    }
                                }){EmptyView()}.buttonStyle(BotonPrincipal(text: "crearBoton".localized, enabled: nombreGrupo != ""))
                                .padding([.leading, .trailing])
                            }
                        } else {//CON GRUPO
                            ConGrupoView(grupo: $grupo,
                                         anadirCategoria: anadirCategoria,
                                         editarCategoria: editarCategoria,
                                         abandonarGrupo: estasSeguroDeAbandonar)
                        }
                    }
                    //Spacer()
                }
                if preguntaAbandornarGrupo{
                    SiNoPopup(titulo: "\("preguntarAbandonar".localized) \(grupo.nombre ?? "")?", si: abandonarGrupo, no: noAbandonarGrupo)
                }
            }
            .ignoresSafeArea(.all, edges: preguntaAbandornarGrupo ? [.bottom, .top] : .bottom)
            .onTapGesture {
                self.hideKeyboard()
            },titulo: "grupo".localized
        )
        .onAppear{
            viewModel.getGrupoEstado()
        }
        .onReceive(viewModel.$estado){ value in
            showLoader = false
            estado = value
        }
        .onReceive(GrupoManager.shared.$token){ value in
            if let token = value{
                showLoader = false
                self.grupo.token = token
            }
        }
        .onReceive(GrupoManager.shared.$ahorro){ value in
            if let ahorro = value{
                showLoader = false
                self.grupo.ahorro = ahorro
            }
        }
        .onReceive(GrupoManager.shared.$nombre){ value in
            if let nombre = value{
                showLoader = false
                self.grupo.nombre = nombre
            }
        }
        .onReceive(GrupoManager.shared.$miembros){ value in
            if let miembros = value{
                showLoader = false
                self.grupo.miembros = miembros
            }
        }
        .onReceive(GrupoManager.shared.$categorias){ value in
            if let categorias = value{
                showLoader = false
                self.grupo.categorias = categorias
            }
        }
        .onReceive(viewModel.$error){ value in
            if let error = value{
                showLoader = false
                errorMessage = error
                showError = true
            }
        }
    }
    
    func anadirCategoria(categoria: Categoria){
        showLoader = true
        viewModel.addCategoria(categoria: categoria)
    }
    
    func editarCategoria(categoria: Categoria){
        showLoader = true
        viewModel.editarCategoria(categoria: categoria)
    }
    
    func estasSeguroDeAbandonar(){
        preguntaAbandornarGrupo = true
    }
    
    func abandonarGrupo(){
        preguntaAbandornarGrupo = false
        showLoader = true
        viewModel.abandonarGrupo()
    }
    
    func noAbandonarGrupo(){
        preguntaAbandornarGrupo = false
    }
}

struct GrupoView_Previews: PreviewProvider {
    static var previews: some View {
        GrupoView()
    }
}
