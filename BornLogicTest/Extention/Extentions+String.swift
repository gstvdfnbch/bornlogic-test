import UIKit

extension String {
    func formatDateString() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
    
    func removingPattern() -> String {
        let pattern = "\\[[^\\]]*\\]" // Expressão regular para encontrar todos os caracteres entre colchetes
        return self.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
    }
}

