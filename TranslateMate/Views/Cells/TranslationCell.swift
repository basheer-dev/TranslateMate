//
//  TranslationCell.swift
//  TranslateMate
//
//  Created by Basheer Abdulmalik on 20/09/2023.
//

import UIKit

final class TranslationCell: UITableViewCell {
    static let id: String = "TranslationCell"
    
    private let copyIcon: UIImageView = ViewManager.shared.getIcon(named: "square.on.square", tintColor: .label)
    private let copyTapRegion: UIView = ViewManager.shared.getTapRegion()
    
    
    // MARK: - VIEWS
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // UI Configuration
        view.backgroundColor    = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 8
        view.layer.borderColor  = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        view.layer.borderWidth  = 1
        
        // Components
        view.addSubview(targetLanguageTitle)
        view.addSubview(copyIcon)
        view.addSubview(copyTapRegion)
        view.addSubview(translationLabel)
        view.addSubview(separator)
        view.addSubview(sourceLabel)
        
        // AutoLayout
        NSLayoutConstraint.activate([
            targetLanguageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            targetLanguageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            copyIcon.centerYAnchor.constraint(equalTo: targetLanguageTitle.centerYAnchor),
            copyIcon.trailingAnchor.constraint(equalTo: sourceLabel.trailingAnchor, constant: -8),
            copyIcon.widthAnchor.constraint(equalToConstant: 14),
            copyIcon.heightAnchor.constraint(equalToConstant: 14),
            
            copyTapRegion.topAnchor.constraint(equalTo: view.topAnchor),
            copyTapRegion.leadingAnchor.constraint(equalTo: copyIcon.leadingAnchor, constant: -15),
            copyTapRegion.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            copyTapRegion.bottomAnchor.constraint(equalTo: translationLabel.topAnchor),
            
            translationLabel.topAnchor.constraint(equalTo: targetLanguageTitle.bottomAnchor, constant: 8),
            translationLabel.leadingAnchor.constraint(equalTo: targetLanguageTitle.leadingAnchor),
            translationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            separator.topAnchor.constraint(equalTo: sourceLabel.topAnchor),
            separator.leadingAnchor.constraint(equalTo: translationLabel.leadingAnchor, constant: 2),
            separator.widthAnchor.constraint(equalToConstant: 1),
            separator.bottomAnchor.constraint(equalTo: sourceLabel.bottomAnchor),
            
            sourceLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 15),
            sourceLabel.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 15),
            sourceLabel.trailingAnchor.constraint(equalTo: translationLabel.trailingAnchor),
            sourceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
        
        return view
    }()
    
    private let targetLanguageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // UI Configuration
        label.font          = .systemFont(ofSize: 16, weight: .bold)
        label.textColor     = .link
        label.numberOfLines = 0
        
        return label
    }()
    
    private let translationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.isUserInteractionEnabled = true
        
        // UI Configuration
        label.font          = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // UI Configuration
        view.backgroundColor = .link
        
        return view
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // UI Configuration
        label.font          = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor     = .systemGray
        
        return label
    }()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
        
        backgroundColor = .clear
        selectionStyle  = .none
        
        configureGestures()
        configureSubviews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureGestures() {
        let copyGesture = UITapGestureRecognizer(target: self, action: #selector(copyTranslation))
        copyTapRegion.addGestureRecognizer(copyGesture)
    }
    
    
    func set(translation: Translation) {
        targetLanguageTitle.text = translation.target
        translationLabel.text    = translation.translation
        sourceLabel.text         = translation.sourceText
    }
    
    // MARK: - ACTIONS
    @objc private func copyTranslation() {
        ViewManager.shared.animateIcon(icon: copyIcon, tapRegion: copyTapRegion)
        UIPasteboard.general.string = translationLabel.text
    }
    
    // MARK: - SUBVIEWS
    private func configureSubviews() {
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}
