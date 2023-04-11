//
//  LogicRecr.swift
//  RecruitmentModule
//
//  Created by Данила on 08.04.2023.
//

import Foundation//
//  Logic.swift
//  ChooseModules
//
//  Created by Данила on 08.04.2023.
//

import Foundation
import Alamofire

public class LogicR: ObservableObject {
    
    public init() { }
    
    @Published var dataRecr: [String : Any] = [:]
    @Published var stageId: [String : Array<Int>] = [:]
    @Published var names: [Int: String] = [:]
    @Published var job: [Int: String] = [:]
    @Published var email: [Int: String] = [:]
    @Published var phone: [Int: String] = [:]
    @Published var department: [Int: String] = [:]
    @Published var tags: [Int: String] = [:]
    @Published var recruiter: [Int: String] = [:]
    @Published var hireDate: [Int: String] = [:]
    @Published var appreciation: [Int: String] = [:]
    @Published var source: [Int: String] = [:]
    @Published var eSalary: [Int: Int] = [:]
    @Published var pSalary: [Int: Int] = [:]
    @Published var descrip: [Int: String] = [:]
    @Published var deadline: [Int: String] = [:]
    @Published var activeSummary: [Int: String] = [:]

    public func getData() {
        let json: [String: Any] = ["id": 100,
                                   "jsonrpc": "2.0",
                                   "method": "call",
                                   "params": [
                                        "domain": [],
                                        "fields": [],
                                        "model": "hr.applicant"]]
//        let url = URL(string: self.urlGet)
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//            guard let data = data else { return }
//            print(data)
        let ur1 = "https://crm.auditory.ru/"
        let ur2 = "web/dataset/search_read"
        print(ur1)
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                        else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard String(data: prettyJsonData, encoding: .utf8) != nil else {
                            print("Error: Could print JSON in String")
                            return
                        }
                        if jsonObject["error"] != nil {
                            
                        }
                        DispatchQueue.main.async {
                            self.dataRecr = jsonObject
                            self.getArrayRecr()
                        }
                        
                        
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    func getArrayRecr() {
        var jsonRes = self.dataRecr["result"] as? [String : Any]
        var jsonRecords = jsonRes?["records"] as? Array<Any>
        var js = jsonRecords?[0] as? [String : Any]
        var jjj = js?["job_id"] as? Array<Any>
        stageId = [:]
        for index in 0..<(jsonRecords?.count ?? 0) {
            var jsb = jsonRecords![index] as? [String : Any] ?? ["":0]
            var stage = jsb["stage_id"] as? Array<Any> ?? []
            getOther(jsb: jsb)
            if stageId[stage[1] as? String ?? ""] == nil {
                var arr: Array<Int> = []
                arr.append(jsb["id"] as? Int ?? 0)
                stageId[stage[1] as? String ?? ""] = arr
            }
            else {
                stageId[stage[1] as? String ?? ""]!.append(jsb["id"] as? Int ?? 0)
            }
        }
    }
    
    func getName(index: Int) -> String {
        var jsonRes = self.dataRecr["result"] as? [String : Any]
        var jsonRecords = jsonRes?["records"] as? Array<Any>
        var jsb = jsonRecords?[0] as? [String : Any] ?? ["":0]
        var stage = jsb["partner_name"] as? String ?? " p"
        print(self.dataRecr["result"])
        return stage
    }
    
    
    func getOther(jsb: [String: Any]) {
        var nam = jsb["partner_name"] as? String ?? ""
        var dep = jsb["department_id"] as? Array<Any> ?? []
        var jid = jsb["job_id"] as? Array<Any> ?? []
        var recr = jsb["user_id"] as? Array<Any> ?? []
        if names[jsb["id"] as? Int ?? 0] == nil {
            names[jsb["id"] as? Int ?? 0] = nam
            department[jsb["id"] as? Int ?? 0] = dep[1] as? String ?? " "
            job[jsb["id"] as? Int ?? 0] = jid[1] as? String ?? " "
            recruiter[jsb["id"] as? Int ?? 0] = recr[1] as? String ?? " "
            phone[jsb["id"] as? Int ?? 0] = jsb["partner_mobile"] as? String ?? ""
            hireDate[jsb["id"] as? Int ?? 0] = jsb["create_date"] as? String ?? " "
            eSalary[jsb["id"] as? Int ?? 0] = jsb["salary_expected"] as? Int ?? 0
            pSalary[jsb["id"] as? Int ?? 0] = jsb["salary_proposed"] as? Int ?? 0
            descrip[jsb["id"] as? Int ?? 0] = jsb["description"] as? String ?? "none"
            appreciation[jsb["id"] as? Int ?? 0] = jsb["priority"] as? String ?? "0"
            deadline[jsb["id"] as? Int ?? 0] = jsb["activity_date_deadline"] as? String ?? ""
            activeSummary[jsb["id"] as? Int ?? 0] = jsb["activity_summary"] as? String ?? ""
        }
    }
}


