//
//  EmployeSelection.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import SwiftUI

struct EmployeSelection: View {
    @ObservedObject var emplyeeVM = EmployeeViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                emplyeeVM.navigateCreateEmployee = true
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
        
            
            Button {
                emplyeeVM.navigatePunchIn = true
            } label: {
                Text("Punch In/ out")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding([.leading, .trailing], 16)
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
            }
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.top, 40)
            
            
            Button {
                emplyeeVM.navigateEmployeeSummery = true
            } label: {
                Text("Emplyee Summery")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding([.leading, .trailing], 16)
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
            }
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.top, 40)
            

            Spacer()
        }
        .navigationTitle("Employee Selection")
        .padding([.leading, .trailing], 16)
        .background() {
            NavigationLink(destination: CreateEmployee(),
                           isActive: $emplyeeVM.navigateCreateEmployee,
                           label: { EmptyView() })
            
            NavigationLink(destination: EmployeePunchIn(),
                           isActive: $emplyeeVM.navigatePunchIn,
                           label: { EmptyView() })
            
            NavigationLink(destination: EmployeeSummery(),
                           isActive: $emplyeeVM.navigateEmployeeSummery,
                           label: { EmptyView() })
        }

    }
}

#Preview {
    NavigationView {
        EmployeSelection()
    }
  
}
