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
        }
    }
    
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}
