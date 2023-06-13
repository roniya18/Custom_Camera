//
//  CameraView.swift
//  AVCamera
//
//  Created by alkesh s on 25/04/23.
//

import SwiftUI
import AVFoundation

struct CameraView : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    let cameraService : CameraService
    let didfinishProcessingPhoto : (Result<AVCapturePhoto,Error>)->()
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        cameraService.start(delegate: context.coordinator){ err in
            if let err = err {
                didfinishProcessingPhoto(.failure(err))
                return
            }
        }
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .black
        viewController.view.layer.addSublayer(cameraService.previewLayer)
        cameraService.previewLayer.frame = viewController.view.bounds
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, didFinishProcessingPhoto : didfinishProcessingPhoto)
    }

    
    class Coordinator : NSObject , AVCapturePhotoCaptureDelegate{
        let parent : CameraView
        private var didFinishProcessingPhoto : (Result<AVCapturePhoto,Error>)->()
        
        init(parent: CameraView, didFinishProcessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> Void) {
            self.parent = parent
            self.didFinishProcessingPhoto = didFinishProcessingPhoto
        }
        
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error{
                didFinishProcessingPhoto(.failure(error))
                return
            }
            didFinishProcessingPhoto(.success(photo))
            
        }
    }
}
