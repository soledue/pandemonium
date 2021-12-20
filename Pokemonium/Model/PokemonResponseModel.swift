//
//  PokemonResponseModel.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import Foundation
struct PokemonDetailModel: Codable {
    let abilities: [AbilityResponseModel]?
    let baseExperience: Int?
    let forms: [SpeciesResponseModel]?
    let gameIndices: [GameIndexResponseModel]?
    let height: Int?
    let heldItems: [HeldItemResponseModel]?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [MoveResponseModel]?
    let name: String?
    let order: Int?
    let species: SpeciesResponseModel?
    let sprites: SpritesResponseModel?
    let stats: [StatResponseModel]?
    let types: [TypeElementResponseModel]?
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case species, sprites, stats, types, weight
    }
}

struct AbilityResponseModel: Codable {
    let ability: SpeciesResponseModel?
    let isHidden: Bool?
    let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct SpeciesResponseModel: Codable {
    let name: String?
    let url: String?
}

struct GameIndexResponseModel: Codable {
    let gameIndex: Int?
    let version: SpeciesResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

struct HeldItemResponseModel: Codable {
    let item: SpeciesResponseModel?
    let versionDetails: [VersionDetailResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

struct VersionDetailResponseModel: Codable {
    let rarity: Int?
    let version: SpeciesResponseModel?
}

struct MoveResponseModel: Codable {
    let move: SpeciesResponseModel?
    let versionGroupDetails: [VersionGroupDetailResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct VersionGroupDetailResponseModel: Codable {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: SpeciesResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

struct GenerationV: Codable {
    let blackWhite: SpritesResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

struct GenerationIv: Codable {
    let diamondPearl, heartgoldSoulsilver, platinum: SpritesResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

struct Versions: Codable {
    let generationI: GenerationI?
    let generationIi: GenerationIi?
    let generationIii: GenerationIii?
    let generationIv: GenerationIv?
    let generationV: GenerationV?
    let generationVi: [String: Home]?
    let generationVii: GenerationVii?
    let generationViii: GenerationViii?
    
    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }
}

class SpritesResponseModel: Codable {
    let backDefault, backFemale, backShiny, backShinyFemale: String?
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
    let other: Other?
    let versions: Versions?
    let animated: SpritesResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }
    
    init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?, other: Other?, versions: Versions?, animated: SpritesResponseModel?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }
}

struct GenerationI: Codable {
    let redBlue, yellow: RedBlue?
    
    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

struct RedBlue: Codable {
    let backDefault, backGray, backTransparent, frontDefault: String?
    let frontGray, frontTransparent: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backGray = "back_gray"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
        case frontTransparent = "front_transparent"
    }
}

struct GenerationIi: Codable {
    let crystal: Crystal?
    let gold, silver: Gold?
}

struct Crystal: Codable {
    let backDefault, backShiny, backShinyTransparent, backTransparent: String?
    let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backShinyTransparent = "back_shiny_transparent"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontShinyTransparent = "front_shiny_transparent"
        case frontTransparent = "front_transparent"
    }
}

struct Gold: Codable {
    let backDefault, backShiny, frontDefault, frontShiny: String?
    let frontTransparent: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontTransparent = "front_transparent"
    }
}

struct GenerationIii: Codable {
    let emerald: Emerald?
    let fireredLeafgreen, rubySapphire: Gold?
    
    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

struct Emerald: Codable {
    let frontDefault, frontShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct Home: Codable {
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct GenerationVii: Codable {
    let icons: DreamWorld?
    let ultraSunUltraMoon: Home?
    
    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

struct DreamWorld: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct GenerationViii: Codable {
    let icons: DreamWorld?
}

struct Other: Codable {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct StatResponseModel: Codable {
    let baseStat, effort: Int?
    let stat: SpeciesResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct TypeElementResponseModel: Codable {
    let slot: Int?
    let type: SpeciesResponseModel?
}
