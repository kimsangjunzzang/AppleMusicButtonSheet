//
//  Musicinfo.swift
//  AppleMusicButtonSheet
//
//  Created by 김상준 on 5/1/24.
//

import SwiftUI

struct Musicinfo: View{
    @Binding var expandSheet : Bool
    var animation: Namespace.ID
    
    var body: some View{
        HStack(spacing: 0, content: {
            
            ZStack{
                if !expandSheet{
                    GeometryReader{
                        let size = $0.size
                        
                        Image("IU")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: expandSheet ? 15 : 5, style: .continuous))
                        
                    }
                    .matchedGeometryEffect(id: "IU", in: animation)
                    
                }
            }
            .frame(width: 45,height: 45)
            Text("좋은날")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal,15)
            
            Spacer(minLength: 0)
            
            Button(action: {
                
            }, label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            })
            .padding(.leading,25)
        })
        .foregroundColor(.primary)
        .padding(.horizontal)
        .padding(.bottom,5)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation (.easeInOut(duration: 0.3)){
                expandSheet = true
            }
            
        }
    }
}

#Preview {
    Home()
        .preferredColorScheme(.dark)
}
