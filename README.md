# WaIE


**Improvement Areas:**

1. A Theming Manager is useful to set all the UI objects across the App.
2. We can implement caching policy and cache eviction strategy for network layer and dB layer to improve the latency of both layers.
3. For low internet connectivity we can handle congestion control APIs and retry counts.
4. To avoid overwhelming the memory from the dB data we can perform dB faulting and memory pruning
5. We can add test suites to test the Application
6. We can perform dB purging to remove the historical data of the image. Same for the file system.
7. We can add NSOperation to split every API call and perform synchronous updates over operation Queue
8. We can perform compiler level optimization(whole module optimization)
9. To achieve high performing UI, we can implement the UI programatically and get rid of xib/storyboard
10. For App security we can implement SSL pinning, also we can use OCSP stapling(https://en.wikipedia.org/wiki/Salsa20), Also we can have SHA encryption for headers and other secure data
11. We can profile the application and remove memory cycles and slow running code 
