//
//  TreeView.swift
//
//
//  Created by Afonso Lucas on 15/02/24.
//

import SwiftUI


struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    
    static var defaultValue: [Key: Value] { [:] }
    
    static func reduce(value: inout [Key: Value],
                       nextValue: () -> [Key: Value])
    {
        value.merge(nextValue()) { _, new in new }
    }
}

struct NodeStructureView<V: View>: View {
    
    let node: TreeViewModel
    let nodeViewBuilder: (TreeViewModel) -> V
    
    typealias Key = CollectDict<TreeViewModel.ID, Anchor<CGPoint>>
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            nodeViewBuilder(node)
                .anchorPreference(key: Key.self, value: .center) { anchor in
                    [self.node.id: anchor]
                }
            
            HStack(alignment: .top, spacing: 20) {
                ForEach(node.children) { child in
                    NodeStructureView(node: child, nodeViewBuilder: nodeViewBuilder)
                }
            }
        }
        .backgroundPreferenceValue(Key.self) { centers in
            GeometryReader { proxy in
                ForEach(node.children) { child in
                    if let r_t = centers[node.id], let c_t = centers[child.id] {
                        Line(
                            from: proxy[r_t],
                            to: proxy[c_t]
                        )
                        .stroke(Color.DefaultBlack)
                    }
                }
            }
        }
    }
}
