# Problem Understanding
Electrocardiogram (ECG) is a medical device that produces timeseries data that represents the heart beat's power. The device mined data by placing electrodes in several points of the body. Electrode works by detecting the small electrical changes that are a consequence of heart muscle's contraction. But since it is placed on the skin's surface, it could have some *signal noises* produced by fractions of skin and electrodes. For the noise matter, there are also another problem caused by electrical power line.

## Data Characteristics
The data (or we call it *signal* in biomedical engineering field) of ECG is a timeseries of *electrical current* produces by the constraction of cardiac (heart) muscle. 

Looking at the data's morphological characteristic (how the data looks in our bare eyes), there are a specific pattern of ECG data in one heart-beat cycle:
[Image here]

Now that the pattern is pretty obvious in a stable and ideal condition, for most of the field experience, there are tons of noises that could occur in one ECG data-mining.

The electrical power line to power the ECG has a base frequency varies in countries. In Indonesia, the electrical power line produces a constant 60 Hz frequency. Therefore, the ECG streamed data could be interfered by this kind of noise called *Power-Line Interference* or PLI. 

## Power-Line Interference (PLI)
The PLI noise is only a sinusoidal signal of 50-60 Hz. In the real field case, it comes from electric outlet. This PLI noise is the one that I intend to exclude from the ECG timeseries data.
[Image here]

## Proposed Solution
In the signal processing field, there are method to eliminate certain noises called **filters** that could cut some types of signal patterns based on what we need. There are types of *finite impulse response* filters such as *low-pass filter* that will allow the lower frequency to pass, *high-pass filter* that will (yes you're right) allow the higher frequency to pass, and *band-pass filter* to allow a range of frequency to pass. They are called *finite* because the limits are set-up initially for a certain duration. 

There is also *infinite impulse response* filters that are adaptable to a more complex pattern and will try to response *infinitely* to the data.
 
In this case, I will use both of the filters type.

## Dataset
For this project, I used the dataset provided from [Here (Chapter 8's Resources)](https://www.elsevier.com/books-and-journals/book-companion/9780128093955) with *.m format* files (matlab files). There are *ECG noise* data which are ECG with PLI noises added. 
