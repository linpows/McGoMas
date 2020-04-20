import SwiftUI

struct RKCell: View {
    
    var rkDate: RKDate
    
    var cellWidth: CGFloat
    
    var body: some View {
        Text(rkDate.getText())
            .fontWeight(rkDate.getFontWeight())
            .foregroundColor(rkDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 20))
            .background(rkDate.getBackgroundColor())
            .cornerRadius(cellWidth/2)
    }
}
