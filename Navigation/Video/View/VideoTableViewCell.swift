//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
import SnapKit

class VideoTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES ============================================================================

    private lazy var videoNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var videoIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "video", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    // MARK: INITIALIZATORS ============================================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================

    func setupLayout() {
        
        contentView.addSubviews(videoNameLabel, videoIcon)

        videoIcon.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(12)
        }
        
        videoNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(videoIcon.snp.trailing).offset(12)
        }
    }
    
    func setConfigureOfCell(index: Int) {
        videoNameLabel.text = Array(VideoViewModel.videos.values)[index]
    }
}

