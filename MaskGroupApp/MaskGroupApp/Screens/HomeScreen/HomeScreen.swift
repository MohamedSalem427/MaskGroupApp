//
//  HomeScreen.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var vm:HomeVM
    @State private var services: [ServiceDatum] = []
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                VStack {
                    Text("")
                        .padding()
                }
                .frame(width: UIScreen.main.bounds.width,height: 150)
                .background(Color.init("moveColor"))
                .cornerRadius(radius: 50, corners: [.bottomLeft, .bottomRight])
                NavView().padding(.top,50)
            }
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                    Text("عروضنا")
                        .foregroundColor(Color.init("moveColor"))
                        .font(.system(size: 20)).italic()
                }.padding(.trailing,16)
                    .padding(.top,16)
                HorizontalListView(items: FakeProducts.items)
            }
            VStack {
                HStack {
                    Text("الكل")
                        .foregroundColor(.red)
                        .font(.system(size: 20)).italic()
                        .padding(.horizontal,20)
                    Spacer()
                    Text("خدماتنا")
                        .foregroundColor(Color.init("moveColor"))
                        .font(.system(size: 20)).italic()
                        .padding(.horizontal,20)
                    
                }.padding(.trailing,16)
                    .padding(.top,16)
            }
            ServicesGridListView(items: $services)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            vm.getAvailableServices()
        }
        .onReceive(vm.$services) { value in
            guard !value.isEmpty else {
                return
            }
            self.services = value
        }
    }
    private func NavView() -> some View {
        HStack {
            Button {
            } label: {
                Image("Group 8964")
            }.padding(.leading , 32)
            
            Button {
            } label: {
                Image("Group 8965")
            }.badge(2)
            
            Spacer()
            
            Button {
            } label: {
                Image("Group 8966")
            }.padding(.trailing , 32)
        }
    }
    
}

struct ServicesGridListView: View {
    @Binding var items: [ServiceDatum]
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing:8) {
                ForEach(items, id: \.id) { item in
                    HStack {
                        VStack {
                            HStack {
                                Spacer()
                                Text(item.name ?? "")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15)).italic()
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.8)
                                    .padding()
                                
                            }
                            Spacer()
                            HStack {
                                Image(systemName: "chevron.left")
                                    .padding(.leading,8)
                                Spacer()
                                AppRemoteImage(URL(string: completedImageURL(url: item.image?.publicURL ?? "")))
                                    .resizable()
                                    .frame(width: 40,height: 40)
                                    .scaledToFit()
                                    .padding(.trailing,8)
                            }.padding()
                        }
                    }
                    .frame(width: 130,height: 120)
                    .cardView(opacity: 0.2, cornerRadius: 10, shadowRadius: 4)
                    .padding(.top,8)
                }
            }.frame(width: UIScreen.main.bounds.width - 80)
        }
    }
    func completedImageURL(url: String?) -> String {
        guard let url = url else {
            return ""
        }
        let baseUrl = "https://maghassel-api.barsha.io/"
        return "\(baseUrl)\(url)"
    }
}


struct HorizontalListView: View {
    let items: [ProductItems]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items,id: \.id) { item in
                    item.image
                        .padding(.horizontal,10)
                }
            }
        }.flipsForRightToLeftLayoutDirection(true)
         .environment(\.layoutDirection, .rightToLeft)
    }
}



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(vm: HomeVM())
    }
}




import Kingfisher

public typealias AppRemoteImage = KFImage
