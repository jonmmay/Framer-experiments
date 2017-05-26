In this prototype I experimented with blur layers but more importantly, "-webkit-mask" and "mix-blend-mode". It appears that Framer's default "blur" Layer property leverages the CSS "filter" style which doesn't quite meet my expectations or compare to iOS' blur and vibrancy effect. I played around with "-webkit-backdrop-filter" which looks nicer but I found that this didn't work on mobile.

It was still a really fun challenge and I'm impressed with Framer Studio's capabilities! One thing to note: there are many layers with varying degree of blurring and filtering which results in a less-than-performant experience.

![alt text](https://github.com/jonmmay/Framer-experiments/blob/master/iOS-lock-screen.framer/iOS-lock-screen.gif?raw=true "Gif")