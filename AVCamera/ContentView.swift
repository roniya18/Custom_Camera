//
//  ContentView.swift
//  AVCamera
//
//  Created by alkesh s on 25/04/23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var isCustomCameraViewPresented = false
    @State  var images : [UIImage] = []
    let adaptiveColoumn = [GridItem(.adaptive(minimum: 50))]
    
    
    
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            ScrollView{
                
                LazyVGrid(columns: adaptiveColoumn, spacing: 1){
                    //if images != nil{
                        ForEach(images, id: \.self){ image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width:100.0, height: 100.0)
                        }
                    //}
                }
            }
            .padding(.all,20)
//            if retreviedImage != nil{
//                Image(uiImage: retreviedImage!)
//                    .resizable()
//                    .scaledToFit()
//                    .ignoresSafeArea()
//            }else{
//                Color(UIColor.white)
//            }
            
            VStack{
                Spacer()
                Button(action: {
                    isCustomCameraViewPresented.toggle()
                }, label: {
                    Image(systemName: "camera.fill")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                })
                .padding(.bottom)
                .sheet(isPresented: $isCustomCameraViewPresented, content: {
                    CustomCameraView(imagess: $images)
                })
            }
        }
    }
}

