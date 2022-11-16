//
//  Card.swift
//  Trello_Colon
//
//  Created by Joonhwan Jeon on 2022/11/15.
//

import Foundation

class Card: NSObject, ObservableObject, Identifiable, Codable {
    
    private(set) var id = UUID()
    var boardListID: UUID
    
    @Published var content: String
    
    enum CodingKeys: String, CodingKey {
        case id, boardListID, content
    }
    
    init(content: String, boardListID: UUID) {
        self.content = content
        self.boardListID = boardListID
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.boardListID = try container.decode(UUID.self, forKey: .boardListID)
        self.content = try container.decode(String.self, forKey: .content)
        super.init()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(boardListID, forKey: .boardListID)
    }
}

extension Card: NSItemProviderWriting {
    
    static let typeIdentifier = "kr.co.joonhwan.Trello-Colon.Card"
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        [typeIdentifier]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            completionHandler(try encoder.encode(self), nil)
        } catch {
            completionHandler(nil, error)
        }
        return nil
    }
}

extension Card: NSItemProviderReading {
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        [typeIdentifier]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}
