//
//  Exercise2Page.swift
//  TransLingo
//
//  Created by Evan Anger on 10/6/24.
//

import SwiftUI
import Translation

struct Exercise2Page: View {
    @State var translations: [String] = [
        "Default",
        "New stuff"
    ]
    @State var input: String = ""
    @State var addNewTranslation: Bool = false
    @State private var configuration: TranslationSession.Configuration?
    @State var sourceLanguage: Locale.Language = .init(identifier: "en")
    @State var targetLanguage: Locale.Language = .init(identifier: "es")
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(self.translations, id: \.self) { text in
                    HStack {
                        Text(text)
                        Spacer()
                    }
                    .padding()
                }
                Spacer()
            }
            .sheet(isPresented: $addNewTranslation, content: {
                VStack {
                    HStack {
                        Button {
                            addNewTranslation = false
                        } label: {
                            Image(systemName: "xmark")
                                .padding()
                        }

                        
                        Spacer()
                        Button {
                            if input.isEmpty { return }
                            translations.append(input)
                            input = ""
                            addNewTranslation = false
                        } label: {
                            Image(systemName: "plus.square.fill")
                                .padding()
                        }
                    }
                    TextField("Translatable text", text: $input)
                        .underlineTextField()
                    Spacer()
                }
                .presentationDetents(.init([.medium]))
            })
            .translationTask(configuration) { session in
                Task { @MainActor in
                    do {
                        let requests = self.translations.map {
                            TranslationSession.Request(sourceText: $0)
                        }
                        var responses: [String] = []
                        for try await response in session.translate(batch: requests) {
                            responses.append(response.targetText)
                        }
                        self.translations = responses
                    } catch {
                        // code to handle error
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addNewTranslation = true
                        
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {

                        self.configuration = TranslationSession.Configuration(
                            source: sourceLanguage,
                            target: targetLanguage
                        )
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                    }

                }
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "translate")
                                Text("Sourrce")
                            }
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "translate")
                                Text("Destination")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Exercise2Page()
        .foregroundColor(Color.darkPink)
}
