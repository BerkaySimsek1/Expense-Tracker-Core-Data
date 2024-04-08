import SwiftUI


struct Product: Identifiable {
    var id = UUID()
    var photoURL: String
    var name: String
    var price: Int
}

struct HomeView: View {
    
    @FetchRequest(fetchRequest: Transaction.all()) private var transactions
    
    var provider = TransactionProvider.shared
    let currency = UserDefaults.standard.object(forKey: "currency") as? String ?? "$"
    let userName = UserDefaults.standard.object(forKey: "name") as? String ?? "User"
    
    @State var userData = TotalMoney()
    
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
                            Text(userName)
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
                                Text("\(currency) \(userData.netTotal)").bold().font(.largeTitle)
                                Spacer()
                                HStack{
                                    VStack{
                                        Text("Income:").font(.title).opacity(0.7)
                                        Text("\(currency) \(userData.incomeTotal)").bold().font(.title2)
                                    }
                                    Spacer()
                                    VStack{
                                        Text("Outcome:").font(.title).opacity(0.7)
                                        Text("\(currency) \(userData.expenseTotal)").bold().font(.title2)
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
                        })
                    }.padding(.horizontal)
                    if transactions.isEmpty { Text("Your transaction history is empty.").padding(.top,100)
                        Spacer()
                    }
                    else {
                        List {
                            ForEach(transactions.sorted { $0.creatingDate > $1.creatingDate }) { transaction in
                                TransactionRowView(transaction: transaction, currency: currency)
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
                    .sheet(isPresented: $isTransactionViewPresented,onDismiss: {
                        self.userData = TotalMoney()
                    }, content: {
                        AddTransactionView(vm: .init(provider: provider))
                    })
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
