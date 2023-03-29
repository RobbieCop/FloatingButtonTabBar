//
//  TabView.swift
//  TabBarTest
//
//  Created by Rob Copping on 28/03/2023.
//

import SwiftUI
import SoninDesign

enum tabs {
    case tab1, tab2, tab3, tab4
}

struct TabView: View {
    @State var currentTab: tabs = .tab1
    @State var show = false
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .ignoresSafeArea()
                .zIndex(1)
            VStack(spacing: 0) {
                switch currentTab {
                case .tab1:
                    TabView1()
                case .tab2:
                    TabView2()
                default:
                    EmptyView()
                }
                VStack {
                    Spacer()
                    ZStack(alignment: .bottom) {
                        HStack(spacing: 16.0) {
                            tabItem(text: "Explore", image: "map", tab: .tab1)
                            tabItem(text: "Explore", image: "map", tab: .tab2)

                            Circle()
                                .foregroundColor(.clear)
                                .frame(width: 76, height: 76)

                            tabItem(text: "Explore", image: "map", tab: .tab3)
                            tabItem(text: "Explore", image: "map", tab: .tab4)
                        }
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .background {
                            Color.white
                                .edgesIgnoringSafeArea([.bottom, .horizontal])
                        }
                        VStack(spacing: 0) {
                            canvas
                                .shadow(color: .white.opacity(0.2), radius: 0, x: -1, y: -1)
                                               .shadow(color: .black.opacity(0.2), radius: 0, x: 1, y: 1)
                                               .shadow(color: .black.opacity(0.5), radius: 10, x: 10, y: 10)
                                           .overlay(icons)

                            Text("Create")
                                .font(.subheadline)
                                .offset(y: -16)
                        }
                        .frame(maxWidth: show ? .infinity : 76)
                    }
                }
            }
            .zIndex(2)
        }
    }

    func tabItem(text: String, image: String, tab: tabs) -> some View {
        Button {
            currentTab = tab
        } label: {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 16, height: 16)

                Text(text)
                    .font(.subheadline)
            }
            .foregroundColor(.black)
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity)
        }
    }

    var canvas: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.8))
            context.addFilter(.blur(radius: 10))

            context.drawLayer { ctx in
                for index in 1...4 {
                    if let symbol = ctx.resolveSymbol(id: index) {
                        ctx.draw(symbol, at: CGPoint(x:size.width / 2, y: size.height - 60))
                    }
                }
            }
        } symbols: {
            Circle()
                .frame(width: 76)
                .tag(1)

            Circle()
                .frame(width: 76)
                .tag(2)
                .offset(x: show ? -100 : 0, y: show ? -50 : 0)

            Circle()
                .frame(width: 76)
                .tag(3)
                .offset(x: show ? 100 : 0, y: show ? -50 : 0)


            Circle()
                .frame(width: 76)
                .tag(4)
                .offset(y: show ? -100 : 0)
        }
    }

    var icons: some View {
        ZStack {
            Image(systemName: "plus")
                .font(.system(size: 30))
                .rotationEffect(.degrees(show ? 45 : 0))
                .onTapGesture {
                    withAnimation(.spring(response: 0.9, dampingFraction: 0.7, blendDuration: 0.7)) {
                        show.toggle()
                    }
                }

                    Group {
                           Image(systemName: "bubble.left.fill")
                               .offset(x: -100, y: -50)

                           Image(systemName: "moon.fill")
                               .offset(x: 100, y: -50)

                           Image(systemName: "quote.opening")
                               .offset(y: -100)
                       }
                       .opacity(show ? 1 : 0)
                       .blur(radius: show ? 0 : 10)
                       .scaleEffect(show ? 1 : 0.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .offset(y: -45)
        .foregroundColor(.white)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
