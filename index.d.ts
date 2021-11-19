declare module RNAudioOperateModule {
    /**
     * 
     * @param paths audioPaths的集合string
     * @param audioPath 最终地址
     * @param cb 是否成功返回
     */
     export function mergeAudios(paths:string,audioPath:string,cb:(success:string)=>void): void

     /**
      * audio转m4a转mp3
      * @param path m4a地址
      * @param audioPath 最终地址
      * @param cb 
      */
     export function audioPCMtoMP3(path:string,audioPath:string,cb:(success:string)=>void): void
  }
  
export default RNAudioOperateModule;
  