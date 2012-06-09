
// The sounds in this demo project were taken from Fluid R3 by Frank Wen,
// a freely distributable SoundFont.

#import <QuartzCore/CABase.h>
#import "DemoViewController.h"

@interface DemoViewController ()
- (void)playArpeggioWithNotes:(NSArray*)notes delay:(double)delay;
- (void)startTimer;
- (void)stopTimer;
@end

@implementation DemoViewController
@synthesize midiHandler,pedal;

- (id)initWithCoder:(NSCoder*)decoder
{
	if ((self = [super initWithCoder:decoder]))
	{
		playingArpeggio = NO;
        pedaledNotes = [NSMutableArray array];
        
		// Create the player and tell it which sound bank to use.
		player = [[SoundBankPlayer alloc] init];
		[player setSoundBank:@"Piano"];

        self.midiHandler = [[NAMIDI alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiNotePlayed:) name:kNAMIDINoteOnNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiNoteStopped:) name:kNAMIDINoteOffNotification 
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiPedalDown:) name:kNAMIDIPedalOnNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midiPedalUp:) name:kNAMIDIPedalOffNotification 
                                                   object:nil];
        
        
        // Important for background mode
        audioSession = [AVAudioSession sharedInstance];
        NSError *err = nil;
        [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
        
//        If you use this you get the red 'recording' statusbar. Maybe you want that:
//
//        NSString *fileName = @"test.aiff";
//        NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        
//        NSString *soundFile = [docsDir stringByAppendingPathComponent:fileName];
//        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFile];
//
//        
//        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
//        // We can use kAudioFormatAppleIMA4 (4:1 compression) or kAudioFormatLinearPCM for nocompression
//        [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
//        // We can use 44100, 32000, 24000, 16000 or 12000 depending on sound quality
//        [recordSettings setValue:[NSNumber numberWithFloat:12000.0] forKey:AVSampleRateKey];        
//        // We can use 2(if using additional h/w) or 1 (iPhone only has one microphone)
//        [recordSettings setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
//                
//        NSError *error = nil;
//        
//        recorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSettings error:&error];		
//        [recorder prepareToRecord];

        // We use a timer to play arpeggios.
		[self startTimer];
	}
	return self;
}

- (IBAction)startBackgroundAndMidi
{
    [audioSession setActive:YES error:nil];

    self.midiHandler = [[NAMIDI alloc] init];
    
//    [recorder record]; if you want the recording statusbar
}

- (IBAction)stopBackgroundAndMidi
{
    [audioSession setActive:NO error:nil];

//    Disable red statusbar
//    
//    [recorder stop];
//    NSString *fileName = @"test.aiff";
//    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    
//    NSString *soundFile = [docsDir stringByAppendingPathComponent:fileName];
//    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFile];
//
//    [[NSFileManager defaultManager] removeItemAtURL:soundFileURL error:nil];
}

- (void)midiNotePlayed:(NSNotification*)notification
{
    int notePlayed = [[notification.userInfo objectForKey:kNAMIDI_NoteKey] intValue];
    int velocity = [[notification.userInfo objectForKey:kNAMIDI_VelocityKey] intValue];
    float gain = velocity / (127.0f / 0.5f); // max gain = 0.5f
        
    [pedaledNotes removeObject:[NSNumber numberWithInt:notePlayed]];
    
    [player noteOn:notePlayed gain:gain];
}

- (void)midiNoteStopped:(NSNotification*)notification
{
    int notePlayed = [[notification.userInfo objectForKey:kNAMIDI_NoteKey] intValue];
    
    if(!self.pedal)
    {
        [player noteOff:notePlayed];
    }
    else {
        [pedaledNotes addObject:[NSNumber numberWithInt:notePlayed]];
    }
}

- (void)midiPedalDown:(NSNotification*)notification
{
    self.pedal = YES;
}

- (void)midiPedalUp:(NSNotification*)notification
{
    self.pedal = NO;
    
    for(NSNumber *noteNum in pedaledNotes)
    {
        [player noteOff:[noteNum intValue]];
    }
}

- (void)dealloc
{
	[self stopTimer];

}

- (IBAction)strumCMajorChord
{
	[player queueNote:48 gain:0.4f];
	[player queueNote:55 gain:0.4f];
	[player queueNote:64 gain:0.4f];
	[player playQueuedNotes];
}

- (IBAction)arpeggiateCMajorChord
{
	NSArray* notes = [NSArray arrayWithObjects:
			[NSNumber numberWithInt:48],
			[NSNumber numberWithInt:55],
			[NSNumber numberWithInt:64],
			nil];

	[self playArpeggioWithNotes:notes delay:0.05];
}

- (IBAction)strumAMinorChord
{
	[player queueNote:45 gain:0.4f];
	[player queueNote:52 gain:0.4f];
	[player queueNote:60 gain:0.4f];
	[player queueNote:67 gain:0.4f];
	[player playQueuedNotes];
}

- (IBAction)arpeggiateAMinorChord
{
	NSArray* notes = [NSArray arrayWithObjects:
			[NSNumber numberWithInt:33],
			[NSNumber numberWithInt:45],
			[NSNumber numberWithInt:52],
			[NSNumber numberWithInt:60],
			[NSNumber numberWithInt:67],
			nil];

	[self playArpeggioWithNotes:notes delay:0.1];
}

- (void)playArpeggioWithNotes:(NSArray*)notes delay:(double)delay
{
	if (!playingArpeggio)
	{
		playingArpeggio = YES;
		arpeggioNotes = notes;
		arpeggioIndex = 0;
		arpeggioDelay = delay;
		arpeggioStartTime = CACurrentMediaTime();
	}
}

- (void)startTimer
{
	timer = [NSTimer scheduledTimerWithTimeInterval: 0.05  // 50 ms
											 target: self
										   selector: @selector(handleTimer:)
										   userInfo: nil
											repeats: YES];
}

- (void)stopTimer
{
	if (timer != nil && [timer isValid])
	{
		[timer invalidate];
		timer = nil;
	}
}

- (void)handleTimer:(NSTimer*)timer
{
	if (playingArpeggio)
	{
		// Play each note of the arpeggio after "arpeggioDelay" seconds.
		double now = CACurrentMediaTime();
		if (now - arpeggioStartTime >= arpeggioDelay)
		{
			NSNumber* number = (NSNumber*)[arpeggioNotes objectAtIndex:arpeggioIndex];
			[player noteOn:[number intValue] gain:0.4f];

			++arpeggioIndex;
			if (arpeggioIndex == [arpeggioNotes count])
			{
				playingArpeggio = NO;
				arpeggioNotes = nil;
			}
			else  // schedule next note
			{
				arpeggioStartTime = now;
			}
		}
	}
}

@end
