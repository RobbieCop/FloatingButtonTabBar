//
//  FloatingButton.swift
//  TabBarTest
//
//  Created by Rob Copping on 28/03/2023.
//

import SwiftUI

struct FloatingButton: View {
    @State var show = false
    var body: some View {
       canvas
            .overlay(icons)
    }

    var canvas: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.8))
            context.addFilter(.blur(radius: 10))

            context.drawLayer { ctx in
                for index in 1...10 {
                    if let symbol = ctx.resolveSymbol(id: index) {
                        ctx.draw(symbol, at: CGPoint(x:size.width / 2, y: size.height / 2))
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
        }
        .foregroundColor(.white)
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
