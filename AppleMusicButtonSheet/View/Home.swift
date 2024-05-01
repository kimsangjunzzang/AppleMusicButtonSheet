//
//  Home.swift
//  AppleMusicButtonSheet
//
//  Created by 김상준 on 4/30/24.
//

import SwiftUI

struct Home: View {
    @State private var expandSheet : Bool = false
    @Namespace private var animation
    
    var body: some View {
        TabView{
            ListenNow()
            SampleTab("Radio", "dot.radiowaves.left.and.right")
            SampleTab("Music", "play.square.stack")
            SampleTab("Search", "magnifyingglass")
        }
        .tint(.red) // 탭뷰 클릭시 해당 탭은 빨간색으로 표시
        .safeAreaInset(edge: .bottom){
            CustomBottomSheet()
        }
        .overlay{
            if expandSheet{
                ExpandedBottomSheet(expandSheet: $expandSheet, animation: animation)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
    }
    
    @ViewBuilder
    func ListenNow() -> some View{
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 20){
                    Image("IU")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Image("IU2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
                .padding(.bottom,10)
                
            }
            .navigationTitle("IU")
        }
        .tabItem {
            Image(systemName: "play.circle.fill")
            Text("Listen Now")
        }
        .toolbar(expandSheet ? .hidden : .visible, for: .tabBar) // 음악 재생뷰 클릭시 탭뷰가 내려간다
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    }
    
    @ViewBuilder
    func CustomBottomSheet() -> some View{
        ZStack{
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            }else{
                Rectangle()
                    .fill(.ultraThinMaterial) // ultrathin 사용시 엄청 얇아지기 때문에 뒤에 배경이 비친다. (blur)
                    .overlay{
                        Musicinfo(expandSheet: $expandSheet, animation: animation)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
            }
        }
        .frame(height: 70)
        .overlay(alignment:.bottom,content: {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
                .offset(y: -5)
            
            
        }) // custom devider
        .offset(y: -49)
    }
    
    @ViewBuilder
    func SampleTab(_ title: String, _ icon: String) -> some View{
        ScrollView(.vertical, showsIndicators: false,content: {
            Text(title)
                .padding(.top,25)
        })
        .tabItem {
            Image(systemName: icon)
            Text(title)
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
    }
}
#Preview {
    Home()
        .preferredColorScheme(.dark)
}
