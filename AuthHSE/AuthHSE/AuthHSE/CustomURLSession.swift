////
////  CustomURLSession.swift
////  AuthHSE
////
////  Created by Nikita Rybakovskiy on 17.03.2023.
////
//
//import Foundation
//
//
//class MyURLSessionDelegate: NSObject, URLSessionDelegate, URLSessionDataDelegate {
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        // Do something with the data
//        print(data)
//    }
//    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        if let error = error {
//            print("Error: \(error.localizedDescription)")
//        }
//    }
//}
//
//let delegate = MyURLSessionDelegate()
//let url = URL(string: "https://example.com/data.json")!
//let request = URLRequest(url: url)
//
//let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
//let task = session.dataTask(with: request)
//task.resume()
