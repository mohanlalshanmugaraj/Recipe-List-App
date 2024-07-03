//
//  EmployeeViewModel.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import Foundation
import CoreData

class EmployeeViewModel : ObservableObject {
    
    @Published  var toast: Toast? = nil
    
    @Published var navigateCreateEmployee = false
    @Published var navigatePunchIn = false
    @Published var navigateEmployeeSummery = false
    
    @Published var empName = ""
    @Published var empNo = ""
    @Published var department = ""
    @Published var address = ""
    
    @Published var selectedEmpId = ""
    @Published var filterDate = Date()

    @Published var isNextPageActive = false
    @Published var punchStatus : PunchStatus = .punchIn
    @Published var punchInTime  = Date()
    @Published var punchOutTime = Date()
    
    @Published var employeeDropDown : [DropDownValue] = []
    
    @Published var employeeList : [EmployeeModel] = []
    
    
    @Published var punchEntryList : [PunchEntryModel] = []
    
    @Published var punchEntryModel : PunchEntryModel = PunchEntryModel(responseObj: [:])
    
    private let context = PersistenceController.shared.container.viewContext
    
    func saveEmployee(completion:@escaping (Bool,String) -> (Void)) {
        if empName.isEmpty {
            toast = Toast(style: .error, message: "Please enter employee Name.")
        }else if (empNo.isEmpty) {
            toast = Toast(style: .error, message: "Please enter employee No.")
        }else if (department.isEmpty) {
            toast = Toast(style: .error, message: "Please enter department.")
        }else if (address.isEmpty) {
            toast = Toast(style: .error, message: "Please enter address.")
        }else {
            fetchEmployeeNames { flag, string in
                let empNames = self.employeeDropDown.map { $0.empName }
                if !empNames.contains(self.empName) {
                    let emp = Employee(context: self.context)
                    emp.id = UUID().uuidString
                    emp.empNo = self.empNo
                    emp.empName = self.empName
                    emp.empDep = self.department
                    emp.empAddress = self.address
                    self.saveContext() { flag,msg in
                        if flag {
                            self.toast = Toast(style: .success, message: "Employee created successfully.")
                        }else {
                            self.toast = Toast(style: .error, message: msg)
                        }
                        completion(flag, msg)
                    }
                }else {
                    self.toast = Toast(style: .error, message: "Employee name already exists.")
                }
              
            }
           
        }
    
    }
    
    private func saveContext(completion:@escaping (Bool,String) -> (Void)) {
          do {
              try context.save()
              fetchItems()
              completion(true, "Employee Created")
          } catch {
              completion(false, "Error saving context: \(error.localizedDescription)")
              print("Error saving context: \(error.localizedDescription)")
          }
      }
    
    
    func fetchItems() {
           let request: NSFetchRequest<Employee> = Employee.fetchRequest()
           do {
               let result = try context.fetch(request)
               let employe = result 
               self.employeeList = EmployeeModel.getData(data: employe)
           } catch {
               print("Error fetching items: \(error.localizedDescription)")
           }
       }
    
    
    func fetchEmployeeNames(completion:@escaping (Bool,String) -> (Void) = { _, _ in }) {
        employeeDropDown.append(DropDownValue(id: "00", empName: "Select"))
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Employee")
                fetchRequest.resultType = .dictionaryResultType
                let idExpression = NSExpressionDescription()
                idExpression.name = "id"
                idExpression.expression = NSExpression(forKeyPath: "id")
                idExpression.expressionResultType = .stringAttributeType
                
                let nameExpression = NSExpressionDescription()
                nameExpression.name = "empName"
                nameExpression.expression = NSExpression(forKeyPath: "empName")
                nameExpression.expressionResultType = .stringAttributeType
                
                fetchRequest.propertiesToFetch = [idExpression, nameExpression]
               
               do {
                   let results = try context.fetch(fetchRequest)
                   employeeDropDown.append(contentsOf: results.compactMap { dict in
                                  if let id = dict["id"] as? String, let name = dict["empName"] as? String {
                                      return DropDownValue(id: id, empName: name)
                                  }
                                  return nil
                              })
                   completion(true,"")
               } catch {
                   print("Error fetching employee names: \(error.localizedDescription)")
                   completion(false,"")
               }
        
        print("employeeDropDown : \(employeeDropDown.count)"  )
    }
    
    
    func savePunchData(completion:@escaping (Bool,String) -> (Void)) {
        if selectedEmpId.isEmpty {
            self.toast = Toast(style: .error, message: "Please select employee name")
        }else if punchStatus == .punchIn {
        let punch = PunchEntry(context: context)
        punch.empId = selectedEmpId
        punch.empName = getEmpName(for: selectedEmpId) ?? ""
        punch.id = UUID().uuidString
        punch.punch_in_dt = punchInTime.formatted()
        punch.date = Date().toStringDate()
        punch.punch_out_dt = ""
           
        saveContext(completion: completion)
        }else {
            updatePunchOut(completion: completion)
        }
       
    }
    
    func updatePunchOut(completion:@escaping (Bool,String) -> (Void)) {
        let request: NSFetchRequest<PunchEntry> = PunchEntry.fetchRequest()
              request.predicate = NSPredicate(format: "id == %@", punchEntryModel.id as CVarArg)
              
              do {
                  let employees = try context.fetch(request)
                  if let employeeToUpdate = employees.first {
                      employeeToUpdate.punch_out_dt = punchOutTime.formatted()
                      saveContext(completion: completion)
                  }
              } catch {
                  print("Error updating employee: \(error.localizedDescription)")
              }
    }
    
    func getEmpName(for id: String) -> String? {
            return employeeDropDown.first(where: { $0.id == id })?.empName
    }
    
    
    func getPunchEntryById(id : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PunchEntry")
        let todayString = Date().toStringDate()
        fetchRequest.predicate = NSPredicate(format: "empId = %@ AND date = %@", id, todayString)
        do {
            let result = try context.fetch(fetchRequest)
            let punchEntry = result as! [PunchEntry]
            let punchEntryList = PunchEntryModel.getData(data: punchEntry)
            if punchEntryList.count != 0 && selectedEmpId != "00" {
                self.punchEntryModel = punchEntryList.first!
                if !punchEntryModel.punchInDt.isEmpty && !punchEntryModel.punchOutDt.isEmpty{
                    self.punchStatus = .completed
                }else if punchEntryModel.punchInDt.isEmpty && punchEntryModel.punchOutDt.isEmpty {
                    self.punchStatus = .punchIn
                }else if punchEntryModel.punchInDt.isEmpty{
                    self.punchStatus = .punchIn
                }else if punchEntryModel.punchOutDt.isEmpty {
                    self.punchStatus = .punchOut
                    punchInTime = punchEntryModel.punchInDt.convertToDate() ?? Date()
                }
                
                print("punchEntryModel empName : \(punchEntryModel.empName)")
                print("punchEntryModel empName : \(punchEntryModel.empName)")
                print("punchEntryModel empNo :\(punchEntryModel.empNo)")
                print("punchEntryModel id : \(punchEntryModel.id)")
                print("punchEntryModel punchInDt : \(punchEntryModel.punchInDt)")
                print("punchEntryModel punchOutDt : \(punchEntryModel.punchOutDt)")
            }else {
                self.punchStatus = .punchIn
            }
        }catch {
            print("error \(error.localizedDescription)")
        
        }
        
    }
    
    
    func fetchPunchInData() {
            let request: NSFetchRequest<PunchEntry> = PunchEntry.fetchRequest()
            request.predicate = NSPredicate(format: "date = %@",  filterDate.toStringDate())
           do {
               let result = try context.fetch(request)
               let punch = result
               self.punchEntryList = PunchEntryModel.getData(data: punch)
           } catch {
               print("Error fetching items: \(error.localizedDescription)")
           }
       }

    
    
    
    
}

struct DropDownValue {
    let id: String
    let empName: String
}

enum PunchStatus {
    case punchIn, punchOut, completed
}

extension Date {
    func toStringDate(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
        return dateFormatter.date(from: self)
    }
}
