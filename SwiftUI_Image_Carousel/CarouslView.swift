//
//  CarouslView.swift
//  SwiftUI_Image_Carousel
//
//  Created by apple on 14/12/24.
//

import SwiftUI

struct CarouslView: View {
    
    @Binding var currentPage:Int
    @Binding var images:[String]
    
    var body: some View {
        VStack{
            TabView(selection: $currentPage) {
                ForEach(0..<images.count, id: \ .self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            .cornerRadius(20)
            .padding()
            
        HStack {
                        ForEach(0..<images.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.blue : Color.gray)
                                .frame(width: 10, height: 10)
                                .padding(3)
                        }
                    }
            
            
        }
    }
}

#Preview {
    CarouslView(currentPage: .constant(0), images: .constant(["1"]))
}
