
#import "SoundBankPlayer.h"
#import "NAMIDI.h"
#import <AVFoundation/AVFoundation.h>

@interface DemoViewController : UIViewController
{
	SoundBankPlayer* player;
	NSTimer* timer;
	BOOL playingArpeggio;
	NSArray* arpeggioNotes;
	int arpeggioIndex;
	double arpeggioStartTime;
	double arpeggioDelay;
    AVAudioRecorder *recorder;
    AVAudioSession *audioSession;
    NSMutableArray *pedaledNotes;
}

- (IBAction)strumCMajorChord;
- (IBAction)arpeggiateCMajorChord;

- (IBAction)strumAMinorChord;
- (IBAction)arpeggiateAMinorChord;


- (IBAction)startBackgroundAndMidi;
- (IBAction)stopBackgroundAndMidi;

@property (nonatomic, strong) NAMIDI* midiHandler;
@property (nonatomic, assign) BOOL pedal;

@end
