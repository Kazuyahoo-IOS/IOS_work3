//
//  SecondView.swift
//  IOS_work3
//
//  Created by 王瑋 on 2020/5/2.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Binding  var music:Bool
    @Binding  var name:String
    @Binding  var selectDate:Date
    @Binding  var pickindex:Int
    @Binding  var wordSize: Double
    @Binding  var Counter: Int
    @Binding  var state :Int
    var subject=["DS","Algo","OS","計組","離散","線代"]
    var background=["bg1","bg2","bg3","bg4","bg5"]
    @State private var show = false
    @State private var snackTime = Date()
    @State private var showingSheet = false
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    var body: some View {
        VStack{
            Spacer()
            VStack{
                if show{
                    TextView(text: "科目:\t"+subject[pickindex]+"\n進度:\t"+name+"\n時間:\t"+dateFormatter.string(from: snackTime))
                        .font(.system(size:CGFloat(wordSize)))
                        .transition(.opacity)
                        .contextMenu {
                            Button(action: {
                                self.show=false
                            }) {
                                HStack {
                                    Text("Disappear!")
                                    Image(systemName: "trash.fill")
                                }
                            }
                            Button(action: {
                            }) {
                                HStack {
                                    Text("Nothing happened")
                                    Image(systemName: "trash.slash")
                                }
                            }
                    }
                }
            }.animation(.easeInOut(duration:3))
                .onAppear {
                    self.show = true
                    
            }
            .onDisappear {
                self.show = false
            }
            
            Spacer()
            Button(action: {
                self.showingSheet = true
                self.show=true
            }) {
                Text("讀書計畫不見了嗎:((")
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(30)
            }
            .actionSheet(isPresented: $showingSheet) {
                ActionSheet(title: Text("我想加分:))"), message: Text("彼得真的好帥"), buttons: [.default(Text("Dismiss Action Sheet"))])
            }
            Music(music: $music, state: $state)
        }.background(Image(background[Counter]).resizable().scaledToFill())
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(music: .constant(true), name: .constant("Chapter1~2"), selectDate: .constant(Date()), pickindex: .constant(2), wordSize: .constant(25), Counter: .constant(5), state: .constant(0))
    }
}

struct TextView: View {
    var text:String
    var body: some View {
        Text(text)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(30)
    }
}
