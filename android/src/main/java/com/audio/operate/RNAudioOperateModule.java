package com.audio.operate;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import android.util.Log;

import com.coremedia.iso.boxes.Container;
import com.googlecode.mp4parser.authoring.Movie;
import com.googlecode.mp4parser.authoring.Track;
import com.googlecode.mp4parser.authoring.builder.DefaultMp4Builder;
import com.googlecode.mp4parser.authoring.container.mp4.MovieCreator;
import com.googlecode.mp4parser.authoring.tracks.AppendTrack;

import java.io.File;
import java.io.FileOutputStream;




public class RNAudioOperateModule extends ReactContextBaseJavaModule {
  private static ReactApplicationContext reactContext;

  public RNAudioOperateModule(ReactApplicationContext context) {
    super(context);
    this.reactContext = context;

  }
  @Override
  public String getName() {
    return "RNAudioOperateModule";
  }

  @ReactMethod
  public void mergeAudios(String pathStrings, String finthPath,final Callback promise) {
    List<String> aacPathList = Arrays.asList(pathStrings.split(","));
    appendAacList(aacPathList, finthPath,promise);
  }

  public static void appendAacList(List<String> fileList, String outPutPath,final Callback promise) {
    List<Movie> movieList = new ArrayList<>();
    try {
      for (String file : fileList) {
        movieList.add(MovieCreator.build(file));
      }
      List<Track> audioTracks = new LinkedList<>();
      for (Movie m : movieList) {
        for (Track t : m.getTracks()) {
          if (t.getHandler().equals("soun")) {
            audioTracks.add(t);
          }
        }
      }
      Movie outMovie = new Movie();
      if (audioTracks.size() > 0) {
        outMovie.addTrack(new AppendTrack(audioTracks.toArray(new Track[audioTracks.size()])));
      }

      Container mp4file = new DefaultMp4Builder().build(outMovie);
      File resultFile = new File(outPutPath);
      if (resultFile.exists() && resultFile.isFile()) {
        resultFile.delete();
      }
      FileOutputStream os = new FileOutputStream(resultFile);
      mp4file.writeContainer(os.getChannel());
      os.close();
      Log.e("音频", "joinAudio: 合成完毕");
      movieList.clear();
      Log.e("合并===成功", resultFile.getPath());
      promise.invoke("success");
    } catch (IOException e) {
      Log.e("合并===失败", e.toString());
      e.printStackTrace();
      promise.invoke("failure");
    }
  }

}
