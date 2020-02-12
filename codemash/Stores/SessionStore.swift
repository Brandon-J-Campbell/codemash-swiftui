//
//  SessionStore.swift
//  codemash
//
//  Created by Brandon Campbell on 6/10/19.
//  Copyright © 2019 Brandon Campbell. All rights reserved.
//

import SwiftUI
import Combine

class SessionStore: ObservableObject {
    @Published var sessions: [Session]
    
    var sessionsByDay: [Day] {
        get {
            let dayFormatter = DateFormatter.init()
            dayFormatter.dateFormat = "EEEE"
            
            let datesArray = sessions.compactMap { dayFormatter.string(from: $0.startTime) } // return array of date
            var days = [[Session]]()
            datesArray.forEach {
                let dateKey = $0
                let filterArray = sessions.filter { dayFormatter.string(from: $0.startTime) == dateKey }
                days.append(filterArray)
            }
            
            var rv = [Day]()
            for sessions in days {
                rv.append(Day(sessions: sessions))
            }
            return rv
        }
    }
    
    init(sessions: [Session] = []) {
        self.sessions = sessions
    }
    
    var didChange = PassthroughSubject<Void, Never>()
}

struct Day {
    var id = UUID()
    var sessions: [Session]
    
    init(sessions: [Session] = []) {
        self.sessions = sessions
    }
}
