//
//  SessionView.swift
//  codemash
//
//  Created by Brandon Campbell on 6/9/19.
//  Copyright © 2019 Brandon Campbell. All rights reserved.
//

import SwiftUI

struct SessionView : View {
    var session: Session
    
    var body: some View  {
        ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                Text("Date")
                    .italic()
                    .font(.subheadline)
                Text(session.rooms[0])
                    .font(.subheadline)
                Text(session.title)
                    .font(.headline)
                    .bold()
                ForEach(session.speakers) { speaker in
                    SpeakerView(speaker: speaker)
                }
                Text("Tabs")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text(session.abstract)
                    .font(.body)
                    .lineLimit(nil)
                
            }
        }
    }
}

#if DEBUG
struct SessionView_Previews : PreviewProvider {
    static var previews: some View {
        SessionView(session: Session.getTestSessions()[1])
    }
}
#endif

private struct SpeakerView : View {
    var speaker: Speaker
    var body: some View {
        return HStack {
            Image(uiImage: speaker.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(3.0)
                .frame(width: 100.0, height: 100.0)
            Text(speaker.firstName + " " + speaker.lastName)
            
        }
    }
}
