//
//  PunchEntryModel.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import Foundation

struct PunchEntryModel {
    var id = ""
    var empName = ""
    var empNo = ""
    var punchInDt = ""
    var punchOutDt = ""
    var date = ""

    init(id: String = "", empName: String = "", empNo: String = "", punchInDt: String = "", punchOutDt: String = "", date : String = "") {
       self.id = id
       self.empName = empName
       self.empNo = empNo
       self.punchInDt = punchOutDt
       self.punchOutDt = punchOutDt
       self.date = date
   }
   
   
   init(responseData : PunchEntry) {
       self.id = responseData.id ?? ""
       self.empName = responseData.empName ?? ""
       self.empNo = responseData.empId ?? ""
       self.punchInDt = responseData.punch_in_dt ?? ""
       self.punchOutDt = responseData.punch_out_dt ?? ""
       self.date = responseData.date ?? ""
   }
   
   init(responseObj: [String:Any]) {
       self.id = responseObj["id"] as? String ?? ""
       self.empName = responseObj["empName"] as? String ?? ""
       self.empNo = responseObj["empNo"] as? String ?? ""
       self.punchInDt = responseObj["punch_in_dt"] as? String ?? ""
       self.punchOutDt = responseObj["punch_out_dt"] as? String ?? ""
       self.date = responseObj["date"] as? String ?? ""
   }
   
   static func getData(data : [PunchEntry]) -> [PunchEntryModel] {
       var arrTemp = [PunchEntryModel]()
       for temp in data {
           arrTemp.append(PunchEntryModel(responseData: temp))
       }
       return arrTemp
   }
}
