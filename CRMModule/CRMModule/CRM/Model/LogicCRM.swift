//
//  LogicCRM.swift
//  CRMModule
//
//  Created by Данила on 22.05.2023.
//

import Foundation
import Alamofire


public class CRMLogic: ObservableObject {
//MARK: Переменные с данными о карточках
    public init() { }
    @Published var prod = "erp.miem.hse.ru"
    
    @Published var setStageID: Set<Int> = []
    @Published var name: [Int: String] = [:]
    @Published var allId: Array<Int> = []
    @Published var stageName: [Int: String] = [:]
    @Published var idsByStage: [String: Array<Int>] = [:]
    @Published var priority: [Int: Int] = [:]
    
    @Published var partnerName: [Int: String] = [:]
    @Published var email: [Int: String] = [:]
    @Published var phone: [Int: String] = [:]
    @Published var salesPerson: [Int: String] = [:]
    @Published var salesTeam: [Int: String] = [:]
    @Published var dateClose: [Int: String] = [:]
    @Published var description: [Int: String] = [:]
    
    @Published var total: [String: Float] = [:]
    
    @Published var expected: [Int: Float] = [:]
    @Published var prorated: [Int: Float] = [:]
    
    @Published var nameLog: Array<String> = []
    @Published var textLog: Array<String> = []
    @Published var dateLog: Array<String> = []
    
    @Published var nameActivity: Array<String> = []
    @Published var textActivity: Array<String> = []
    @Published var dateActivity: Array<String> = []
    @Published var activity: Array<String> = []
    
    @Published var sheduleActivity: [Int: Array<Int>] = [:]
    
    
    
    public func mainRequestCRM() {
        self.getStageCRM()
        let json = JsonCRM().jsonCRM
        let ur1 = "https://\(prod)/"
        let ur2 = "web/dataset/search_read"
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            return
                        }
                        DispatchQueue.main.async { [self] in
                            getDataById(data: jsonObject)
                        }
                    } catch {
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    public func getStageCRM() {
        let json = JsonCRM().jsonCRMStage
        let ur1 = "https://\(prod)/"
        let ur2 = "web/dataset/search_read"
        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            return
                        }
                        DispatchQueue.main.async { [self] in
                            stageIdByData(data: jsonObject)
                        }
                    } catch {
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func stageIdByData(data: [String: Any]) {
        statuses = []
        var jsonRes = data["result"] as? [String: Any]
        var jsonRecords = jsonRes?["records"] as? Array<Any>
        for index in 0..<(jsonRecords?.count ?? 0) {
            let jsb = jsonRecords![index] as? [String: Any] ?? ["": 0]
            setStageID.insert(jsb["id"] as? Int ?? 0)
            idsByStage[jsb["name"] as? String ?? ""] = []
            statuses.append(Status(id: UUID(), image: "globe", name: jsb["name"] as? String ?? ""))
        }
        
    }
    
    func getDataById(data: [String: Any]) {
        total = [:]
        var jsonRes = data["result"] as? [String: Any]
        var jsonRecords = jsonRes?["records"] as? Array<Any>
        for index in 0..<(jsonRecords?.count ?? 0) {
            let jsb = jsonRecords![index] as? [String: Any] ?? ["": 0]
            getDataFromRequest(jsb: jsb)
        }
    }
    
    
    func getDataFromRequest(jsb: [String: Any]) {
        name[jsb["id"] as? Int ?? 0] = jsb["name"] as? String ?? ""
        priority[jsb["id"] as? Int ?? 0] = Int(jsb["priority"] as? String ?? "0")
        partnerName[jsb["id"] as? Int ?? 0] = jsb["partner_name"] as? String ?? ""
        email[jsb["id"] as? Int ?? 0] = jsb["email_from"] as? String ?? ""
        phone[jsb["id"] as? Int ?? 0] = jsb["phone"] as? String ?? ""
        dateClose[jsb["id"] as? Int ?? 0] = jsb["date_closed"] as? String ?? ""
        description[jsb["id"] as? Int ?? 0] = jsb["description"] as? String ?? ""
        sheduleActivity[jsb["id"] as? Int ?? 0] = jsb["activity_ids"] as? Array<Int> ?? []
        let arrayPerson = jsb["user_id"] as? Array<Any> ?? []
        let arrayTeam = jsb["team_id"] as? Array<Any> ?? []
        if arrayPerson.count > 0 { salesPerson[jsb["id"] as? Int ?? 0] = arrayPerson[1] as? String ?? "" }
        if arrayTeam.count > 0 { salesTeam[jsb["id"] as? Int ?? 0] = arrayTeam[1] as? String ?? "" }
        let exp = jsb["expected_revenue"] as? Float ?? 0.0
        var prot = jsb["prorated_revenue"] as? Float ?? 0.0
        if prot > 100 {
            while prot > 100 {
                prot /= 10
            }
        }
        prorated[jsb["id"] as? Int ?? 0] = prot
        expected[jsb["id"] as? Int ?? 0] = exp
        let stageArray = jsb["stage_id"] as? Array<Any> ?? []
        if stageArray.count != 0 {
            stageName[jsb["id"] as? Int ?? 0] = stageArray[1] as? String ?? ""
            idsByStage[stageArray[1] as? String ?? ""]?.append(jsb["id"] as? Int ?? 0)
            if total[stageArray[1] as? String ?? ""] == nil {
                total[stageArray[1] as? String ?? ""] = 0
                total[stageArray[1] as? String ?? ""]! += exp
            } else { total[stageArray[1] as? String ?? ""]! += exp }
        }
        
    }
    
    
    public func getNotes(thread: Int) {
        self.nameLog = []
        self.textLog = []
        self.dateLog = []
        let json = JsonCRM().getLogNotes(thread: thread)
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
        let json = JsonCRM().getActivity(ids: sheduleActivity[index]!)
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
    
    func setLogNotes(thread: Int, message: String) {
        let json = JsonCRM().setLog(thread: thread, message: message)
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
    
    private func scheduleActivity(number: Int, word: String) -> String {
            if number > 0 {
                return "Due in \(number) days"
            }
            if number < 0 {
                return "\(abs(number)) days \(word)"
            }
            return "Today"
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
    
    func getCountStatus(status: String) -> Int {
        return idsByStage[status]?.count ?? 0
    }
    func getIndex(status: String, index: Int) -> Int {
        return idsByStage[status]![index]
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
    
    
}
