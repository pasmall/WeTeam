




import UIKit

class HudView: UIView {
    var text = ""
    var label: UILabel!
    var imageView: UIImageView!
    var wid: CGFloat?
    
    /**
     *  话筒线的view
     */
//    var outsideLineView:UIView!
//    
//    /**
//     *  话筒线的layer
//     */
//    var outsideLineLayer:CAShapeLayer!
//    /**
//     *  话筒view
//     */
//    var colidView:UIView!
//    /**
//     *  话筒layer
//     */
//    var colidLayer:CAShapeLayer!
//    /**
//     *  圆弧view
//     */
//    var arcView:UIView!
//    /**
//     *  圆弧layer
//     */
//    var arcLayer:CAShapeLayer!
//    /**
//     *  线宽
//     */
//    var lineWidth:CGFloat = 0.0
//    /**
//     *  线的颜色
//     */
//    var lineColor:UIColor!
//    /**
//     *  话筒颜色
//     */
//    var colidColor:UIColor!
    

    
    class func hudInView(view: UIView, animated: Bool) -> HudView {
        let hudView = HudView(frame:view.bounds)
        hudView.isOpaque = false
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        hudView.showAnimated(animated: animated)
        return hudView
    }
    
    
  
    override func draw(_ rect: CGRect) {
        var boxWidth: CGFloat = 96
        var boxHeight: CGFloat = 96
        
        if let wid = wid {
            boxWidth = wid
            boxHeight = wid
        }
        
        let labelSpace: CGFloat = 7
        let labelAddHeight: CGFloat = 4
        
        let boxRect = CGRect(
          x: round((bounds.size.width - boxWidth) / 2),
          y: round((bounds.size.height - boxHeight) / 2),
          width: boxWidth,
          height: boxHeight)
        
        let roundedRect = UIBezierPath(roundedRect: boxRect, cornerRadius: 10)
        UIColor(white: 0.302, alpha: 0.8).setFill()
        roundedRect.fill()
       
        //声音

//        self.lineColor = UIColor.red
//        self.colidColor = UIColor.red
//        self.lineWidth = 1.0
//        
//        
//        
//        //话筒内部
//        
//        self.colidView = UIView.init(frame: CGRect.init(x: self.width*0.38, y: self.height*0.15, width: self.width*0.24, height: self.height*0.7))
//        self.colidView.layer.cornerRadius = self.colidView.width*0.4;
//        self.colidView.clipsToBounds = true;
//        self.colidLayer = self.drawOutSideLine(frame: CGRect.init(x: 0, y: 0, width: self.colidView.width, height: 0), color: self.colidColor, fill: true)
//        self.colidView.layer.addSublayer(self.colidLayer)
//        self.addSubview(self.colidView)
//        
//        //话筒边框
//        self.outsideLineView = UIView.init(frame:  CGRect.init(x: self.width*0.38, y: self.height*0.15, width: self.width*0.24, height: self.height*0.7))
//        self.outsideLineLayer = self.drawOutSideLine(frame: CGRect.init(x: 0, y: 0, width: self.colidView.width, height: 0), color: self.lineColor, fill: false)
//
//        self.outsideLineView.layer.addSublayer(self.outsideLineLayer)
//        self.addSubview(self.outsideLineView)
//        
//        
//        
//        //话筒弧
//        self.arcView = UIView.init(frame: CGRect.init(x: 0, y: self.height*0.09, width: self.width, height: self.height*0.6))
//        self.arcLayer = self.drawARCLine(point: self.arcView.center, frame: self.arcView.frame, color: self.lineColor)
//        self.arcView.layer.addSublayer(self.arcLayer)
//        self.addSubview(self.arcView)
        
        
        
        //文字
        let attribs = [ NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.white ]
        let textSize = text.size(attributes: attribs)
//        let textPoint = CGPoint(
//          x: center.x - round(textSize.width / 2),
//          y: center.y - round(textSize.height / 2) + boxHeight / 4)
//        text.draw(at: textPoint, withAttributes: attribs)
        
        label = UILabel(frame: CGRect(x: center.x - boxWidth / 2 + labelSpace, y: center.y + boxHeight / 2 - labelSpace - textSize.height - labelAddHeight, width: boxWidth - labelSpace * 2, height: textSize.height + labelAddHeight))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.colorFromRGB(0xFFFFFF)
        label.textAlignment = .center
        label.text = text
        label.layer.cornerRadius = textSize.height / 4
        label.layer.masksToBounds = true
        self.addSubview(label)
        
        
        //image view
        let imageWidth = (boxWidth - labelSpace * 2 - textSize.height) * 3 / 5
        imageView = UIImageView(frame: CGRect(x: center.x - imageWidth / 2, y: center.y - textSize.height / 2 - imageWidth / 2, width: imageWidth, height: imageWidth))
        imageView.image = UIImage(named: "recordNoVolume")
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        
        
        
    }
    
    
//    func drawARCLine(point:CGPoint , frame:CGRect ,color:UIColor  ) -> CAShapeLayer {
//        let  Layer = CAShapeLayer()
//        Layer.fillColor = nil; //这个是填充颜色
//        Layer.strokeColor = color.cgColor; //这个边框颜色
//        Layer.frame = frame; //这个是大小
//        Layer.lineWidth = self.lineWidth; //这个是线宽
//        Layer.lineCap = kCALineCapRound; //这个我也不知道
//        //这个就是画图
//        Layer.path = UIBezierPath.init(arcCenter: CGPoint.init(x: point.x, y:  point.y), radius: frame.size.width*0.3, startAngle: (3.14159265359 * -5)/180, endAngle: (3.14159265359 * 185)/180, clockwise: true).cgPath
//        
////        Layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(point.x, point.y) radius:frame.size.width*0.3 startAngle:PQ_RADIANS(-5) endAngle:PQ_RADIANS(185) clockwise:YES].CGPath;
//        return Layer;
//    }
    
    
//    func drawOutSideLine(frame:CGRect,color:UIColor,fill:Bool) -> CAShapeLayer {
//        let Layer = CAShapeLayer();
//        if (fill) {
//            Layer.fillColor = color.cgColor;
//            Layer.strokeColor = nil;
//        }
//        else{
//            Layer.fillColor = nil; //这个是填充颜色
//            Layer.strokeColor = color.cgColor; //这个边框颜色
//        }
//        
//        Layer.frame = frame; //这个是大小
//        Layer.lineWidth = self.lineWidth; //这个是线宽
//        Layer.lineCap = kCALineCapRound; //这个我也不知道
//        //这个就是画图
//        Layer.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height), cornerRadius: frame.size.width*0.4).cgPath
////        Layer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height)  cornerRadius:frame.size.width*0.4].CGPath;
//        return Layer;
//    }
    
    
    
//    func updateVoiceViewWithVolume(volume:CGFloat)  {
//        let height = self.colidView.height;
//        let newHeight = height*volume;
//        let W  = self.colidView.width;
//        
//        self.colidLayer.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: height - newHeight, width: W, height: newHeight), cornerRadius: 0).cgPath
////        self.colidLayer.path = UIBezierPath.bezierPathWithRoundedRect:CGRect.init(x: 0, y: height - newHeight, width: width, height: newHeight).cgPath;
//        
//    }
//    

    
      
    func showAnimated(animated: Bool) {
  
        if animated {
            alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
            })
        }
    }
        
    func hideAnimated(view: UIView,animated: Bool){
        if animated {
            alpha = 1
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            })
        }else{
            self.alpha = 0
        }
        view.isUserInteractionEnabled = true
    }
    
}

