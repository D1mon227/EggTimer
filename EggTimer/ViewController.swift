//
//  ViewController.swift
//  EggTimer
//
//  Created by Dmitry Medvedev on 09.04.2023.
//

import UIKit
import SwiftUI
import SnapKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    private var timer = Timer()
    private var softEggLeft: Float = 3
    private var mediumEggLeft: Float = 4
    private var hardEggLeft: Float = 5
    
    private var secondsPassed: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "CBF2FC")
        addViews()
        addConstraints()
    }
    
    private lazy var verticalStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 39
        element.distribution = .fillEqually
        return element
    }()
    
    private lazy var labelView: UIView = {
        let element = UIView()
        element.contentMode = .scaleToFill
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.text = "How do you like your eggs?"
        element.font = UIFont.systemFont(ofSize: 30)
        element.textColor = .darkGray
        element.textAlignment = .center
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 20
        element.distribution = .fillEqually
        return element
    }()
    
    private lazy var softEggView: UIView = {
        let element = UIView()
        return element
    }()
    
    private lazy var mediumEggView: UIView = {
        let element = UIView()
        return element
    }()
    
    private lazy var hardEggView: UIView = {
        let element = UIView()
        return element
    }()
    
    private lazy var softEggImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "soft_egg")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private lazy var mediumEggImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "medium_egg")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private lazy var hardEggImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "hard_egg")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private lazy var softEggButton: UIButton = {
        let element = UIButton()
        element.setTitle("Soft", for: .normal)
        element.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        element.addTarget(self, action: #selector(softEggAction), for: .touchUpInside)
        return element
    }()
    
    private lazy var mediumEggButton: UIButton = {
        let element = UIButton()
        element.setTitle("Medium", for: .normal)
        element.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        element.addTarget(self, action: #selector(mediumEggAction), for: .touchUpInside)
        return element
    }()
    
    private lazy var hardEggButton: UIButton = {
        let element = UIButton()
        element.setTitle("Hard", for: .normal)
        element.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        element.addTarget(self, action: #selector(hardEggAction), for: .touchUpInside)
        return element
    }()
    
    private lazy var timerView: UIView = {
        let element = UIView()
        return element
    }()
    
    private lazy var progressView: UIProgressView = {
        let element = UIProgressView(progressViewStyle: .bar)
        element.progressTintColor = .systemYellow
        element.trackTintColor = .systemGray
        element.progress = 0.1
        return element
    }()
    
    private func addViews() {
        view.addSubview(verticalStack)
        
        verticalStack.addArrangedSubview(labelView)
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(timerView)
        
        horizontalStack.addArrangedSubview(softEggView)
        horizontalStack.addArrangedSubview(mediumEggView)
        horizontalStack.addArrangedSubview(hardEggView)
        
        labelView.addSubview(titleLabel)
        softEggView.addSubview(softEggImage)
        softEggView.addSubview(softEggButton)
        mediumEggView.addSubview(mediumEggImage)
        mediumEggView.addSubview(mediumEggButton)
        hardEggView.addSubview(hardEggImage)
        hardEggView.addSubview(hardEggButton)
        timerView.addSubview(progressView)
    }
    
    private func addConstraints() {
        
        verticalStack.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.snp_topMargin)
            make.leading.equalTo(view.snp_leadingMargin)
            make.trailing.equalTo(view.snp_trailingMargin)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        softEggImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        softEggButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        mediumEggImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        mediumEggButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        hardEggImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        hardEggButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.centerY.equalTo(timerView.snp.centerY)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(5)
        }
    }
    
    private func play(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @objc private func softEggAction() {
        timer.invalidate()
        if softEggButton.isTouchInside {
            titleLabel.text = "Soft"
            progressView.progress = 0
            secondsPassed = 0
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] Timer in
            if secondsPassed <= softEggLeft {
//                play(soundName: "alarm_sound")
                secondsPassed += 1
                let percentageProgress = secondsPassed / softEggLeft
                progressView.progress = percentageProgress
            } else {
                timer.invalidate()
                titleLabel.text = "DONE!"
                play(soundName: "alarm_sound")
            }
        }
    }

    @objc private func mediumEggAction() {
        timer.invalidate()
        if mediumEggButton.isTouchInside {
            titleLabel.text = "Medium"
            progressView.progress = 0
            secondsPassed = 0
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] Timer in
            if secondsPassed <= mediumEggLeft {
                secondsPassed += 1
                let percentageProgress = secondsPassed / mediumEggLeft
                progressView.progress = percentageProgress
            } else {
                timer.invalidate()
                titleLabel.text = "DONE!"
                play(soundName: "alarm_sound")
            }
        }
    }
    
    @objc private func hardEggAction() {
        timer.invalidate()
        if hardEggButton.isTouchInside {
            titleLabel.text = "Hard"
            progressView.progress = 0
            secondsPassed = 0
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] Timer in
            if secondsPassed <= hardEggLeft {
                secondsPassed += 1
                let percentageProgress = secondsPassed / hardEggLeft
                progressView.progress = percentageProgress
            } else {
                timer.invalidate()
                titleLabel.text = "DONE!"
                play(soundName: "alarm_sound")
            }
        }
    }
}

struct ContentViewController: UIViewControllerRepresentable {

    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewController()
            .edgesIgnoringSafeArea(.all)
            .colorScheme(.light) // or .dark
    }
}

