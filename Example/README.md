# PlugTop

This example demonstrates a simple implementation of a programmable plugtop.

The code exposes an (unsecured) API that allows for the following operations:
- **GET** /state - returns the current state of the relay (0 = off, 1 = on)
- **GET** /state/on - turns on the relay
- **GET** /state/off - turns off the relay
- **GET** /power - returns the KWH since last reset
- **GET** /power/reset - resets the KWH counter

This example uses the following libraries:

- [PL7223](https://github.com/electricimp/pl7223) - Driver class for the PL7223 power sensing IC.
- [Button](https://github.com/electricimp/button) - Driver class for a software debounced button.
- [LatchingRelay](https://github.com/electricimp/latchingrelay) - Driver class for a generic latching relay.
- [Rocky](https://github.com/electricimp/rocky) - Framework for building readable and extendable APIs.
- [Bullwinkle](https://github.com/electricimp/bullwinkle) - Framework for asyncronoush Agent <--> Device communication.
