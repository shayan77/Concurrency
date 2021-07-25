# Concurrency

Concurrency means multiple computations are happening at the same time. Concurrency is everywhere in modern programming, whether we like it or not:
Multiple computers in a network
Multiple applications running on one computer
Multiple processors in a computer (today, often multiple processor cores on a single chip)

In fact, concurrency is essential in modern programming:
Web sites must handle multiple simultaneous users.
Mobile apps need to do some of their processing on servers ("in the cloud").
Graphical user interfaces almost always require background work that does not interrupt the user. For example, Eclipse compiles your Java code while you're still editing it.

Being able to program with concurrency will still be important in the future. Processor clock speeds are no longer increasing. Instead, we're getting more cores with each new generation of chips. So in the future, in order to get a computation to run faster, we'll have to split up a computation into concurrent pieces. 
So before starting writing any concurrency code, think first why do you need concurrency and which API do you need to use to solve this problem? In iOS we have different APIs that can be used. In this tutorial we will talk about two of the most commonly used APIs - Operation and Dispatch Queues.
