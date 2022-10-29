//
//  ViewController.swift
//  FoodApp
//
//  Created by Burak Ertaş on 18.10.2022.
//

import UIKit
import Lottie

class OnboardingScreen: UIViewController {

    @IBOutlet weak var lottie: LottieAnimationView!
    @IBOutlet weak var onboardImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        onboardImage.bounds.size.width = view.bounds.size.width
        onboardImage.bounds.size.height = view.bounds.size.height * 0.4
        
        onboardImage.imageConfig()
        
        // 1. Set animation content mode
        lottie.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        lottie.loopMode = .loop
        // 3. Adjust animation speed
        lottie.animationSpeed = 0.5
        // 4. Play animation
        lottie.play()
        
        
        
    }


}
