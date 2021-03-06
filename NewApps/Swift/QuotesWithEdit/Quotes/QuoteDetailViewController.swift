//
// Copyright (c) 2017 iGenius Srl
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit
import IGColorPicker
import Kingfisher


class QuoteDetailViewController: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    var quoteWrittenby = String()
    var quoteImage = String()
    var quoteText = String()
    
    
    @IBOutlet weak var colorPickerView: ColorPickerView!
    @IBOutlet weak var tfQuoteTextOutlet: UITextView!
    @IBOutlet weak var tfQuoteWriterOutlet: UITextView!
    @IBOutlet weak var optionViewOutlet: UIView!
    @IBOutlet weak var writerimage: UIImageView!
    var imagePicker = UIImagePickerController()
    var quoteAlignment = Int()
    
    var quoteFrame = CGRect()
    var quoteWriterFrame = CGRect()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.writerimage.isHidden = true
        self.tfQuoteWriterOutlet.textContainer.maximumNumberOfLines = 10
        self.tfQuoteWriterOutlet.textContainer.lineBreakMode = .byTruncatingTail
        
        selectBGColorPicker()
        registEditorForFontStyle(with: self.tfQuoteTextOutlet)
        registEditorForFontStyle(with: self.tfQuoteWriterOutlet)
        
        quotesGesture()
        writerGesture()
        writerImageGesture()

        quoteFrame = self.tfQuoteTextOutlet.frame
        quoteWriterFrame = self.tfQuoteWriterOutlet.frame
        self.colorPickerView.isHidden  = true
        self.imagePicker.delegate = self
        
        

        if self.quoteImage.count != 0 {
            let image = UIImage(named: "placeholder")
            let url = URL(string: quoteImage)
            self.writerimage.kf.setImage(with: url, placeholder: image)
            self.writerimage.isHidden = false
            self.tfQuoteTextOutlet.text = quoteText
            self.tfQuoteWriterOutlet.text = quoteWrittenby
        }
        
        
    }
    fileprivate func quotesGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(QuoteDetailViewController.panGestureDetected))
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.tfQuoteTextOutlet.addGestureRecognizer(panGestureRecognizer)
        self.tfQuoteTextOutlet.backgroundColor = UIColor.clear
        
        var pinchGesture  = UIPinchGestureRecognizer()
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(QuoteDetailViewController.pinchedView))
        self.tfQuoteTextOutlet.isUserInteractionEnabled = true
        self.tfQuoteTextOutlet.addGestureRecognizer(pinchGesture)
    }
    
    fileprivate func writerGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(QuoteDetailViewController.panGestureDetectedWriter))
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.tfQuoteWriterOutlet.addGestureRecognizer(panGestureRecognizer)
        self.tfQuoteWriterOutlet.backgroundColor = UIColor.clear
        
        var pinchGesture  = UIPinchGestureRecognizer()
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(QuoteDetailViewController.pinchedViewWriter))
        self.tfQuoteWriterOutlet.isUserInteractionEnabled = true
        self.tfQuoteWriterOutlet.addGestureRecognizer(pinchGesture)
    }
    fileprivate func writerImageGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(QuoteDetailViewController.panGestureDetectedWriterImage))
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.writerimage.addGestureRecognizer(panGestureRecognizer)
        self.writerimage.backgroundColor = UIColor.clear
        
        var pinchGesture  = UIPinchGestureRecognizer()
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(QuoteDetailViewController.pinchedViewWriterImage))
        self.writerimage.isUserInteractionEnabled = true
        self.writerimage.addGestureRecognizer(pinchGesture)
    }
    
    fileprivate func selectBGColorPicker() {
        // Setup color picker
        self.view.backgroundColor = .white
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.style = .square
        colorPickerView.selectionStyle = .check
        colorPickerView.backgroundColor = .clear
    }
    
    @objc func pinchedView(sender:UIPinchGestureRecognizer){
        self.view.bringSubview(toFront: self.tfQuoteTextOutlet)
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
        self.view.bringSubview(toFront: self.tfQuoteWriterOutlet)
        self.view.bringSubview(toFront: self.tfQuoteTextOutlet)
          self.view.bringSubview(toFront: self.optionViewOutlet)
    }
    
    @objc func panGestureDetected(panGestureRecognizer: UIPanGestureRecognizer) {
        print("pan gesture recognized")
        let touchLocation: CGPoint? = panGestureRecognizer.location(in: view)
        self.tfQuoteTextOutlet.center = touchLocation!
        let velocity: CGPoint? = panGestureRecognizer.velocity(in: view)
        tfQuoteTextOutlet.centerVertically()
  
    }
    
    @objc func pinchedViewWriter(sender:UIPinchGestureRecognizer){
        self.view.bringSubview(toFront: self.tfQuoteWriterOutlet)
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
        self.view.bringSubview(toFront: self.tfQuoteWriterOutlet)
        self.view.bringSubview(toFront: self.tfQuoteTextOutlet)
           self.view.bringSubview(toFront: self.optionViewOutlet)

    }
    
    @objc func panGestureDetectedWriter(panGestureRecognizer: UIPanGestureRecognizer) {
        print("pan gesture recognized")
        let touchLocation: CGPoint? = panGestureRecognizer.location(in: view)
        self.tfQuoteWriterOutlet.center = touchLocation!
        let velocity: CGPoint? = panGestureRecognizer.velocity(in: view)
        tfQuoteWriterOutlet.centerVertically()
   
    }
    
    @objc func pinchedViewWriterImage(sender:UIPinchGestureRecognizer){
        self.view.bringSubview(toFront: self.writerimage)
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
        self.view.bringSubview(toFront: self.tfQuoteWriterOutlet)
        self.view.bringSubview(toFront: self.tfQuoteTextOutlet)
           self.view.bringSubview(toFront: self.optionViewOutlet)
    }
    
    @objc func panGestureDetectedWriterImage(panGestureRecognizer: UIPanGestureRecognizer) {
        print("pan gesture recognized")
        let touchLocation: CGPoint? = panGestureRecognizer.location(in: view)
        self.writerimage.center = touchLocation!
        let velocity: CGPoint? = panGestureRecognizer.velocity(in: view)
     
    }
    
    
    
    
    func registEditorForFontStyle(with textView: UITextView?) {
        let textEditor = KWTextEditor(textView: textView)
        textEditor?.show(in: self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ColorPickerViewDelegate
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.view.backgroundColor = colorPickerView.colors[indexPath.item]
    }
    
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func btBackGroundColorAction(_ sender: UIButton) {
        if(self.colorPickerView.isHidden){
            self.colorPickerView.isHidden  = false
        }else{
            self.colorPickerView.isHidden  = true
        }
    }
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    @IBAction func btRestoreAction(_ sender: UIButton) {
        self.tfQuoteTextOutlet.frame = quoteFrame
        self.tfQuoteWriterOutlet.frame = quoteWriterFrame
        selectBGColorPicker()
    }
    @IBAction func bttextAlignmentAction(_ sender: UIButton) {
        
        if(quoteAlignment == 0){
            self.tfQuoteTextOutlet.textAlignment = .right
            quoteAlignment = 1
        }else if(quoteAlignment == 1){
            self.tfQuoteTextOutlet.textAlignment = .center
            quoteAlignment = 2
        }else {
            self.tfQuoteTextOutlet.textAlignment = .left
            quoteAlignment = 0
        }
        
    }
    
    @IBAction func btAddimageAction(_ sender: UIButton) {
        pickImage(sender: sender)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
     func pickImage(sender: UIButton)
    {
        if(!writerimage.isHidden){
            writerimage.isHidden = true
        }else{
            writerimage.isHidden = false

        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//             self.writerimage.image.contentMode = .scaleToFill
            self.writerimage.image = pickedImage
            self.writerimage.isHidden =  false
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func btAddBackgroundImageAction(_ sender: UIButton) {
        pickImage(sender: sender)
    
    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
//        if let image = screenshotImage, shouldSave {
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        }
        return screenshotImage
    }
    @IBAction func btShareAction(_ sender: Any) {
        if(!self.colorPickerView.isHidden){
             self.colorPickerView.isHidden = true
        }
        if(!self.optionViewOutlet.isHidden){
            self.optionViewOutlet.isHidden = true
        }
        
        let quoteImage : UIImage! = takeScreenshot()!
        let shareText = "Create Cool Quote Via "
        
        if (quoteImage != nil) {
            let vc = UIActivityViewController(activityItems: [shareText, quoteImage], applicationActivities: [])
            present(vc, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
            // Your code with delay
                self.optionViewOutlet.isHidden = false
        }
    }
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
