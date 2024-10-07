//
//  Exercise1Page.swift
//  TransLingo
//
//  Created by Evan Anger on 10/6/24.
//

import SwiftUI
import Translation

struct Exercise1Page: View {
    @State var input: String = ""
    @State var showPresentation: Bool = false
    var body: some View {
        VStack {
            TextField("Translatable text", text: $input)
                .underlineTextField()
            Button {
                showPresentation = true
            } label: {
                Text("Translate")
            }
            .buttonStyle(BorderedButtonStyle())
            .foregroundStyle(Color.darkPink)
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        .translationPresentation(isPresented: $showPresentation, text: input) { translation in
            self.input = translation
        }
    }
}

#Preview {
    Exercise1Page()
}
