//
//  LoginScreen.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import SwiftUI

struct LoginScreen: View {
    @ObservedObject var loginVM = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment : .leading, spacing: 5) {
                Image("login_image")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.top)
                
                Text("Hello")
                    .padding(.leading)
                    .font(.system(size: 80).bold())
                    .foregroundColor(.black.opacity(20))
                
                Text("Sign in to your account")
                    .padding(.leading)
                    .font(.system(size: 16).bold())
                    .foregroundColor(.gray)
                
                TextField("Enter UserName", text: $loginVM.userName)
                    .padding(.leading)
                    .frame(height: 40)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding([.leading, .trailing, .top], 25)
                
                TextField("Enter Password", text: $loginVM.password)
                    .padding(.leading)
                    .frame(height: 40)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding([.leading, .trailing, .top], 25)
                
                HStack {
                    Spacer()
                    Text("Forgot your Password")
                        
                }
                .padding(.top)
                .padding([.leading, .trailing], 25)
                
                
                Button{
                    loginVM.navigateToEmployeeSelection()
                }label: {
                    HStack {
                        Spacer()
                        Text("SIGN IN")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .font(.callout.bold())
                            .cornerRadius(20)
                        Spacer()
                    }
                }.padding(.top)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("Don't have an account ?")
                        .font(.callout)
                    Text("Create")
                        .font(.callout.bold())
                    Spacer()
                }
            
                
              
            }
            .background(Color.gray.opacity(0.1))
            .background() {
                NavigationLink(destination: EmployeSelection(),
                               isActive: $loginVM.navigateToEmployee,
                               label: { EmptyView() })
                
            }
            
        }
    }
}

#Preview {
    LoginScreen()
}
