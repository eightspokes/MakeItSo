//
//  ReminderToggleStyle.swift
//  MakeItSo
//
//  Created by Roman on 7/25/23.
//

import SwiftUI

struct ReminderToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
      HStack {
          Image(systemName: configuration.isOn
               ? "largecircle.fill.circle"
               : "circle")
           .resizable()
           .frame(width: 24, height: 24)
           .foregroundColor(configuration.isOn ? .accentColor : .gray)
           .onTapGesture {
               configuration.isOn.toggle()
           }
          configuration.label
       }
  }
}

struct ReminderToggleStyle_Previews: PreviewProvider {
    struct Container: View{
        @State var isOn = false
        var body: some View{
            Toggle(isOn: $isOn) {Text("Hello")}
              .toggleStyle(ReminderToggleStyle())
        }
    }
    static var previews: some View {
         Container()
  }
}

extension ToggleStyle where Self == ReminderToggleStyle {
    static var reminder: ReminderToggleStyle{
        ReminderToggleStyle()
    }
}
