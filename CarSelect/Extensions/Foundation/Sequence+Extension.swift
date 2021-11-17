//
//  Sequence+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import Foundation

extension RangeReplaceableCollection {
    /// Returns a collection containing, in order, the first instances of
    /// elements of the sequence that compare equally for the keyPath.
    public func filterDuplicates<T: Hashable>(
        for keyPath: KeyPath<Element, T>
    ) -> Self {
        var unique = Set<T>()
        return filter { unique.insert($0[keyPath: keyPath]).inserted }
    }

    /// Keeps only, in order, the first instances of
    /// elements of the collection that compare equally for the keyPath.
    /// var a = [1, 4, 2, 2, 6, 24, 15, 2, 60, 15, 6]; a.filterDuplicatesInPlace(for: \.self); -> a is [1, 4, 2, 6, 24, 15, 60]
    public mutating func filterDuplicatesInPlace<T: Hashable>(
        for keyPath: KeyPath<Element, T>
    ) {
        var unique = Set<T>()
        removeAll { !unique.insert($0[keyPath: keyPath]).inserted }
    }
}

extension Sequence {
    /// Returns an array containing, in order, the first instances of
    /// elements of the sequence that compare equally for the keyPath.
    /// let a = [1, 4, 2, 2, 6, 24, 15, 2, 60, 15, 6]; let b = a.filterDuplicates(for: \.self); -> b is [1, 4, 2, 6, 24, 15, 60]
    public func filterDuplicates<T: Hashable>(
        for keyPath: KeyPath<Element, T>
    ) -> [Element] {
        var unique = Set<T>()
        return filter { unique.insert($0[keyPath: keyPath]).inserted }
    }
}
