//
//  ExpandedBottomSheet.swift
//  AppleMusicButtonSheet
//
//  Created by 김상준 on 4/30/24.
//

import SwiftUI

struct ExpandedBottomSheet: View {
    @Binding var expandSheet : Bool
    @State private var animationContent : Bool = false
    @State private var offsetY : CGFloat = 0
    var animation: Namespace.ID
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack{
                RoundedRectangle(cornerRadius: animationContent ? deviceCornerRadius : 0, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(alignment: .top){
                        Musicinfo(expandSheet: $expandSheet, animation: animation)
                            .allowsHitTesting(false)
                            .opacity(animationContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                VStack(spacing: 15){
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40,height: 5)
                        .opacity(animationContent ? 1 : 0)
                        .offset(y: animationContent ? 0 : size.height)
                    
                    GeometryReader{
                        let size = $0.size
                        
                        Image("IU")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: animationContent ? 15 : 5, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "IU", in: animation)
                    .frame(height: size.width - 50)
                    .padding(.vertical,size.height < 700 ? 10 : 30) // 화면 크기에 따른 조절
                    
                    PlayerView(size)
                        .offset(y: animationContent ? 0 : size.height)
                    
                }
                .padding(.top,safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal,25)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .clipped()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)){
                        expandSheet = false
                        animationContent = false
                    }
                }
                
            }
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translationY = value.translation.height
                        offsetY = (translationY > 0 ? translationY : 0)
                    }).onEnded({ value in
                        withAnimation (.easeInOut(duration: 0.3)){
                            if offsetY > size.height * 0.4{
                                expandSheet = false
                                animationContent = false
                            }else{
                                offsetY = .zero
                            }
                            
                        }
                    })
            )
            .ignoresSafeArea(.container,edges: .all)
            
        }
        
        .onAppear{
            withAnimation(.easeInOut(duration: 0.35)) {
                animationContent = true
                
            }
        }
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View{
        GeometryReader{
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing){
                VStack(spacing : spacing) {
                    HStack(alignment: .center, spacing: 15){
                        VStack(alignment: .leading, spacing: 4){
                            Text("좋은날")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("IU")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .padding(12)
                                .background{
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                }
                        }
                    }
                    
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(height: 5)
                        .padding(.top, spacing)
                    
                    HStack{
                        Text("0:00")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Text("3:33")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .frame(height: size.height / 2.5,alignment: .top)
                
                HStack(spacing: size.width * 0.18, content: {
                    Button{
                        
                    }label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    Button{
                        
                    }label: {
                        Image(systemName: "pause.fill")
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                    }
                    Button{
                        
                    }label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                })
                .foregroundColor(.white)
                .frame(maxHeight: .infinity)
                
                VStack(spacing: spacing){
                    HStack(spacing: 15){
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.gray)
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(alignment: .top, spacing: size.width * 0.18){
                        Button{
                            
                        }label:{
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                        }
                        VStack(spacing : 6){
                            Button{
                                
                            }label:{
                                Image(systemName: "airpods.gen3")
                                    .font(.title2)
                            }
                            Text("Sangjun's Airpods2")
                                .font(.caption)
                            
                        }
                        
                        Button{
                            
                        }label:{
                            Image(systemName: "list.bullet")
                                .font(.title2)
                        }
                        
                    }
                    .foregroundColor(.white)
                    .blendMode(.overlay)
                    .padding(.top, spacing)
                }
                .frame(height: size.height / 2.5,alignment: .bottom)
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

extension View {
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat{
                return cornerRadius
            }
            
            return 0
        }
        return 0
        
    }
}
