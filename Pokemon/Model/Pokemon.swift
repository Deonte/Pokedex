//
//  Pokemon.swift
//  Pokemon
//
//  Created by Deonte on 10/13/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

struct Pokemon {
    let name: String
    let id: Int
    let sprite: String
    let primaryType: String
    let primaryTypeImage: UIImage
    let secondaryType: String
    let secondaryTypeImage: UIImage
}


func getTypeImage(type: String) -> UIImage {
    switch (type) {
    case Types.bugType:
        return SmallTypeImgs.bugType
        
    case Types.darkType:
        return SmallTypeImgs.darkType
        
    case Types.dragonType:
        return SmallTypeImgs.dragonType
        
    case Types.electricType:
        return SmallTypeImgs.electricType
        
    case Types.fairyType:
        return SmallTypeImgs.fairyType
        
    case Types.fightType:
        return SmallTypeImgs.fightType
        
    case Types.fireType:
        return SmallTypeImgs.fireType
        
    case Types.flyingType:
        return SmallTypeImgs.flyingType
        
    case Types.ghostType:
        return SmallTypeImgs.ghostType
        
    case Types.grassType:
        return SmallTypeImgs.grassType
        
    case Types.groundType:
        return SmallTypeImgs.groundType
        
    case Types.iceType:
        return SmallTypeImgs.iceType
        
    case Types.normalType:
        return SmallTypeImgs.normalType
        
    case Types.poisonType:
        return SmallTypeImgs.poisonType
        
    case Types.psychicType:
        return SmallTypeImgs.psychicType
        
    case Types.rockType:
        return SmallTypeImgs.rockType
        
    case Types.steelType:
        return SmallTypeImgs.steelType
        
    case Types.waterType:
        return SmallTypeImgs.waterType
        
    case Types.shadowType:
        return SmallTypeImgs.shadowType
        
    default:
        return SmallTypeImgs.unknownType
    }
}
