//
//  ViewController.swift
//  PocketSVG_Animation
//
//  Created by Octo-RCO on 10/04/2017.
//  Copyright © 2017 Octo-RCO. All rights reserved.
//

import UIKit
import PocketSVG
import Macaw

class ViewController: UIViewController {
  @IBOutlet weak var pocketSVGView: UIView!
  @IBOutlet weak var macawView: MacawView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    drawPocketSVG()
  }
  
  private func drawPocketSVG() {
    let url = Bundle.main.url(forResource: "USI-10ans", withExtension: "svg")!
    drawFullSVG(atURL: url)
//    drawSVGPath(atURL: url)
  }
  
  private func drawFullSVG(atURL url: URL) {
    let svgImageView = SVGImageView(contentsOf: url)
    svgImageView.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
    pocketSVGView.addSubview(svgImageView)
  }
  
  private func drawSVGPath(atURL url: URL) {
    let paths = SVGBezierPath.pathsFromSVG(at: url)
    for path in paths {
      // Create a layer for each path
      let svgLayer = CAShapeLayer()
      svgLayer.path = path.cgPath
      
      // Set its display properties
      svgLayer.lineWidth   = 1
      svgLayer.lineJoin = kCALineJoinBevel
      
      svgLayer.strokeColor = UIColor(red: 8.0/255.0,
                                     green: 1.0,
                                     blue: 1.0,
                                     alpha: 1.0).cgColor
      svgLayer.fillColor = UIColor.clear.cgColor
      
      // Add it to the layer hierarchy
      pocketSVGView.layer.addSublayer(svgLayer)
    }
    pocketSVGView.layer.masksToBounds = false
    pocketSVGView.layer.backgroundColor = UIColor(red: 56.0/255.0,
                                         green: 63.0/255.0,
                                         blue: 63.0/255.0,
                                         alpha: 1.0).cgColor
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

