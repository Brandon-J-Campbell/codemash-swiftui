//
//  Session.swift
//  codemash
//
//  Created by Brandon Campbell on 10/10/16.
//  Copyright © 2016 Brandon Campbell. All rights reserved.
//

import SwiftUI

struct Session : Identifiable {
    var id : Int
    var abstract : String
    var category : String
    var rooms : Array<String>
    var endTime : Date
    var startTime : Date
    var time : Date
    var sessionType : String
    var speakers : Array<Speaker>
    var tags : Array<String>
    var title : String
}

extension Session {
    static func parse(fromDictionary: Dictionary<String, Any>) -> Session {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        var speakers = Array<Speaker>()
        
        for dict in fromDictionary["Speakers"] as! Array<Dictionary<String, Any>> {
            let speaker = Speaker.parse(fromDictionary: dict)
            speakers.append(speaker)
            if let url = URL.init(string: "https:" + speaker.gravatarUrl) {
                URLSession.shared.dataTask(with: url) {
                    (data, response, error)  in
                    guard let data = data, error == nil else { return }
                    speaker.image = UIImage(data: data) ?? speaker.image
                    }.resume()
            }
        }
        
        return Session.init(id: fromDictionary["Id"] as! Int, abstract: fromDictionary["Abstract"] as! String,
                            category: fromDictionary["Category"] as! String,
                            rooms: fromDictionary["Rooms"] as! Array<String>,
                            endTime: formatter.date(from: fromDictionary["SessionEndTime"] as! String)!,
                            startTime: formatter.date(from: fromDictionary["SessionStartTime"] as! String)!,
                            time: formatter.date(from: fromDictionary["SessionTime"] as! String)!,
                            sessionType: fromDictionary["SessionType"] as! String,
                            speakers: speakers,
                            tags: fromDictionary["Tags"] as! Array<String>,
                            title: fromDictionary["Title"] as! String)
    }
    
    #if DEBUG
    static func getTestSessions() -> [Session] {
        var testSessions = Array<Session>.init()
        
        if let url = Bundle.main.url(forResource: "SessionsData", withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                do {
                    let array : Array<Any?> = try JSONSerialization.jsonObject(with: data as Data, options: [.allowFragments]) as! Array<Any?>
                    for dict : Dictionary<String, Any> in array as! Array<Dictionary<String, Any>> {
                        let session = Session.parse(fromDictionary: dict)
                        testSessions.append(session)
                    }
                } catch {
                    print("Error!! Unable to parse SessionsData.json")
                }
            } else {
                print("Error!! Unable to load SessionsData.json")
            }
        }
        
        return testSessions
    }
    #endif
}

extension Session : Comparable {
    static func < (lhs: Session, rhs: Session) -> Bool {
        return lhs.startTime.compare(rhs.startTime) == .orderedAscending
    }
    
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.startTime.compare(rhs.startTime) == .orderedSame
    }
    
    static func > (lhs: Session, rhs: Session) -> Bool {
        return lhs.startTime.compare(rhs.startTime) == .orderedAscending
    }
}
