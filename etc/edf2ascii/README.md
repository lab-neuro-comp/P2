# PROTOLIZE!2 Support for EDF files

This section aims to generate support by [Protolize!2](https://github.com/ishiikurisu/P2) for EDF files using code that is already made here in [this repository](https://github.com/ishiikurisu/EEG). 

Approaches
----------

We will try two different approaches here:

1. Use the JNI to call the C/C++ and Go code we wrote from MATLAB.
2. Generate binaries to be called from MATLAB.

Since PROTOLIZE!2 only deals with one signal record at a time, we will have to write a MATLAB snippet to separate the channels' names and enable the user to choose only one channel at a time.