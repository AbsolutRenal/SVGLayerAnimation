//
//  ViewController.swift
//  PocketSVG_Animation
//
//  Created by Octo-RCO on 10/04/2017.
//  Copyright © 2017 Octo-RCO. All rights reserved.
//

import UIKit
import SVGKit

extension UIColor {
  static let usiGray = UIColor(red: 56.0/255.0,
                               green: 63.0/255.0,
                               blue: 63.0/255.0,
                               alpha: 1.0)
  static let usiBlue = UIColor(red: 8.0/255.0,
                               green: 1.0,
                               blue: 1.0,
                               alpha: 1.0)
}

class ViewController: UIViewController, Animatable {
  @IBOutlet weak var svgKitView: UIView!
  
  private let svgFileName = "10ans"
  private let animDelay: Float = 0.15
  private let animDuration: CFTimeInterval = 4.0
  private let randomDelaySeed: UInt32 = 30
  private let randomDelayDivider: Float = 60.0
  private let easing = CAMediaTimingFunction(controlPoints: 0.5,
                                             1.0,
                                             0.8,
                                             1.0)

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    drawSVGKit()
  }
  
  private func drawSVGKit() {
    let image = SVGKImage(named: svgFileName)
    guard let imageKit = image else {
      return
    }
    let svgView = SVGKLayeredImageView(svgkImage: imageKit)
    guard let svgViewKit = svgView else {
      return
    }
//    svgViewKit.translatesAutoresizingMaskIntoConstraints = false
//    svgViewKit.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    svgViewKit.frame = svgKitView.bounds
    svgKitView.addSubview(svgViewKit)
    
    animateLayerTree(layer: svgViewKit.image.caLayerTree)
  }
  
  private func randomDelay() -> Float {
    let random = arc4random_uniform(randomDelaySeed)
    return Float(random) / randomDelayDivider
  }
  
  private func animateLayerTree(layer: CALayer, delay: Float = 0.0) {
    if let sublayers = layer.sublayers {
      sublayers.forEach { [unowned self] in
        self.animateLayerTree(layer: $0, delay: delay + self.animDelay)
      }
    } else {
      if let shape = layer as? CAShapeLayer {
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.usiGray.cgColor
        let anim = buildKeyFrameAnimation(keyPath: "strokeEnd",
                                          values: [0.0, 1.0],
                                          keyTimes: [NSNumber(value: delay + randomDelay()), 1.0],
                                          duration: animDuration,
                                          delegate: nil,
                                          timingFunctions: nil)
        shape.add(anim,
                  forKey: "appear")
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

