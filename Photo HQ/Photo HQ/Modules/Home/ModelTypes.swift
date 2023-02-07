//
//  ModelTypes.swift
//  Photo HQ
//
//  Created by Oleg M on 07/02/2023.
//

enum ModelTypes: String, CaseIterable {
    case rrdn512
    case SRResNet
    case SRGAN
    case Realesgan512
    
    static let `default` = ModelTypes.rrdn512
    
    mutating func next() {
        self = nextOnCicle()
    }
}


extension CaseIterable where Self.AllCases.Element: Equatable, Self.AllCases.Index == Int {
    typealias Element = Self.AllCases.Element
    
    func nextOnCicle() -> Element! {
        let allCases = Element.allCases
        guard let currentIndex = allCases.firstIndex(of: self) else { return allCases.first }
        let nextIndex = (currentIndex + 1) % allCases.count
        return allCases.count > nextIndex ? allCases[nextIndex] : allCases.first
    }
}
