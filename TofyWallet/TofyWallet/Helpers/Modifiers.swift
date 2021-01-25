//
//  Modifiers.swift
//  TofyWallet
//
//  Created by usuario on 21/1/21.
//

import Foundation
import SwiftUI



//EDIT TEXT
struct CustomEditText: ViewModifier{
    
    var imagen: String = ""
    
    init(imagen: String = ""){
        self.imagen = imagen
    }
    
    func body(content: Content) -> some View{
        return
            ZStack{
                content
                if imagen != ""{
                    HStack{
                        Spacer()
                        Image(systemName: imagen)
                            .foregroundColor(.principal)
                    }
                }
            }
            .padding()
            .frame(height: 48)
            .background(Color.blanco)
            .cornerRadius(3)
            .shadow(radius: 3)
            .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.principal, lineWidth: 1))
    }
    
}

//NAVIGATION BAR
extension View {
    func navigationBarColor(_ backgroundColor: UIColor?, _ titulo: String, _ backAction: @escaping () -> ()) -> some View {
        self.modifier(TofyNavigator(backgroundColor: backgroundColor, titulo: titulo, backAction: backAction))
    }
    func navigationBarColorWithoutBack(_ backgroundColor: UIColor?, _ titulo: String) -> some View {
        self.modifier(TofyNavigatorWithoutBack(backgroundColor: backgroundColor, titulo: titulo))
    }
}

struct TofyNavigator: ViewModifier{
    
    var backgroundColor: UIColor?
    var titulo: String
    var backAction: () -> ()
        
    init(backgroundColor: UIColor?, titulo: String, backAction: @escaping()->()) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        
        self.titulo = titulo
        self.backAction = backAction
    }
    
    func body(content: Content) -> some View{
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarTitle(titulo, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { self.backAction() }) {
              Image(systemName: "chevron.left")
                .foregroundColor(.blanco)
                .imageScale(.large)
            })
    }
}

struct TofyNavigatorWithoutBack: ViewModifier{
    
    var backgroundColor: UIColor?
    var titulo: String
        
    init(backgroundColor: UIColor?, titulo: String) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        
        self.titulo = titulo
    }
    
    func body(content: Content) -> some View{
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarTitle(titulo, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

