//
//  EmployeeModel.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import Foundation

class EmployeeModel {
     var id = ""
     var empName = ""
     var empNo = ""
     var department = ""
     var address = ""
    
    var description: String {
           return "ID: \(id), Name: \(empName), Employee No: \(empNo), Department: \(department), Address: \(address)"
       }
    
    
    init(id: String = "", empName: String = "", empNo: String = "", department: String = "", address: String = "") {
        self.id = id
        self.empName = empName
        self.empNo = empNo
        self.department = department
        self.address = address
    }
    
    
    init(responseData : Employee) {
        self.id = responseData.id ?? ""
        self.empName = responseData.empName ?? ""
        self.empNo = responseData.empNo ?? ""
        self.department = responseData.empDep ?? ""
        self.address = responseData.empAddress ?? ""
    }
    
    init(responseObj: [String:Any]) {
        self.id = responseObj["id"] as? String ?? ""
        self.empName = responseObj["empName"] as? String ?? ""
        self.empNo = responseObj["empNo"] as? String ?? ""
        self.department = responseObj["empDep"] as? String ?? ""
        self.address = responseObj["empAddress"] as? String ?? ""
    }
    
    static func getData(data : [Employee]) -> [EmployeeModel] {
        var arrTemp = [EmployeeModel]()
        for temp in data {
            arrTemp.append(EmployeeModel(responseData: temp))
        }
        return arrTemp
    }
}
