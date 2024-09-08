//
//  IapView.swift
//  Footbalify
//
//  Created by Adam Jassak on 29/07/2024.
//

import SwiftUI
import StoreKit

/// In App Purchase Screen
struct IapView: View {
    @StateObject private var vm: IapVM
    var body: some View {
        ZStack {
            Color.colorMainBg.ignoresSafeArea()
            VStack {
                HStack {
                    Image(.iconRegular)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Footbalify"+"\n"+"Support")
                            .font(.extra30)
                            .foregroundStyle(.tampaBayBuccaneers)
                    }
                }.padding(.top, 10)
                vm.promoImages[0]
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding(10)
                    .onReceive(vm.timer) { _ in
                        withAnimation(.linear(duration: 1)) {
                            vm.promoImages.shuffle()
                        }
                    }
                Text("Support Footbalify")
                    .font(.semi20)
                    .padding(.bottom)
                    .foregroundStyle(.orange)
                bulletItem("Help with app funding, maintenance, and updates.")
                bulletItem("Support the development with a one-time purchase.")
                bulletItem("No subscription. No commitments. Just a single one-off in-app purchase.")
                bulletItem("THANK YOU!")
                    .foregroundStyle(.tampaBayBuccaneers)
                Button(action: {
                    vm.purchaseItem()
                }, label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 50)
                        .padding(.horizontal, 50)
                        .foregroundStyle(.yellow)
                        .overlay(HStack{
                            Text(vm.productPrice)
                                .font(.extraCustom(25))
                            Text("/ DevSupport")
                                .font(.semi20)
                        }.foregroundStyle(.black))
                }).padding(.top, 30)
                    .padding(.bottom, 5)
                HStack {
                    Link(destination: vm.privacyUrl,
                         label: {
                        Text("Privacy policy")
                    })
                    Text("|")
                    Link(destination: vm.termsUrl,
                         label: {
                        Text("Terms of use")
                    })
                }.lineLimit(1).minimumScaleFactor(0.5)
                    .padding(.horizontal, 5)
                    .font(.semi10)
                    .foregroundStyle(.white)
            }
        }.alert("Purchase succesfull!",
                isPresented: $vm.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }

    // MARK: - Custom SwiftUI SubViews
    /// Custom SwiftUI View providing formatted bullet item
    func bulletItem(_ text: String) -> some View {
        HStack {
            Image(systemName: AppConstant.iapIcon.rawValue)
                .foregroundStyle(.yellow)
            Text(text)
        }
        .font(.semi20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 2)
    }

    init(vm: IapVM) {
        _vm = StateObject(wrappedValue: vm)
    }
}

#Preview {
    IapView(vm: IapVM(iapService: IapService()))
}
