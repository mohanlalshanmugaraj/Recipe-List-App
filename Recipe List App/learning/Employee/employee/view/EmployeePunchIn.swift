//
//  EmployeePunchIn.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import SwiftUI

struct EmployeePunchIn: View {
    @ObservedObject var employeeVM = EmployeeViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment : .leading) {
            Picker("Select an option", selection: $employeeVM.selectedEmpId) {
                ForEach(employeeVM.employeeDropDown, id: \.id) {
                    Text($0.empName)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding([.leading, .trailing, .top], 25)
                        .onChange(of: employeeVM.selectedEmpId, perform: { newValue in
                            if !newValue.isEmpty {
                                employeeVM.getPunchEntryById(id: newValue)
                            }
                        })
            
            if employeeVM.punchStatus != .completed && employeeVM.selectedEmpId != "00" {
                
                
                DatePicker("Punch In Date",
                           selection: $employeeVM.punchInTime,
                           displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(CompactDatePickerStyle())
                .padding([.leading, .trailing, .top], 25)
                .disabled(employeeVM.punchStatus == .punchOut)
                
                if (employeeVM.punchStatus == .punchOut) {
                    DatePicker("Punch Out Date",
                               selection: $employeeVM.punchOutTime,
                               displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding([.leading, .trailing, .top], 25)
                }
                
                Button {
                    self.employeeVM.savePunchData(){ flag, msg in
                        if flag {
                            employeeVM.toast = Toast(style: .success, message: "Please select employee name")
                            self.presentationMode.wrappedValue.dismiss()
                        }else {
                            employeeVM.toast = Toast(style: .error, message: msg)
                        }
                    }
                    
                } label: {
                    Text(employeeVM.punchStatus == .punchIn ? "Punch In" : "Punch Out")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .padding([.leading, .trailing], 16)
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                }
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.top, 40)
                .padding([.leading, .trailing])
                
            }else {
                HStack {
                    Spacer()
                    Text("Today Punch In/Out Completed by this employee")
                        .padding([.leading, .trailing, .top], 25)
                    Spacer()
                }
            }
            Spacer()
        }
        .toastView(toast: $employeeVM.toast)
        .background(Color.gray.opacity(0.1))
        .navigationTitle("Punch In/Out")
        .onAppear() {
            employeeVM.fetchEmployeeNames()
        }
      
       
    }
}

#Preview {
    NavigationView {
        EmployeePunchIn()
    }
}


struct AppTextField : View {
    @State var title : String
    @Binding var value : String
    var body: some View {
        TextField(title, text: $value)
            .padding(.leading)
            .frame(height: 40)
            .background(Color.white)
            .cornerRadius(20)
            .padding([.leading, .trailing, .top], 25)
    }
}


struct NextPageView: View {
    @Binding var selectedOption: String
    
    var body: some View {
        VStack {
            Text("You selected: \(selectedOption)")
                .padding()
            Spacer()
        }
        .navigationTitle("Next Page")
    }
}
