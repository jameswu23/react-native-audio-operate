"use strict";
import { NativeModules } from "react-native";
const RNAudioOperate = NativeModules.RNAudioOperateModule

const AudioOperate = {
    mergeAudios: (paths,audioPath,cb)=>{
        RNAudioOperate.mergeAudios(paths,audioPath,cb)
    },
    audioPCMtoMP3:(path,audioPath,cb)=>{
        RNAudioOperate.audio_PCMtoMP3(paths,audioPath,cb)
    }

};
export default AudioOperate
