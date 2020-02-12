//
//  ContentView.swift
//  codemash
//
//  Created by Brandon Campbell on 6/5/19.
//  Copyright © 2019 Brandon Campbell. All rights reserved.
//

import SwiftUI

struct SpeakersView : View {
    var speakers: [Speaker] = []
    
    var body: some View {
        List(speakers) { speaker in
            HStack {
                Image(systemName: "photo")
                VStack (alignment: .leading) {
                    Text(speaker.firstName + "  " + speaker.lastName)
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        SpeakersView(speakers: testData)
    }
}
#endif
