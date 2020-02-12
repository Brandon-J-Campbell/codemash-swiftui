//
//  SessionsView.swift
//  codemash
//
//  Created by Brandon Campbell on 6/9/19.
//  Copyright © 2019 Brandon Campbell. All rights reserved.
//

import SwiftUI

struct SessionsView : View {
    @ObservedObject var store = SessionStore()
    
    var body: some View {
        NavigationView {
            List(store.sessions) { session in
                NavigationLink(destination: SessionView(session: session)) {
                    SessionCell(session: session)
                }
            }
            .navigationBarTitle(Text("Sessions"))
        }
    }
}

struct SessionCell : View {
    var session: Session
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(session.title)
                .lineLimit(0)
            Text(session.category)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#if DEBUG
struct SessionsView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            SessionsView(store: SessionStore(sessions: Session.getTestSessions()))
            SessionsView(store: SessionStore(sessions: Session.getTestSessions()))
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

