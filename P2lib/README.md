# Protolize Lib

This is the library containing all tools written to make Protolize run. This is basically a MATLAB toolbox for dealing with common signal and text processing procedures. It also ships with a [simple EDF library](https://github.com/ishiikurisu/JEDF) written in pure Java to populate some of our tools.

## Functions ##

The functions here are divided into two folders (math and util) plus the EDF jar. For problems related to the EDF jar, please relate to the [JEDF documentation](https://github.com/ishiikurisu/JEDF).

### Math ###

#### Signal tools ####

There are some general functions to help you deal with your signal, like `chop_signal` and `calculate_power`.

#### Filters ####

This library comes with `lowpass`, `highpass`, `bandpass`, and `bandstop` functions to filter a signal using regular box filters.

#### Transforms ####

For a better understanding of your signal, the provided functions `calcstft`, `wavelets_transform` , and `inverse_wavelets_transform` bring your signal to other domains and representations.


### Util ###

Here we can find functions to deal with text and data structures more easily.
