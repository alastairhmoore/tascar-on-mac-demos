# tascar-on-mac-demos
A collection of resources to explore functionality of TASCAR.

Previously, only the command line interface to TASCAR was available on macOS.  Now most of the Linux tools are available.  Note that the build system has changed from `cmake` to `make`.

## Installation

On macOS we must build TASCAR for ourselves. Fortunately this is quite straightforward. 

1. Install `homebrew` according to the instructions at [brew.sh](http://https://brew.sh/), i.e. run

    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
    
    and follow the prompts.

1. Install tascar's dependencies (this takes many minutes)

    ```
    brew install pkgconfig libxml2 glibmm libxml++ jack liblo libsndfile gtkmm3 eigen boost gsl fftw libsamplerate xerces-c libltc gtksourceviewmm3 coreutils adwaita-icon-them
    ``` 

1. Clone the tascar repository

    ```
    mkdir -p ~/git/gisogrimm &&  cd ~/git/gisogrimm &&  git clone https://github.com/gisogrimm/tascar.git
    ```

1. Build all the targets

    ```
    cd tascar
    make
    ``` 

1. Install to the default location (requires elevated permissions)

    ```
    sudo make install
    ```


## Start jack

TASCAR uses the jack audio toolkit to route audio and, specifically, access the computer sound card.  Assuming the installation above was successful, start jack with 48 kHz sample rate and buffer size 64.  This is relatively short but ensures low latency processing.

```
jackd -d coreaudio -r 48000 -p 64
```

Since `jackd` keeps running the terminal window is now "used up" so you'll need to open another one to continue.  In principle you can run `jackd` in the background, but I find it quite helpful to have the terminal output available in case things go wrong.

## Demo 1

Generate some pink noise in the first audio channel (left headphone)
```
tascar_cli demo_01_pink.tsc
```


## Demo 2
Use the `hrtf` receiver type to give a binaural output. Listen on headphones!

```
tascar_cli demo_02_pink_hrtf.tsc
```
The `hrtf` reciever uses a spherical head model to get the main interaural cues and 3 parametric filters to simulate pinna effects of elevation.


## Demo 3
Spatialisation is more aparent when the source moves. Here we demonstrate source movement using the `<position />` property of the source.

```
tascar_cli demo_03_moving_source.tsc
```

## Demo 4

Spatialisation is also aparent when the receiver (your head) moves.  In this example a csv file provides the input to `<orientation />` property of the receiver.

### 4a - hrtf receiver

Using the same approach as before. The head rotates to look increasingly left such that the source appears to move increasing right. (i.e. source appears to move clockwise around the head when viewed from top looking down)

```
tascar_cli demo_04a_rotating_receiver_hrtf.tsc
```

### 4b - vbap receiver

Virtual speaker based renering can either be used to feed a real loudspeaker array, or as in our case, to be convolved with head-related impulse responses.  In this way, the convolution imparts the spatial cues allowing us to simulate an arbitrary array.  The layout of the virtual speakers is given in a `.spk` file.

Convolution is achieved using `jconvolver`. On Ubuntu this is available using `sudo apt install jconvolver`.  On macOS installing a (prebuilt binary)[http://www.matthiaskronlachner.com/?p=1515] of an older version is the easiest option.

The impulse responses and the jconvolver conifiguration are saved in the `demo_04_data` folder. 


```
tascar_cli demo_04a_rotating_receiver_hrtf.tsc
```
