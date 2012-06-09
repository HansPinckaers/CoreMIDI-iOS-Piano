iOS – Piano with CoreMIDI support
================================

Included features
-----------------
* CoreMIDI (only tested with CCK, on iPad)
	* Velocity support
	* Pedal support
* Multiple sounds for different velocities
* Test piano sound buttons
* Background multitasking support, so you can read sheet music from a PDF viewer.

How to use
----------
1. Start the app on your iPad, 
2. Connect a CoreMIDI supported keyboard with the CCK
3. Tap on "Start background / MIDI"
4. Start playing!

Kudos to
--------
* Original project by Matthijs Hollemans [blog post](http://www.hollance.com/2011/02/soundbankplayer-using-openal-to-play-musical-instruments-in-your-ios-app/)
* CoreMIDI example by Boris Bügling [http://vu0.org/audio/]()
* NSLogger for debugging with keyboard connected to iPad – Florent Pillet [NSLogger github repo](https://github.com/fpillet/NSLogger)
* Soundfont by Roberto Gordo Saez [License](http://freepats.zenvoid.org/sf2/acoustic_grand_piano_ydp_20080910.txt) / [Link to download](http://freepats.zenvoid.org/sf2/acoustic_grand_piano_ydp_20080910.sf2])

This is a sample-based audio player that uses OpenAL. A "sound bank" can have 
multiple samples, each covering one or more notes. This allows you to implement 
a full instrument with only a few samples (like SoundFonts but simpler).

Sound files copyright:

	Copyright 2008, Roberto Gordo Saez <roberto.gordo@gmail.com>
	Creative Commons Attribution 3.0 license
	http://creativecommons.org/licenses/by/3.0/