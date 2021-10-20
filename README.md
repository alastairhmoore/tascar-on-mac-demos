# tascar-on-mac-demos
A collection of resources to explore functionality of TASCAR.

At present, only the command line interface to TASCAR is available on macOS.  On linux there is a GUI and many more tools.

## Installation

On macOS we must build TASCAR for ourselves. Fortunately this is quite straightforward.

1. Install `homebrew` according to the instructions at [brew.sh](http://https://brew.sh/), i.e. run

    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
    
    and follow the prompts.

1. Install tascar's dependencies (this takes many minutes)

    ```
    brew install pkgconfig libxml2 glibmm libxml++ jack liblo libsndfile gtkmm3 eigen boost gsl fftw libsamplerate xerces-c cmake
    ``` 

1. Clone the tascar repository

    ```
    mkdir -p ~/git/gisogrimm &&  cd ~/git/gisogrimm &&  git clone https://github.com/gisogrimm/tascar.git
    ```

1. Build `tascar_cli`

    ```
    cd tascar && mkdir build && cd build && cmake -B . -S ../ && make
    ``` 

1. Make the executable visible to your system (N.B. to make this persistent add the line to the end of you `.bash_profile` file, or whatever is used to set up the environment on your system)

    ```
    export PATH=~/git/gisogrimm/tascar/build:$PATH
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


