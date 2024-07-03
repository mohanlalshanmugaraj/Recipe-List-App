//
//  EmployeeSummery.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import SwiftUI

struct EmployeeSummery: View {
    @ObservedObject var employeeVM = EmployeeViewModel()
    var body: some View {
        VStack {
            DatePicker("Punch In Date",
                       selection: $employeeVM.filterDate,
                       displayedComponents: [.date])
            .datePickerStyle(CompactDatePickerStyle())
            .padding([.leading, .trailing, .top], 25)
            .onChange(of: employeeVM.filterDate, perform: { value in
                employeeVM.fetchPunchInData()
            })
            
            if employeeVM.punchEntryList.isEmpty {
                Text("No Data found")
                    .padding(.top, 100)
                Spacer()
            }else {
                List {
                    ForEach(employeeVM.punchEntryList, id: \.id) {punch in
                        PunchEntryItems(punchModel: punch)
                    }
                    
            }
            }
        }.navigationTitle("Employee Summery")
            .onAppear() {
                employeeVM.fetchPunchInData()
            }
    }
}

#Preview {
    NavigationView {
        EmployeeSummery()
    }
}

struct PunchEntryItems: View {
    @State var punchModel : PunchEntryModel
    var body: some View {
        VStack(alignment : .leading) {
            HStack {
                Text(punchModel.empName)
                    .bold()
                Spacer()
                Text(punchModel.date)
                    .bold()
            }
            
            Text("Punch In : \(punchModel.punchInDt)")
            Text("Punch Out : \(punchModel.punchOutDt)")
        }
    }
}
