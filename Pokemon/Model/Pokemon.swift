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
    let secondaryType: String
    let flavorText: String
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


func getLargeTypeImage(type: String) -> UIImage {
    switch (type) {
    case Types.bugType:
        return LargeTypeImg.bugType
        
    case Types.darkType:
        return LargeTypeImg.darkType
        
    case Types.dragonType:
        return LargeTypeImg.dragonType
        
    case Types.electricType:
        return LargeTypeImg.electricType
        
    case Types.fairyType:
        return LargeTypeImg.fairyType
        
    case Types.fightType:
        return LargeTypeImg.fightType
        
    case Types.fireType:
        return LargeTypeImg.fireType
        
    case Types.flyingType:
        return LargeTypeImg.flyingType
        
    case Types.ghostType:
        return LargeTypeImg.ghostType
        
    case Types.grassType:
        return LargeTypeImg.grassType
        
    case Types.groundType:
        return LargeTypeImg.groundType
        
    case Types.iceType:
        return LargeTypeImg.iceType
        
    case Types.normalType:
        return LargeTypeImg.normalType
        
    case Types.poisonType:
        return LargeTypeImg.poisonType
        
    case Types.psychicType:
        return LargeTypeImg.psychicType
        
    case Types.rockType:
        return LargeTypeImg.rockType
        
    case Types.steelType:
        return LargeTypeImg.steelType
        
    case Types.waterType:
        return LargeTypeImg.waterType
        
    case Types.shadowType:
        return LargeTypeImg.shadowType
        
    default:
        return LargeTypeImg.unknownType
    }
}


func getTypeColors(type: String) -> UIColor {
    switch (type) {
    case Types.bugType:
        return TypeColors.bugType
        
    case Types.darkType:
        return TypeColors.darkType
        
    case Types.dragonType:
        return TypeColors.dragonType
        
    case Types.electricType:
        return TypeColors.electricType
        
    case Types.fairyType:
        return TypeColors.fairyType
        
    case Types.fightType:
        return TypeColors.fightType
        
    case Types.fireType:
        return TypeColors.fireType
        
    case Types.flyingType:
        return TypeColors.flyingType
        
    case Types.ghostType:
        return TypeColors.ghostType
        
    case Types.grassType:
        return TypeColors.grassType
        
    case Types.groundType:
        return TypeColors.groundType
        
    case Types.iceType:
        return TypeColors.iceType
        
    case Types.normalType:
        return TypeColors.normalType
        
    case Types.poisonType:
        return TypeColors.poisonType
        
    case Types.psychicType:
        return TypeColors.psychicType
        
    case Types.rockType:
        return TypeColors.rockType
        
    case Types.steelType:
        return TypeColors.steelType
        
    case Types.waterType:
        return TypeColors.waterType
        
    case Types.shadowType:
        return TypeColors.shadowType
        
    default:
        return TypeColors.unknownType
    }
}
