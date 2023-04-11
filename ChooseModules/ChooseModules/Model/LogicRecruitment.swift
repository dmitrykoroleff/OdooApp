//
//  Logic.swift
//  ChooseModules
//
//  Created by Данила on 08.04.2023.
//

//import Foundation
//import Alamofire
//
//public class Logic {
//    
//    public init() { }
//    
//    public var dataRecr: [String : Any] = [:]
//    public var stageId: [String : Array<Int>] = [:]
//    
//    public func getData() {
//        let json: [String: Any] = ["id": 100,
//                                   "jsonrpc": "2.0",
//                                   "method": "call",
//                                   "params": [
//                                        "domain": [],
//                                        "fields": [],
//                                        "model": "hr.applicant"]]
////        let url = URL(string: self.urlGet)
////        let jsonData = try? JSONSerialization.data(withJSONObject: json)
////        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
////            guard let data = data else { return }
////            print(data)
//        let ur1 = "https://crm.auditory.ru/"
//        let ur2 = "web/dataset/search_read"
//        print(ur1)
//        AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
//            
//            switch response.result {
//                case .success(let data):
//                    do {
//                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                            print("Error: Cannot convert data to JSON object")
//                            return
//                        }
//                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
//                        else {
//                            print("Error: Cannot convert JSON object to Pretty JSON data")
//                            return
//                        }
//                        guard String(data: prettyJsonData, encoding: .utf8) != nil else {
//                            print("Error: Could print JSON in String")
//                            return
//                        }
//                        if jsonObject["error"] != nil {
//                            
//                        }
//                        self.dataRecr = jsonObject
//                        self.getArrayRecr()
//                        
//                        
//                    } catch {
//                        print("Error: Trying to convert JSON data to string")
//                        return
//                    }
//                case .failure(let error):
//                    print(error)
//            }
//        }
//    }
//    
//    
//    func getArrayRecr() {
//        var jsonRes = self.dataRecr["result"] as? [String : Any]
//        var jsonRecords = jsonRes?["records"] as? Array<Any>
//        var js = jsonRecords?[0] as? [String : Any]
//        var jjj = js?["job_id"] as? Array<Any>
//        print(jsonRecords?[4])
//        print(js?["job_id"])
//        print(jjj![1])
//        for index in 0..<jsonRecords!.count {
//            var jsb = jsonRecords![index] as? [String : Any] ?? ["":0]
//            var stage = jsb["stage_id"] as? Array<Any> ?? []
//            if stageId[stage[1] as? String ?? ""] == nil {
////                stageId[stage[1] as? String ?? " "].append(jsb["id"] as? Int ?? 0)
//                var arr: Array<Int> = []
//                arr.append(jsb["id"] as? Int ?? 0)
//                stageId[stage[1] as? String ?? ""] = arr
//            }
//            else {
//                stageId[stage[1] as? String ?? ""]!.append(jsb["id"] as? Int ?? 0)
//            }
//        }
//        print(stageId)
//        for index in 0..<jsonRecords!.count {
//            var jsb = jsonRecords![index] as? [String : Any] ?? ["":0]
//            var stage = jsb["id"] as? Int ?? 0
//            for item in stageId["Initial Qualification"]! {
//                if item == stage {
//                    
//                }
//            }
//        }
//        
//    }
//    
//    
//}

