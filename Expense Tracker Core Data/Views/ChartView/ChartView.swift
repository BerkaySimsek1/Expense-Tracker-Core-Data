import SwiftUI
import Charts
import CoreData

struct ChartView: View {
    @FetchRequest(
        entity: Transaction.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.creatingDate, ascending: true)]
    ) var transactions: FetchedResults<Transaction>
    
    let categories = ["Day", "Week", "Month", "Year"]
    @State private var selectedCategoryIndex = 0
    
    var body: some View {
        VStack {
            if transactions.isEmpty {
                Text("To see the charts please add income or expense")
            } else {
                VStack {
                    Text("Follow your expenses in chart").padding()
                    Picker(selection: $selectedCategoryIndex, label: Text("Choose Category")) {
                        ForEach(categories.indices, id: \.self) {
                            Text(self.categories[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                Spacer()
                CategoryView(category: categories[selectedCategoryIndex], transactions: transactions)
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            print("Transactions count: \(transactions.count)")
        }
    }
}



#Preview {
    ChartView()
}
