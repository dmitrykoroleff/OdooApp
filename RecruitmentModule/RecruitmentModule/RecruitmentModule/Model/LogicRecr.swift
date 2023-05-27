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
    @Published var prod = "erp.miem.hse.ru"
    
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
    @Published var sheduleActivity: [Int: Array<Int>] = [:]
    @Published var nameLog: Array<String> = []
    @Published var textLog: Array<String> = []
    @Published var dateLog: Array<String> = []
    
    @Published var nameActivity: Array<String> = []
    @Published var textActivity: Array<String> = []
    @Published var dateActivity: Array<String> = []
    @Published var activity: Array<String> = []
    
    public func getStages() {
        let json = Json().jsonStageId
        let ur1 = "https://\(prod)/"
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
        let ur1 = "https://\(prod)/"
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
            if stage.count > 0 {
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
            descrip[jsb["id"] as? Int ?? 0] = goodDecription(inputString: jsb["description"] as? String ?? "")
            appreciation[jsb["id"] as? Int ?? 0] = jsb["priority"] as? String ?? "0"
            activeSummary[jsb["id"] as? Int ?? 0] = jsb["activity_summary"] as? String ?? " "
            sheduleActivity[jsb["id"] as? Int ?? 0] = jsb["activity_ids"] as? Array<Int> ?? []
//            deadline[jsb["id"] as? Int ?? 0] = scheduleActivity(number: DateString().strToDate(str: jsb["activity_date_deadline"] as? String ?? " "))
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
    
    private func scheduleActivity(number: Int, word: String) -> String {
            if number > 0 {
                return "Due in \(number) days"
            }
            if number < 0 {
                return "\(abs(number)) days \(word)"
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
            let ur1 = "https://\(prod)/"
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
        let ur1 = "https://\(prod)/"
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
        self.nameLog = []
        self.textLog = []
        self.dateLog = []
        let json = Json().getLogNotes(thread: thread)
        let ur1 = "https://\(prod)/"
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
                                if (js?["body"] as? String ?? "") != "" && (js?["is_note"] as? Bool ?? false) == true {
                                    self.textLog.append(self.getText(str: (js?["body"] as? String ?? "")))
                                    let array = js?["author_id"] as? Array<Any> ?? []
                                    self.nameLog.append(array[1] as? String ?? "")
                                    self.dateLog.append(self.scheduleActivity(number: DateString().strToDate(str: js?["date"] as? String ?? " ", dateFormat: "yyyy-MM-dd HH:mm:ss"), word: "ago"))
                                    
                                }
                            }
                        }
                        notes = []
                        for index in 0..<self.nameLog.count {
                            notes.append(Note(id: UUID(), task: self.nameLog[index], text: self.textLog[index], editTime: self.dateLog[index]))
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
    
    public func getSheduleActivity(index: Int) {
        self.nameActivity = []
        self.textActivity = []
        self.dateActivity = []
        self.activity = []
        let json = Json().getActivity(ids: sheduleActivity[index]!)
        let ur1 = "https://\(prod)/"
        let ur2 = "web/dataset/call_kw/activity_format"
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
                                
                                let array = js?["user_id"] as? Array<Any> ?? []
                                self.nameActivity.append(array[1] as? String ?? " ")
                                self.textActivity.append(self.goodDecription(inputString: self.getText(str: js?["note"] as? String ?? "")))
                                self.dateActivity.append(self.scheduleActivity(number: DateString().strToDate(str: js?["date_deadline"] as? String ?? " ", dateFormat: "yyyy-MM-dd"), word: "overdue"))
                                self.activity.append(js?["display_name"] as? String ?? " ")
                                
                            }
                        }
                        scheduleTasks = []
                        for index in 0..<self.sheduleActivity[index]!.count {
                            scheduleTasks.append(Schedule(user: self.nameActivity[index], text: self.textActivity[index], dueTime: self.dateActivity[index], type: self.activity[index]))
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
    
    func getText(str: String) -> String {
        var extractedString = " "
        var inputString = str
        while let startRange = inputString.range(of: "<a"), let endRange = inputString.range(of: "</a>") {
            let rangeToDelete = startRange.lowerBound..<endRange.upperBound
            inputString = inputString.replacingCharacters(in: rangeToDelete, with: "")
        }

        if let startRange = inputString.range(of: "<p>") {
            let startIndex = startRange.upperBound
            if let endRange = inputString.range(of: "</p>", range: startIndex..<inputString.endIndex) {
                let endIndex = endRange.lowerBound
                extractedString = String(inputString[startIndex..<endIndex])
            }
        }
        return extractedString
        
    }
    
    func goodDecription(inputString: String) -> String {
        return inputString.replacingOccurrences(of: "<br>", with: "").replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "Other Information:", with: "").replacingOccurrences(of: "___________", with: "")
    }
    
    
    func setLogNotes(thread: Int, message: String) {
        let json = Json().setLog(thread: thread, message: message)
        let ur1 = "https://\(prod)/"
        let ur2 = "mail/message/post"
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
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

