//
//  BaseView.swift
//  TofyWallet
//
//  Created by usuario on 21/1/21.
//

import SwiftUI

struct BaseView<Content>: View where Content: View{
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showLoader: Bool
    @Binding var showError: Bool
    @Binding var errorMessage: String
    
    var content: Content
    var titulo: String?
    var atras: Bool = true
    
    var body: some View {
        ZStack{
            if titulo != nil{
                if atras {
                    content
                        .navigationBarColor(.principal, titulo ?? "", goBack)
                } else {
                    content
                        .navigationBarColorWithoutBack(.principal, titulo ?? "")
                }
                
            } else {
                content
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
                    .navigationBarBackButtonHidden(true)
            }
            if showLoader{
                VStack{
                    Spacer()
                    LottieView(name: "loading", play: .constant(1), loopFinished: nil)
                        .frame(width: 300, height: 300)
                        .padding()
                    Spacer()
                }
            }
            if showError{
                ZStack{
                    Color.grisTransparente
                    VStack{
                        Spacer()
                        VStack{
                            Image(systemName: "xmark.octagon.fill")
                                .resizable()
                                .foregroundColor(.rojo)
                                .frame(width: 32, height: 32)
                                .padding()
                            Text(errorMessage)
                                .info()
                                .padding([.leading, .trailing])
                            Button(action: {
                                showError.toggle()
                            }){EmptyView()}.buttonStyle(BotonPrincipal(text: "aceptar".localized, enabled: true))
                            .padding()
                        }
                        .background(Color.blanco)
                        .cornerRadius(3)
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
    
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}
