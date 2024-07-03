//
//  CreateEmployee.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import SwiftUI

struct CreateEmployee: View {
    @ObservedObject var employeeVM = EmployeeViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Employee Name", text: $employeeVM.empName)
                .padding(.leading)
                .frame(height: 40)
                .background(Color.white)
                .cornerRadius(20)
                .padding([.leading, .trailing, .top], 25)
            
            TextField("Employee No", text: $employeeVM.empNo)
                .padding(.leading)
                .frame(height: 40)
                .background(Color.white)
                .cornerRadius(20)
                .padding([.leading, .trailing, .top], 25)
            
            TextField("Department", text: $employeeVM.department)
                .padding(.leading)
                .frame(height: 40)
                .background(Color.white)
                .cornerRadius(20)
                .padding([.leading, .trailing, .top], 25)
            
            TextField("Address", text: $employeeVM.address)
                .padding(.leading)
                .frame(height: 40)
                .background(Color.white)
                .cornerRadius(20)
                .padding([.leading, .trailing, .top], 25)
            
            Button {
                employeeVM.saveEmployee() { flag, msg in
                    if flag {
                        self.presentationMode.wrappedValue.dismiss()
                    }else {
                        print(msg)
                    }
                }
               
            } label: {
                Text("Create Employee")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding([.leading, .trailing], 16)
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
            }
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.top, 40)
            .padding([.leading, .trailing])
            
            Spacer()
        }
        .toastView(toast: $employeeVM.toast)
        .background(Color.gray.opacity(0.1))
            .onAppear() {
                employeeVM.fetchItems()
            }
       
    }
}

#Preview {
    CreateEmployee()
}
