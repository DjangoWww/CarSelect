//
//  Array+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import Foundation

// MARK: - out of range related
extension Array {
    /// prevent out of range
    public subscript(
        safe index: Int
    ) -> Element? {
        return (0 <= index && count > index) ? self[index] : nil
    }
}
extension NSArray {
    /// prevent out of range
    public subscript(
        safe index: Int
    ) -> Element? {
        return (0 <= index && count > index) ? self[index] : nil
    }
}

// MARK: - get count related
extension Array {
    /// get not fixed count between  min adn max, use nil to fill if thats not enough
    public func getNotFixedCount(
        min: Int,
        max: Int
    ) -> [Element?] {
        if count < min { // less than min
            return getExactCount(min)
        } else { // return getMaxCount
            return getMaxCount(max)
        }
    }

    /// get not fixed count between  min adn max, use fillElementBody to fill if thats not enough
    public func getNotFixedCount(
        min: Int,
        max: Int,
        fillElementBody: (Int) -> Element
    ) -> [Element] {
        if count < min { // // less than min
            return getExactCount(min, fillElementBody: fillElementBody)
        } else { // return getMaxCount
            return getMaxCount(max)
        }
    }

    /// get subArray for a specified count
    public func getMaxCount(
        _ num: Int
    ) -> [Element] {
        let numT: Int
        if num < 0 {
            let msg = "num can't be under 0"
            printDebug(msg, assertMessage: msg)
            numT = 0
        } else if num > count {
            let msg = "num can't be above the count"
            printDebug(msg, assertMessage: msg)
            numT = count
        } else {
            numT = num
        }
        return Array(self[0..<numT])
    }

    /// get exact count of an array, use fillElementBody to fill if thats not enough
    public func getExactCount(
        _ num: Int,
        fillElementBody: (Int) -> Element
    ) -> [Element] {
        let numT: Int
        if num >= 0 { numT = num } else {
            let msg = "num can't be under 0"
            printDebug(msg, assertMessage: msg)
            numT = 0
        }
        guard numT >= count else { return Array(self[0..<numT]) }
        let extra = (count..<numT).map(fillElementBody)
        return self + extra
    }

    /// get exact count of an array, use nil to fill if thats not enough
    public func getExactCount(
        _ num: Int
    ) -> [Element?] {
        let numT: Int
        if num >= 0 { numT = num } else {
            let msg = "num can't be under 0"
            printDebug(msg, assertMessage: msg)
            numT = 0
        }
        guard numT >= count else { return Array(self[0..<numT]) }
        let extra = (count..<numT).map { _ in Optional<Element>(nil) }
        return self + extra
    }
}

// MARK: - Comparative
extension Array where Element: Hashable {
    /// get Set value of an array
    public func setValue() -> Set<Array.Element> {
        return Set(self)
    }

    /// Judge if array is a subset to another
    public func isSubset(of array: Array) -> Bool {
        setValue().isSubset(of: array.setValue())
    }

    /// Judge if array is a superset to another
    public func isSuperset(of array: Array) -> Bool {
        setValue().isSuperset(of: array.setValue())
    }

    /// Get common elements between two array
    public func commonElements(between array: Array) -> Array {
        let intersection = setValue().intersection(array.setValue())
        return intersection.map { $0 }
    }

    /// Judge if two array has any common elements
    public func hasCommonElements(with array: Array) -> Bool {
        return commonElements(between: array).count >= 1 ? true : false
    }
}

// MARK: - Sorting
extension Array where Element: Comparable {
    /// Insertion sort
    public func insertionSort() -> Array<Element> {
        // check for trivial case
        guard count > 1 else {
            return self
        }
        // mutated copy
        var output: Array<Element> = self
        for primaryindex in 0..<output.count {
            let key = output[primaryindex]
            var secondaryindex = primaryindex
            while secondaryindex > -1 {
                if key < output[secondaryindex] {
                    // move to correct position
                    output.remove(at: secondaryindex + 1)
                    output.insert(key, at: secondaryindex)
                }
                secondaryindex -= 1
            }
        }
        return output
    }

    /// BubbleSort
    public func bubbleSort() -> Array<Element> {
        // check for trivial case
        guard count > 1 else {
            return self
        }
        // mutated copy
        var output: Array<Element> = self
        for primaryIndex in 0..<count {
            let passes = (output.count - 1) - primaryIndex
            // "half-open" range operator
            for secondaryIndex in 0..<passes {
                let key = output[secondaryIndex]
                // compare / swap positions
                if (key > output[secondaryIndex + 1]) {
                    output.swapAt(secondaryIndex, secondaryIndex + 1)
                }
            }
        }
        return output
    }

    /// SelectionSort
    public func selectionSort() -> Array<Element> {
        // check for trivial case
        guard count > 1 else {
            return self
        }
        // mutated copy
        var output: Array<Element> = self
        for primaryindex in 0..<output.count {
            var minimum = primaryindex
            var secondaryindex = primaryindex + 1
            while secondaryindex < output.count {
                // store lowest value as minimum
                if output[minimum] > output[secondaryindex] {
                    minimum = secondaryindex
                }
                secondaryindex += 1
            }
            // swap minimum value with array iteration
            if primaryindex != minimum {
                output.swapAt(primaryindex, minimum)
            }
        }
        return output
    }
}

// MARK: - algorithm related
// https://github.com/raywenderlich/swift-algorithm-club
extension Array {
    private func _chopped() -> (Element, [Element])? {
        guard let x = first else { return nil }
        return (x, Array(suffix(from: 1)))
    }

    private func _interleaved(_ element: Element) -> [[Element]] {
        guard let (head, rest) = _chopped() else { return [[element]] }
        return [[element] + self] + rest._interleaved(element).map { [head] + $0 }
    }

    /// Get Pn where n = count
    public func getPermutations() -> [[Element]] {
        guard let (head, rest) = _chopped() else { return [[]] }
        return rest.getPermutations()
            .flatMap { $0._interleaved(head) }
    }

    /// Get Px where x = size
    public func getPermutations(
        with size: Int
    ) -> [[Element]] {
        return getCombinations(with: size)
            .map { $0.getPermutations() }
            .flatMap { $0 }
    }

    /// Get Px where x = size
    public func getCombinations(
        with size: Int
    ) -> [[Element]] {
        guard size <= count && size > 0 && count != 0 else {
            printDebug("x is bigger than n",
                       assertMessage: "x is bigger than n")
            return []
        }
        guard size != count else {
            // get Cn
            return [self]
        }
        guard size != 1 else {
            // get Cn where n == 1
            return map { [$0] }
        }
        var combs: [[Element]] = []
        for i in 0...(count - size) {
            let tails = Array(self[(i+1)..<endIndex]).getCombinations(with: size - 1)
            for tail in tails {
                let element = [self[i]] + tail;
                combs.append(element);
            }
        }
        return combs;
    }
}

// MARK: - Check empty
extension Array {
    /// Check empty using optional chain
    public func checkEmpty() -> Self? {
        return isEmpty ? nil : self
    }
}
