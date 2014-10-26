Code book for the Course Project in JHU's Getting and Cleaning Data course
==========================================================================

There are 30 different subjects (numbered 1-30) and 6 activities: standing, sitting, lying down, walking, walking downstairs and walking upstairs. For each subject/activity pair all measurements are averaged for each variable. The 66 variables are as follows:

* The first twelve measurements relate to the acceleration. The raw signal from the accelerometer was filtered using a low pass Butterworth filter to separate the body and gravity acceleration signals. The mean and standard deviations for each spatial component are included.

* Measurements 13-18 pertain to the time derivative of the body acceleration, or body jerk. 

* Measurements 19-24 relate to the angular velocity, which comes from the gyroscope signals.

* Measurements 25-30 come from the time derivative of the angular velocity, or gyroscopic jerk.

* Measurements 31-40 are the mean and standard deviation of the *magnitudes* of the preceding five measurements (body and gravity acceleration, body jerk, angular velocity and gyroscopic jerk).

* Measurements 41-58 are the frequency domain numbers (obtained using a fast Fourier transform) of the body acceleration, body jerk and angular velocity.

* Measurements 59-66 are the mean and standard deviation of the magnitudes of the FFT-ed body acceleration, body jerk, angular velocity and gyroscopic jerk.
