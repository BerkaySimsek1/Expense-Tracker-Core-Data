import SwiftUI

struct Product: Identifiable {
    var id = UUID()
    var photoURL: String
    var name: String
    var price: Int
}

struct BottomBumpedShape: Shape {
    let offset: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height - offset))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height - offset), control: CGPoint(x: rect.midX, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.closeSubpath()
        return path
    }
}

struct HomeView: View {
    
    @FetchRequest(fetchRequest: Transaction.all()) private var transactions
    
    var provider = TransactionProvider.shared
    
    let photourl = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Netflix_icon.svg/2048px-Netflix_icon.svg.png"
    
    var products: [Product] {
        return [
            Product(photoURL: photourl, name: "Ürün 1", price: 10),
            Product(photoURL: photourl, name: "Ürün 2", price: -20),
            Product(photoURL: photourl, name: "Ürün 3", price: 30),
            Product(photoURL: photourl, name: "Ürün 4", price: -40),
            Product(photoURL: photourl, name: "Ürün 5", price: 50),

        ]
    }
    
    @State private var isChartViewPresented = false
        @State private var isProfileViewPresented = false
        @State private var isTransactionViewPresented = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    BottomBumpedShape(offset: 40)
                        .fill(Color.blue.opacity(0.7))
                        .frame(height: UIScreen.main.bounds.height * 0.33)
                    Spacer()
                }.ignoresSafeArea()
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Good Afternoon,").font(.title)
                            Text("Berkay Şimşek")
                        }.padding()
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            isProfileViewPresented.toggle()
                        }) {
                            Image(systemName: "bell")
                                .foregroundColor(.white)
                                .font(.title)
                        }.padding(.horizontal)
                            .sheet(isPresented: $isProfileViewPresented, content: {
                                ProfileView()
                            })
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 40, style: .continuous).fill(Color.blue).frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.24).overlay {
                            VStack(alignment: .leading){
                                Text("Total Balance:").bold().font(.title)
                                Text("$ 23421").bold().font(.largeTitle)
                                Spacer()
                                HStack{
                                    VStack{
                                        Text("Income:").font(.title).opacity(0.7)
                                        Text("$ 3245").bold().font(.title2)
                                    }
                                    Spacer()
                                    VStack{
                                        Text("Outcome:").font(.title).opacity(0.7)
                                        Text("$ 3245").bold().font(.title2)
                                    }
                                }
                            }.padding(20).foregroundColor(.white)
                            
                        }
                    }
                    HStack{
                        Text("Transaction History").bold().font(.title2)
                        Spacer()
                        Button("See All") {
                            isChartViewPresented.toggle()
                        }.sheet(isPresented: $isChartViewPresented, content: {
                            ChartView()
                        })
                    }.padding(.horizontal)
                    
                        List {
                            ForEach(transactions) { transaction in
                               TransactionRowView(transaction: transaction)
                                    .swipeActions(allowsFullSwipe: true){
                                        Button(role: .destructive) {
                                            do{
                                                try delete(transaction)
                                            }catch{
                                                print(error)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }.tint(.red)
                                    }
                            }
                        }.listStyle(PlainListStyle())
                    
                }
                Spacer()
                Button(action: {
                    isTransactionViewPresented.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.blue)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }).padding()
                    .sheet(isPresented: $isTransactionViewPresented, content: {
                        AddTransactionView(vm: .init(provider: provider))
                    })
                
            }
        }
    }
}

private extension HomeView {
    func delete(_ transaction: Transaction) throws {
        let context = provider.viewContext
        
        let existingContact = try context.existingObject(with: transaction.objectID)
        context.delete(existingContact)
        Task(priority: .background) {
            try await context.perform{
                try context.save()
            }
        }
    }
}

struct TransactionRowView : View {
    
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var transaction: Transaction
    
    var body: some View{
        HStack() {
            // Fotoğrafı göster
            Image(systemName: transaction.symbolName)
                .frame(width: 50, height: 50)
                .cornerRadius(8)
                .padding(.horizontal,10)
            // Ürün adını göster
            VStack(alignment: .leading){
                Text(transaction.name)
                    .font(.headline)
                Text("Today").foregroundColor(.gray)
            }
            Spacer()
            // Fiyatı göster
            Text("$ \(transaction.isIncome ? "+" : "-")\(transaction.amount)")
                .padding(.horizontal)
                .font(.title2)
                .bold()
                .foregroundColor(transaction.isIncome ? .green : .red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
