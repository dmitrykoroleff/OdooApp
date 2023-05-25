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
    @Published var name: [Int: String] = [:]
    @Published var allId: Array<Int> = []
    
    
    public func mainRequestCRM() {
        let json = JsonCRM().jsonStageId
//        let ur1 = "https://crm.auditory.ru/"
        let ur1 = "https://erp.miem.hse.ru/"
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
    
    func getDataById(data: [String: Any]) {
        var jsonRes = data["result"] as? [String: Any]
        var jsonRecords = jsonRes?["records"] as? Array<Any>
        print(jsonRecords?[8])
        for index in 0..<(jsonRecords?.count ?? 0) {
            let jsb = jsonRecords![index] as? [String: Any] ?? ["": 0]
            getDataFromRequest(jsb: jsb)
        }
    }
    
    
    func getDataFromRequest(jsb: [String: Any]) {
        name[jsb["id"] as? Int ?? 0] = jsb["name"] as? String ?? ""
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
