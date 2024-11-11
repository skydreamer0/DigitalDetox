import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabBarView()
            .environment(\.managedObjectContext, viewContext)
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
} 