//
//  MusicTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
import SnapKit

class MusicTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES ============================================================================

    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var musicIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "music.note", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    // MARK: INITIALIZATORS ============================================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(trackNameLabel, musicIcon)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================

    func setupLayout() {
                
        musicIcon.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(12)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(musicIcon.snp.trailing).offset(12)
        }
    }
    
    func setConfigureOfCell(model: MusicViewModel, index: Int) {
        
        var currentTrackName: String {
            get {
                let singer = Array(MusicViewModel.tracks.values)[index]
                let track = Array(MusicViewModel.tracks.keys)[index]
                return "\(singer) - \(track)"
            }
        }
        
        trackNameLabel.text = currentTrackName
    }
}
