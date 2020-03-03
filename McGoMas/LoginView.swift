//
//  LoginView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    private var padding = 20
    @State private var password: String = ""
    @State private var username: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Username")
                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.bottom, 10)
            HStack {
                Text("Password")
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.bottom, 10)
            //Push the login credentials to the top
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.top, 50)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
