//
//  CustomCameraView.swift
//  AVCamera
//
//  Created by alkesh s on 25/04/23.
//

import SwiftUI
import CoreData

struct CustomCameraView : View{
    
    let fileManager = LocalFileManager.instance
    let folderName = "images"
    let cameraService = CameraService()
    @State var capturedImage : UIImage?
    @State var retreviedImage : UIImage?
    @Binding var imagess : [UIImage]
    //@Binding var image : [UIImage]?
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body : some View{
        
        ZStack{
            CameraView(cameraService: cameraService){ result in
                switch result {
                case.success(let photo) :
                    if let data = photo.fileDataRepresentation(){
                        capturedImage = UIImage(data: data)
                        presentationMode.wrappedValue.dismiss()
                        fileManager.saveImage(image: capturedImage!, imageName: capturedImage!.description, folderName: folderName)
                        retreviedImage = fileManager.getImage(imageName: capturedImage!.description, folderName: folderName)
                        if let retreviedImage = retreviedImage {
                            imagess.append(retreviedImage)
                            print("appended")
                        }
                        else{
                            print("error not appended")
                        }
                        
                        
                    }
                    else{
                        print("Error: no image data found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
            VStack{
                Spacer()
                Button(action: {
                    cameraService.capturePhoto()

                }, label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                })
                .padding(.bottom)
            }
        }
    }
}
