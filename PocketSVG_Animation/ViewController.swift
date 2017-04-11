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
  
  private let svgFileName = "USI-10ans"
  private let animDelay: CFTimeInterval = 0.15
  private let animDuration: CFTimeInterval = 4.0
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
    svgViewKit.frame = svgKitView.bounds
    svgKitView.addSubview(svgViewKit)
    
    animateLayerTree(layer: svgViewKit.image.caLayerTree)
  }
  
  private func animateLayerTree(layer: CALayer, delay: CFTimeInterval = 0.0) {
    if let sublayers = layer.sublayers {
      sublayers.forEach { [unowned self] in
        self.animateLayerTree(layer: $0, delay: delay + self.animDelay)
      }
    } else {
      let anim = buildKeyFrameAnimation(keyPath: "strokeEnd",
                                        values: [0.0, 1.0],
                                        keyTimes: [0.0, 1.0],
                                        duration: animDuration,
                                        delegate: nil,
                                        timingFunctions: [easing])
      layer.add(anim,
                forKey: "appear")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

