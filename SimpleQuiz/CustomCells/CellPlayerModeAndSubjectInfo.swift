//
//  CellPlayerModeAndSubjectInfo.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

final class CellPlayerModeAndSubjectInfo: UITableViewCell {

    // MARK: Iboutlets
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    func setData(titleAndImage: (String, UIImage?)) {
        self.labelName.text = titleAndImage.0
        self.imageViewIcon.image = titleAndImage.1 ?? UIImage(named: ImageNames.PlaceHolder)
    }
}
