//
//  BoardList.swift
//  Trello_Colon
//
//  Created by Joonhwan Jeon on 2022/11/15.
//

import Foundation

class BoardList: NSObject, ObservableObject, Identifiable, Codable {
    
    private(set) var id = UUID()
    var boardID: UUID
    
    @Published var name: String
    @Published var cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case id, boardID, name, cards
    }
    
    init(name: String, cards: [Card] = [], boardID: UUID) {
        self.name = name
        self.cards = cards
        self.boardID = boardID
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.boardID = try container.decode(UUID.self, forKey: .boardID)
        self.name = try container.decode(String.self, forKey: .name)
        self.cards = try container.decode([Card].self, forKey: .cards)
        super.init()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(boardID, forKey: .boardID)
        try container.encode(name, forKey: .name)
        try container.encode(cards, forKey: .cards)
    }
}

extension BoardList: NSItemProviderWriting {
    
    static let typeIdentifier = "kr.co.joonhwan.Trello-Colon.BoardList"
    
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
    
    func cardIndex(id: UUID) -> Int? {
        cards.firstIndex { $0.id == id }
    }
    
    func addNewCardWithContent(_ content: String) {
        cards.append(Card(content: content, boardListID: id))
    }
    
    func removeCard(_ card: Card) {
        guard let cardIndex = cardIndex(id: card.id) else { return }
        cards.remove(at: cardIndex)
    }
    
    func moveCards(fromOffsets offsets: IndexSet, toOffset offset: Int) {
        cards.move(fromOffsets: offsets, toOffset: offset)
    }
}


extension BoardList: NSItemProviderReading {
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        [typeIdentifier]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        try JSONDecoder ().decode(Self.self, from: data)
    }
}
