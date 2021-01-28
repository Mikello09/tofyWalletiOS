//
//  SinGrupoHomeView.swift
//  TofyWallet
//
//  Created by usuario on 27/1/21.
//

import SwiftUI

struct SinGrupoView: View {
    var body: some View {
        VStack{
            Text("uneteOcrea".localized)
                .info()
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding()
            HStack{
                Image("add_to_group")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .padding()
                Image("add_group")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .padding()
            }
//            Button(action: {
//                
//            }){EmptyView()}.buttonStyle(BotonPrincipal(text: "grupo".localized, enabled: true))
//            .padding()
        }
    }
}

