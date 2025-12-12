import Foundation

// MARK: - Simulated API call
func fetchFruitPrice(fruit: String) async -> Double {
    // Simulate network delay
    try? await Task.sleep(nanoseconds: UInt64.random(in: 1_000_000_000...2_000_000_000))
    
    let prices: [String: Double] = [
        "Apple": 1.2,
        "Banana": 0.8,
        "Orange": 1.0,
        "Mango": 2.5
    ]
    
    print("✅ Fetched price for \(fruit)")
    return prices[fruit] ?? 0.0
}

// MARK: - Using async/await + TaskGroup
func fetchAllPrices() async {
    let fruits = ["Apple", "Banana", "Orange", "Mango"]
    
    print("🍏 Fetching fruit prices concurrently...\n")
    
    // Create a task group to fetch multiple prices concurrently
    // withTaskGroup is a function that creates a group of child tasks
    // why Double? that's the return type of the whole task group closure
    let totalPrice = await withTaskGroup(of: Double.self) { group -> Double in
        var total: Double = 0
        
        for fruit in fruits {
            group.addTask {
                await fetchFruitPrice(fruit: fruit)
            }
        }
        
        // Wait for all tasks to complete
        for await price in group {
            total += price
        }
        
        return total
    }
    
    print("\n💰 All prices fetched! Total = \(totalPrice)")
}

// MARK: - Entry point
Task {
    await fetchAllPrices()
    print("\n🏁 Done! Ready to proceed to next step.")
}

