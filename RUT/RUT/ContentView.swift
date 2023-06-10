//
//  ContentView.swift
//  RUT
//
//  Created by 한상진 on 2023/06/10.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var shareViewModel = MBTIViewModel()
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Main")
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
            
            debugView
                .tabItem {
                    Image(systemName: "gear")
                    Text("Debug")
                }
        }
        .task {
            print("configureGroupSession loop")
            
            for await session in MBTITogether.sessions() {
                print("session: \(session)")
                shareViewModel.configureGroupSession(session)
            }
        }
    }
    
    private var debugView: some View {
        VStack {
            List(Array(shareViewModel.profiles)) { profile in
                HStack {
                    Text(profile.nickname)
                    Text(profile.mbti)
                }
            }
            
            Button(action: {
                shareViewModel.startSharing()
            }, label: {
                Text("startSharing")
            })
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

