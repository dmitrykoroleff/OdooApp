//
//  LogicRecr.swift
//  RecruitmentModule
//
//  Created by Данила on 08.04.2023.
//

import Foundation//

import Foundation
import Alamofire

public class LogicR: ObservableObject {
    
    public init() { }
    @Published var allStages: Array<String> = []
    @Published var jobIdSet: Set<Int> = []
    @Published var dataRecr: [String: Any] = [:]
    @Published var stageId: [String: Array<Int>] = [:]
    @Published var names: [Int: String] = [:]
    @Published var job: [Int: String] = [:]
    @Published var group: [Int: String] = [:]
    @Published var jobInt: [Int: Int] = [:]
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
    @Published var statusRecr: String = ""
    @Published var idJob: [Int: Array<Int>] = [:]
    @Published var dictIdJob: [Int: String] = [:]
    @Published var countJobs: [Int: Int] = [:]
    @Published var stageOfJob: [Int: Array<Int>] = [:]
    @Published var stageOfJobName: [Int: Array<String>] = [:]
    
    @Published var nameLog: Array<String> = []
    @Published var textLog: Array<String> = []
    @Published var dateLog: Array<String> = []
    
    public func getStages() {
        let json = Json().jsonStageId
        let ur1 = "https://crm.auditory.ru/"
        let ur2 = "web/dataset/search_read"
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        DispatchQueue.main.async {
                            var jsonRes = jsonObject["result"] as? [String: Any]
                            var jsonRecords = jsonRes?["records"] as? Array<Any>
                            for index in 0..<(jsonRecords?.count ?? 0) {
                                var js = jsonRecords?[index] as? [String: Any]
                                self.allStages.append(js?["name"] as? String ?? "")
                            }
                            self.statusRecr = self.allStages[0]
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

    public func getData() {
        getStages()
        let json = Json().jsonRecruitment
        let ur1 = "https://crm.auditory.ru/"
        let ur2 = "web/dataset/search_read"
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        DispatchQueue.main.async {
                            self.dataRecr = jsonObject
                            self.getArrayRecr()
                            self.jobId()
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
        var jsonRes = self.dataRecr["result"] as? [String: Any]
        var jsonRecords = jsonRes?["records"] as? Array<Any>
        var js = jsonRecords?[0] as? [String: Any]
        var jjj = js?["job_id"] as? Array<Any>
        stageId = [:]
        for index in 0..<(jsonRecords?.count ?? 0) {
            var jsb = jsonRecords![index] as? [String: Any] ?? ["": 0]
            var stage = jsb["stage_id"] as? Array<Any> ?? []
            let jid = jsb["job_id"] as? Array<Any> ?? []
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
        let jsonRes = self.dataRecr["result"] as? [String : Any]
        let jsonRecords = jsonRes?["records"] as? Array<Any>
        let jsb = jsonRecords?[0] as? [String : Any] ?? ["":0]
        let stage = jsb["partner_name"] as? String ?? " p"
        return stage
    }
    
    
    func getOther(jsb: [String: Any]) {
        let nam = jsb["name"] as? String ?? ""
        let dep = jsb["department_id"] as? Array<Any> ?? []
        let jid = jsb["job_id"] as? Array<Any> ?? []
        let recr = jsb["user_id"] as? Array<Any> ?? []
        var groupArray = jsb["x_group"] as? Array<Any> ?? []
        if jid.count != 0 {
            if dictIdJob[jid[0] as? Int ?? -1] == nil {
                dictIdJob[jid[0] as? Int ?? -1] = jid[1] as? String ?? "pp"
            }
        }
        if names[jsb["id"] as? Int ?? 0] == nil {
            names[jsb["id"] as? Int ?? 0] = nam
            if dep.count != 0 {
                department[jsb["id"] as? Int ?? 0] = dep[1] as? String ?? " "
            }
            if jid.count != 0 {
                job[jsb["id"] as? Int ?? 0] = jid[1] as? String ?? " "
                jobInt[jsb["id"] as? Int ?? 0] = jid[0] as? Int ?? 0
                jobIdSet.insert(jid[0] as? Int ?? -1)
            }
            if recr.count != 0 {
                recruiter[jsb["id"] as? Int ?? 0] = recr[1] as? String ?? " "
            }
            if groupArray.count != 0 {
                group[jsb["id"] as? Int ?? 0] = groupArray[1] as? String ?? " "
            }
            email[jsb["id"] as? Int ?? 0] = jsb["email_from"] as? String ?? ""
            phone[jsb["id"] as? Int ?? 0] = jsb["partner_phone"] as? String ?? ""
            hireDate[jsb["id"] as? Int ?? 0] = jsb["create_date"] as? String ?? ""
            eSalary[jsb["id"] as? Int ?? 0] = jsb["salary_expected"] as? Int ?? 0
            pSalary[jsb["id"] as? Int ?? 0] = jsb["salary_proposed"] as? Int ?? 0
            descrip[jsb["id"] as? Int ?? 0] = jsb["description"] as? String ?? "none"
            appreciation[jsb["id"] as? Int ?? 0] = jsb["priority"] as? String ?? "0"
            activeSummary[jsb["id"] as? Int ?? 0] = jsb["activity_summary"] as? String ?? " "
            deadline[jsb["id"] as? Int ?? 0] = scheduleActivity(number: DateString().strToDate(str: jsb["activity_date_deadline"] as? String ?? " "))
            if jid.count != 0 {
                if countJobs[jid[0] as? Int ?? -1] == nil {
                    countJobs[jid[0] as? Int ?? -1] = 1
                } else { countJobs[jid[0] as? Int ?? -1]! += 1 }
                
                if idJob[jid[0] as? Int ?? -1] == nil {
                    idJob[jid[0] as? Int ?? -1] = []
                    idJob[jid[0] as? Int ?? -1]?.append(jsb["id"] as? Int ?? 0)
                } else { idJob[jid[0] as? Int ?? -1]?.append(jsb["id"] as? Int ?? 0) }
            }
        }
    }
    
    
    func currentJobID(jobID: Int, id: Int) -> Bool {
        return jobID == id
    }
    
    private func scheduleActivity(number: Int) -> String {
        if number > 0 {
            return "Due in \(number) days"
        }
        if number < 0 {
            return "\(abs(number)) days overdue"
        }
        return "Today"
    }
    
    func getCountStatus(status: String) -> Int {
        return stageId[status]?.count ?? 0
    }
    
    
    func jobId() {
        self.stageOfJob = [:]
        self.stageOfJobName = [:]
        for indexId in Array(jobIdSet) {
            let json = Json().jsonJobId(jobId: indexId)
            let ur1 = "https://crm.auditory.ru/"
            let ur2 = "web/dataset/call_kw/web_read_group"
            AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        DispatchQueue.main.async {
                            var jsonRes = jsonObject["result"] as? [String : Any]
                            var jsonGroups = jsonRes?["groups"] as? Array<[String: Any]>
                            if jsonGroups?.count ?? 0 > 0 {
                                for index in jsonGroups ?? [[:]] {
                                    var js = index["stage_id"] as? Array<Any>
                                    if js?.count ?? 0 > 0 {
                                        if self.stageOfJob[indexId] == nil {
                                            self.stageOfJob[indexId] = []
                                            self.stageOfJobName[indexId] = []
                                            self.stageOfJob[indexId]?.append(js?[0] as? Int ?? 0)
                                            self.stageOfJobName[indexId]?.append(js?[1] as? String ?? " ")
                                        }
                                        else {
                                            self.stageOfJob[indexId]?.append(js?[0] as? Int ?? 0)
                                            self.stageOfJobName[indexId]?.append(js?[1] as? String ?? " ")
                                        }
                                    }
                                    
                                }
                            }
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
    }
    
    
    func createStatus(id: Int, name: String) {
        let json = Json().createStatusJson(jobId: id, name: name)
        let ur1 = "https://crm.auditory.ru/"
        let ur2 = "web/dataset/call_kw/name_create"
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    DispatchQueue.main.async {
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
    
    
    public func getNotes(thread: Int) {
        let json = Json().getLogNotes(thread: thread)
        let ur1 = "https://crm.auditory.ru/"
        let ur2 = "mail/thread/messages"
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    DispatchQueue.main.async {
                        let jsonRes = jsonObject["result"] as? Array<Any>
                        if jsonRes?.count ?? 0 > 0 {
                            for item in jsonRes! {
                                let js = item as? [String: Any]
                                
                            }
                        }
                        
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
    
    
    func getFirstLetter(str: String) -> String {
        let separatedNames = str.components(separatedBy: " ")
        var initials = ""

        if let firstName = separatedNames.first, let lastName = separatedNames.dropFirst().first {
            if let firstInitial = firstName.first, let lastInitial = lastName.first {
                initials = "\(firstInitial)"
            }
        }
        return initials
    }
    
}

