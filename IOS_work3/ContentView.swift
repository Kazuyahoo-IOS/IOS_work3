//
//  ContentView.swift
//  IOS_work3
//
//  Created by 王瑋 on 2020/4/29.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var music = false
    @State private var showAlert = false
    @State private var name = "複習上次進度"
    @State private var selectDate = Date()
    @State private var pickindex = 0
    @State private var wordSize: Double = 25
    @State private var Counter: Int = 0
    @State private var showSecondPage = false
    @State private var state = 0
    let today = Date()
    let endDate = Calendar.current.date(byAdding: .hour, value: 3, to: Date())!
    var subject=["DS","Algo","OS","計組","離散","線代"]
    var background=["bg1","bg2","bg3","bg4","bg5"]
    var body: some View {
        VStack{
            Text("讀書計畫")
            Image("studyhard")
                .resizable()
                .frame(width:250,height:250)
                .scaledToFill()
                .clipped()
            Form{
                Section{
                    Picker(selection: $pickindex, label: Text("")) {
                        ForEach(0 ..< subject.count) { i in
                            Text(self.subject[i]).tag(i)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("本次進度", text: $name, onEditingChanged: { (editing) in
                        print("onEditingChanged", editing)
                        self.showAlert = true
                    }){
                        print(self.name)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        //.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 5))
                        .padding()
                        .alert(isPresented: $showAlert) { () -> Alert in
                            let result: String
                            if self.name.isEmpty {
                                result = "請輸入進度！"
                            } else {
                                result = self.name + ""
                            }
                            return Alert(title: Text(result))
                    }
                    DatePicker("結束時間", selection: self.$selectDate, in: self.today...endDate, displayedComponents:.hourAndMinute)
                    HStack {
                        if music {
                            Image("搖滾")
                                .resizable()
                                .frame(width: 64, height: 64)
                            Text("搖滾")
                            
                        } else {
                            Image("抒情")
                                .resizable()
                                .frame(width: 64, height: 64)
                            Text("抒情")
                        }
                        Toggle("音樂曲風", isOn: $music)
                    }
                }
                Section{
                    Stepper(value:self.$Counter,in:0...4){
                        Text("背景風格")
                            .padding(.trailing)
                        Text(background[Counter])
                            .padding(.leading)
                    }
                    HStack {
                        Text("字型大小")
                        Slider(value: self.$wordSize, in: 25...40,
                               minimumValueLabel: Image(systemName:
                                "textformat.size").imageScale(.small), maximumValueLabel: Image(systemName: "textformat.size").imageScale(.large)) {
                                    Text("")
                        }
                    }
                    Text("Text")
                        .font(.system(size:CGFloat(wordSize)))
                }
            }
            Button("生成計畫") {
                self.showSecondPage = true
                self.state+=1
            }.sheet(isPresented: self.$showSecondPage) {
                SecondView(music: self.$music, name: self.$name, selectDate: self.$selectDate, pickindex: self.$pickindex, wordSize: self.$wordSize, Counter:self.$Counter, state: self.$state)
            }
            .padding(.bottom,20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
