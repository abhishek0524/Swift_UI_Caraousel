//
//  TblListVW.swift
//  SwiftUI_Image_Carousel
//
//  Created by apple on 14/12/24.
//

import SwiftUI


struct TblListVW: View {
    
    @Binding var filteredArray:[[String]]

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(filteredArray, id: \.[0]) { item in
                HStack {
                    Image(item[2])
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text(item[0])
                            .font(.headline)
                        Text(item[1])
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }.padding(.horizontal)
            }
        }.padding(.top)
    }
}

#Preview {
    TblListVW(filteredArray: .constant([["Apple","Nice fruit","a"]]))
}
