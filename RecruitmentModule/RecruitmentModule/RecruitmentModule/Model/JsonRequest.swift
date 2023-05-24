//
//  JsonRequest.swift
//  RecruitmentModule
//
//  Created by Данила on 14.05.2023.
//

import Foundation

class Json {
    func jsonJobId(jobId: Int) -> [String:Any] {
        let json: [String: Any] = ["id": 100,
                                        "jsonrpc": "2.0",
                                        "method": "call",
                                        "params": [
                                            "args": [],
                                            "method": "web_read_group",
                                            "model": "hr.applicant",
                                            "kwargs": [
                                                "context": ["default_job_id": jobId],
                                                "domain": [["job_id", "=", jobId]],
                                                "fields": ["stage_id"],
                                                "groupby": ["stage_id"]
                                            ]]]
        return json
    }
    
    func createStatusJson(jobId: Int, name: String) -> [String: Any] {
        let json: [String: Any] = ["id": 100,
                                        "jsonrpc": "2.0",
                                        "method": "call",
                                        "params": [
                                            "args": ["\(name)"],
                                            "method": "name_create",
                                            "model": "hr.recruitment.stage",
                                            "kwargs": [
                                                "context": ["default_job_id": jobId],
                                            ]]]
        return json
    }
    
    let jsonRecruitment: [String: Any] = ["id": 100,
                               "jsonrpc": "2.0",
                               "method": "call",
                               "params": [
                                    "domain": [],
                                    "fields": [],
                                    "model": "hr.applicant"]]
    
    let jsonStageId: [String: Any] = ["id": 100,
                               "jsonrpc": "2.0",
                               "method": "call",
                               "params": [
                                    "domain": [],
                                    "fields": ["name"],
                                    "model": "hr.recruitment.stage"]]
    
    
    func getLogNotes(thread: Int) -> [String: Any] {
        let json: [String: Any] = ["id": 100,
                                   "jsonrpc": "2.0",
                                   "method": "call",
                                   "params": [
                                        "thread_id": thread,
                                        "limit": 30,
                                        "thread_model": "hr.applicant"]]
        return json
    }
}
