//
//  NAMIDI.h
//  SimpleSynth
//
//  Created by Boris Bügling on 17.06.11.
//  Copyright 2011 - All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* kNAMIDINoteOnNotification = @"kNAMIDINoteOnNotification";
static NSString* kNAMIDINoteOffNotification = @"kNAMIDINoteOffNotification";

static NSString* kNAMIDIPedalOnNotification = @"kNAMIDIPedalOnNotification";
static NSString* kNAMIDIPedalOffNotification = @"kNAMIDIPedalOffNotification";

static NSString* kNAMIDINotification = @"kNAMIDINotification";

static NSString* kNAMIDI_NoteKey = @"kNAMIDI_NoteKey";
static NSString* kNAMIDI_VelocityKey = @"kNAMIDI_VelocityKey";

@interface NAMIDI : NSObject
@end