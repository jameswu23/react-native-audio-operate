"use strict";
import { NativeModules,Platform } from "react-native";
const RNAudioOperate = Platform === 'android'? NativeModules.RNAudioOperateModule:NativeModules.RNAudioOperate

const AudioOperate = {
    mergeAudios: (paths,audioPath,cb)=>{
        RNAudioOperate.mergeAudios(paths,audioPath,cb)
    },
    audioPCMtoMP3:(path,audioPath,cb)=>{
        RNAudioOperate.audio_PCMtoMP3(paths,audioPath,cb)
    }

};
export default AudioOperate
