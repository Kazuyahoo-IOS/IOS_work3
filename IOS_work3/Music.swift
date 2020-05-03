//
//  Music.swift
//  IOS_work3
//
//  Created by 王瑋 on 2020/5/2.
//  Copyright © 2020 王瑋. All rights reserved.
//

import SwiftUI
import AVFoundation
import MediaPlayer

struct Music: View {
    @State var play = true
    @State var judge:Int=0
    @Binding  var music:Bool
    @Binding  var state:Int
    //@State var looper: AVPlayerLooper?
    let player = AVPlayer()
    let commandCenter = MPRemoteCommandCenter.shared()
    func musicfun(music:Bool)->String{
        var myMusic="抒情"
        if music{
            myMusic="搖滾"
        }else{
            myMusic="抒情"
        }
        return myMusic
    }
    var body: some View {
        HStack{
            Image(self.musicfun(music: self.music))
                .resizable()
                .frame(width:50,height:50)
                .scaledToFill()
                .padding(.trailing,40)
            Text("Keep on going !")
                .font(.system(size:22))
                .bold()
                .foregroundColor(Color.white)
            Spacer()
            Button(action: {
                let fileUrl=Bundle.main.url(forResource:self.musicfun(music: self.music),withExtension: "mp3")
                let playerItem = AVPlayerItem(url: fileUrl!)
                //self.looper = AVPlayerLooper(player: self.player, templateItem: playerItem)
                if(self.judge != self.state){
                    //self.player.pause()
                    self.player.replaceCurrentItem(with: playerItem)
                    self.judge=self.state
                }
                self.play.toggle()
                if self.play{
                    self.player.pause()
                }
                else{
                    do {
                        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    }
                    catch {
                        // report for an error
                    }
                    self.player.play()
                }
                self.commandCenter.playCommand.addTarget {  event in
                    if self.player.rate == 0.0 {
                        do {
                            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                        }
                        catch {
                            // report for an error
                        }
                        self.player.play()
                        return .success
                    }
                    return .commandFailed
                }

                self.commandCenter.pauseCommand.addTarget {  event in
                    if self.player.rate == 1.0 {
                        self.player.pause()
                        return .success
                    }
                    return .commandFailed
                }
                
            }){
                Image(systemName: play ? "play.circle" : "pause.circle")
                    .resizable()
                    .frame(width:40,height:40)
                    .foregroundColor(Color.purple)
            }
        }
        .padding(10)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red:232/255,green:175/255,blue:237/255), Color(red:150/255,green:243/255,blue:252/255)]), startPoint: UnitPoint(x: 0.4, y: 0.4), endPoint: UnitPoint(x: 1, y: 1)))
    }
}

struct Music_Previews: PreviewProvider {
    static var previews: some View {
        Music( music: .constant(false), state: .constant(0))
    }
}
