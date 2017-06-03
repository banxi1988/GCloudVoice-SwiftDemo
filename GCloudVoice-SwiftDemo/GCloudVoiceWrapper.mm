//
//  GCloudVoiceWrapper.m
//  GCloudVoice-Swift
//
//  Created by Haizhen Lee on 01/06/2017.
//  Copyright © 2017 BetaGo. All rights reserved.
//

#import "GCloudVoiceWrapper.h"
#import "GCloudVoice.h"

typedef GCloudVoiceCompleteCode CompleteCode;

namespace gcloud_voice {

class GCloudVoiceNotifyImpl:public gcloud_voice::IGCloudVoiceNotify{
public:
  id<GCloudVoiceNotify> delegate;

  void OnJoinRoom(gcloud_voice::GCloudVoiceCompleteCode code, const char *roomName, int memberID){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnJoinRoom:(CompleteCode)code  roomName:roomName memberID:memberID];
  }

  void OnQuitRoom(GCloudVoiceCompleteCode code, const char *roomName){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnQuitRoom:(CompleteCode)code roomName:roomName];
  }

  void OnMemberVoice(const unsigned int *members, int count){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnMemberVoice:members count:count];
  }

  void OnUploadFile(GCloudVoiceCompleteCode code, const char *filePath, const char *fileID){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnUploadFile:(CompleteCode)code filePath:filePath fileID:fileID];
  }

  void OnDownloadFile(GCloudVoiceCompleteCode code, const char *filePath, const char *fileID){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnDownloadFile:(CompleteCode)code filePath:filePath fileID:fileID];
  }

  void OnPlayRecordedFile(GCloudVoiceCompleteCode code,const char *filePath){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnPlayRecordedFile:(CompleteCode)code filePath:filePath];
  }

  void OnApplyMessageKey(GCloudVoiceCompleteCode code){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnApplyMessageKey:(CompleteCode)code];
  }

  void OnSpeechToText(GCloudVoiceCompleteCode code, const char *fileID, const char *result){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnSpeechToText:(CompleteCode)code fileID:fileID result:result];
  }

  void OnRecording(const unsigned char* pAudioData, unsigned int nDataLength){
    if(delegate == NULL){
      NSLog(@"CGCloudVoiceNotify delegate was null");
      return;
    }
    [delegate OnRecording:pAudioData nDataLength:nDataLength];
  }
  
};

}


@implementation GCloudVoiceWrapper
-(instancetype)init{
  self = [super init];
  return self;
}

-(GCloudVoiceErrno)SetNotify:(id<GCloudVoiceNotify>)notify{
  gcloud_voice::GCloudVoiceNotifyImpl *impl = new gcloud_voice::GCloudVoiceNotifyImpl();
  impl->delegate = notify;
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->SetNotify(impl);
}

-(GCloudVoiceErrno)JoinTeamRoom:(const char *)roomName msTimeout:(int)msTimeout{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->JoinTeamRoom(roomName, msTimeout);
}

-(GCloudVoiceErrno)JoinNationalRoom:(const char *)roomName role:(GCloudVoiceMemberRole)role msTimeout:(int)msTimeout{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->JoinNationalRoom(roomName, (gcloud_voice::IGCloudVoiceEngine::GCloudVoiceMemberRole)role, msTimeout);
}

-(GCloudVoiceErrno)QuitRoom:(const char *)roomName msTimeout:(int)msTimeout{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->QuitRoom(roomName, msTimeout);
}

-(GCloudVoiceErrno)OpenMic{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->OpenMic();
}

-(GCloudVoiceErrno)Poll{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->Poll();
}


-(GCloudVoiceErrno)CloseMic{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->CloseMic();
}

-(GCloudVoiceErrno)setServerInfo:(const char *)URL{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->SetServerInfo(URL);
}

-(GCloudVoiceErrno)Pause{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->Pause();
}

-(GCloudVoiceErrno)Resume{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->Resume();
}

-(GCloudVoiceErrno)OpenSpeaker{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->OpenSpeaker();
}

-(GCloudVoiceErrno)CloseSpeaker{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->CloseSpeaker();
}


-(GCloudVoiceErrno)SetMaxMessageLength:(int)msTime{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->SetMaxMessageLength(msTime);
}


-(GCloudVoiceErrno)SetAppInfo:(const char *)appID appKey:(const char *)appKey openID:(const char *)openID{
  return  (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->SetAppInfo(appID, appKey, openID);
}

-(GCloudVoiceErrno)TryInit{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->Init();
}

-(GCloudVoiceErrno)SetMode:(GCloudVoiceMode)mode{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->SetMode((gcloud_voice::IGCloudVoiceEngine::GCloudVoiceMode) mode);
}

-(GCloudVoiceErrno)ApplyMessageKey:(int)msTimeout{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->ApplyMessageKey(msTimeout);
}

-(GCloudVoiceErrno)StartRecording:(const char *)filePath{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->StartRecording(filePath);
}

-(GCloudVoiceErrno)StopRecording{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->StopRecording();
}

-(GCloudVoiceErrno)UploadRecordedFile:(const char *)filePath msTimeout:(int)msTimeout{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->UploadRecordedFile(filePath, msTimeout);
}

-(GCloudVoiceErrno)DownloadRecordedFile:(const char *)fileID downloadFilePath:(const char *)downloadFilePath msTimeout:(int)msTimeout{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->DownloadRecordedFile(fileID, downloadFilePath, msTimeout);
}

-(GCloudVoiceErrno)PlayRecordedFile:(const char *)downloadFilePath{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->PlayRecordedFile(downloadFilePath);
}

-(GCloudVoiceErrno)StopPlayFile{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->StopPlayFile();
}


-(GCloudVoiceErrno)SpeechToText:(const char *)fileID msTimeout:(int)msTimeout language:(GCloudLanguage)language{
  return (GCloudVoiceErrno)gcloud_voice::GetVoiceEngine()->SpeechToText(fileID, msTimeout, (gcloud_voice::IGCloudVoiceEngine::GCloudLanguage)language);
}

@end
